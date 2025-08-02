import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

class ImageCompressionHelper {
  static const int _maxFileSizeInBytes = 1024 * 1024; // 1MB
  static const int _maxQuality = 80;
  static const int _minQuality = 10;

  /// Görseli sıkıştırır ve 1MB'dan küçük hale getirir
  static Future<File?> compressImage(File imageFile) async {
    try {
      // Dosya boyutunu kontrol et
      final int fileSize = await imageFile.length();
      print(
        'Original file size: ${(fileSize / 1024 / 1024).toStringAsFixed(2)} MB',
      );

      // Eğer dosya zaten 1MB'dan küçükse, sıkıştırmaya gerek yok
      if (fileSize <= _maxFileSizeInBytes) {
        print('File is already smaller than 1MB, no compression needed');
        return imageFile;
      }

      // Geçici dizin al
      final Directory tempDir = await getTemporaryDirectory();
      final String fileName = path.basename(imageFile.path);
      final String compressedFileName = 'compressed_$fileName';
      final String compressedFilePath = path.join(
        tempDir.path,
        compressedFileName,
      );

      // Sıkıştırma kalitesini hesapla
      int quality = _calculateQuality(fileSize);

      // Görseli sıkıştır
      final File? compressedFile = await _compressImageFile(
        imageFile,
        compressedFilePath,
        quality,
        1024,
        1024,
      );

      if (compressedFile != null) {
        final int compressedFileSize = await compressedFile.length();
        print(
          'Compressed file size: ${(compressedFileSize / 1024 / 1024).toStringAsFixed(2)} MB',
        );
        print('Compression quality used: $quality');

        // Eğer hala 1MB'dan büyükse, daha agresif sıkıştırma yap
        if (compressedFileSize > _maxFileSizeInBytes && quality > _minQuality) {
          return await _aggressiveCompression(compressedFile);
        }

        return compressedFile;
      }

      return null;
    } catch (e) {
      print('Image compression error: $e');
      return null;
    }
  }

  /// Flutter'ın kendi API'leri ile görsel sıkıştırma
  static Future<File?> _compressImageFile(
    File imageFile,
    String outputPath,
    int quality,
    int maxWidth,
    int maxHeight,
  ) async {
    try {
      // Görseli yükle
      final Uint8List bytes = await imageFile.readAsBytes();
      final ui.Codec codec = await ui.instantiateImageCodec(
        bytes,
        targetWidth: maxWidth,
        targetHeight: maxHeight,
      );
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      final ui.Image image = frameInfo.image;

      // Görseli yeniden boyutlandır
      final ui.PictureRecorder recorder = ui.PictureRecorder();
      final Canvas canvas = Canvas(recorder);

      final double scaleX = maxWidth / image.width;
      final double scaleY = maxHeight / image.height;
      final double scale = scaleX < scaleY ? scaleX : scaleY;

      final double scaledWidth = image.width * scale;
      final double scaledHeight = image.height * scale;

      canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromLTWH(0, 0, scaledWidth, scaledHeight),
        Paint(),
      );

      final ui.Picture picture = recorder.endRecording();
      final ui.Image resizedImage = await picture.toImage(
        scaledWidth.toInt(),
        scaledHeight.toInt(),
      );

      // PNG formatında kaydet
      final ByteData? byteData = await resizedImage.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData != null) {
        final Uint8List pngBytes = byteData.buffer.asUint8List();

        // Dosyayı kaydet
        final File outputFile = File(outputPath);
        await outputFile.writeAsBytes(pngBytes);

        return outputFile;
      }

      return null;
    } catch (e) {
      print('_compressImageFile error: $e');
      return null;
    }
  }

  /// Agresif sıkıştırma işlemi
  static Future<File?> _aggressiveCompression(File imageFile) async {
    try {
      final Directory tempDir = await getTemporaryDirectory();
      final String fileName = path.basename(imageFile.path);
      final String aggressiveFileName = 'aggressive_$fileName';
      final String aggressiveFilePath = path.join(
        tempDir.path,
        aggressiveFileName,
      );

      // Çok düşük kalite ile sıkıştır
      final File? aggressiveCompressedFile = await _compressImageFile(
        imageFile,
        aggressiveFilePath,
        _minQuality,
        800,
        800,
      );

      if (aggressiveCompressedFile != null) {
        final int aggressiveFileSize = await aggressiveCompressedFile.length();
        print(
          'Aggressive compressed file size: ${(aggressiveFileSize / 1024 / 1024).toStringAsFixed(2)} MB',
        );

        // Eğer hala büyükse, boyutu da küçült
        if (aggressiveFileSize > _maxFileSizeInBytes) {
          return await _resizeImage(aggressiveCompressedFile);
        }

        return aggressiveCompressedFile;
      }

      return null;
    } catch (e) {
      print('Aggressive compression error: $e');
      return null;
    }
  }

  /// Görsel boyutunu küçült
  static Future<File?> _resizeImage(File imageFile) async {
    try {
      final Directory tempDir = await getTemporaryDirectory();
      final String fileName = path.basename(imageFile.path);
      final String resizedFileName = 'resized_$fileName';
      final String resizedFilePath = path.join(tempDir.path, resizedFileName);

      // Çok küçük boyut ve düşük kalite ile sıkıştır
      final File? resizedFile = await _compressImageFile(
        imageFile,
        resizedFilePath,
        _minQuality,
        600,
        600,
      );

      if (resizedFile != null) {
        final int resizedFileSize = await resizedFile.length();
        print(
          'Resized file size: ${(resizedFileSize / 1024 / 1024).toStringAsFixed(2)} MB',
        );
        return resizedFile;
      }

      return null;
    } catch (e) {
      print('Image resize error: $e');
      return null;
    }
  }

  /// Sıkıştırma kalitesini hesapla
  static int _calculateQuality(int fileSizeInBytes) {
    final double fileSizeInMB = fileSizeInBytes / 1024 / 1024;

    if (fileSizeInMB <= 2) {
      return 70;
    } else if (fileSizeInMB <= 5) {
      return 60;
    } else if (fileSizeInMB <= 10) {
      return 50;
    } else {
      return 40;
    }
  }

  /// Dosya boyutunu MB cinsinden döndürür
  static Future<double> getFileSizeInMB(File file) async {
    final int fileSize = await file.length();
    return fileSize / 1024 / 1024;
  }

  /// Dosya boyutunu formatlı string olarak döndürür
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(bytes / 1024 / 1024).toStringAsFixed(1)} MB';
    }
  }
}
