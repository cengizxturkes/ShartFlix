import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_dimens/app_dimens.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/repositories/user/user_repository.dart';
import 'package:my_app/router/route_config.dart';
import 'package:my_app/utils/image_compression_helper.dart';

import 'package:my_app/widgets/buttons/app_buttons.dart';
import 'package:my_app/widgets/photo_selection_modal/photo_selection_modal.dart';
import 'package:permission_handler/permission_handler.dart';

class AddPhotoPage extends StatefulWidget {
  const AddPhotoPage({super.key});

  @override
  State<AddPhotoPage> createState() => _AddPhotoPageState();
}

class _AddPhotoPageState extends State<AddPhotoPage> {
  final ImagePicker _picker = ImagePicker();
  late UserRepository userRepo;
  File? selectedImage;
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    userRepo = RepositoryProvider.of<UserRepository>(context);
  }

  Future<void> _handleContinue() async {
    if (selectedImage == null) return;

    setState(() {
      isUploading = true;
    });

    try {
      await uploadPhoto(selectedImage!);
    } finally {
      if (mounted) {
        setState(() {
          isUploading = false;
        });
      }
    }
  }

  Future<void> uploadPhoto(File file) async {
    try {
      // Görseli sıkıştır
      final File? compressedFile = await ImageCompressionHelper.compressImage(
        file,
      );

      if (compressedFile == null) {
        if (mounted) {
          Flushbar(
            message: 'Görsel sıkıştırılırken hata oluştu',
            flushbarStyle: FlushbarStyle.FLOATING,
            margin: EdgeInsets.only(top: 100.h, left: 16.w, right: 16.w),
            borderRadius: BorderRadius.circular(10.r),
            flushbarPosition: FlushbarPosition.TOP,
            icon: const Icon(
              Icons.error_outline,
              size: 28.0,
              color: Colors.white,
            ),
            titleColor: Colors.white,
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.redAccent,
          ).show(context);
        }
        return;
      }

      // Sıkıştırılmış dosya boyutunu kontrol et
      final double fileSizeMB = await ImageCompressionHelper.getFileSizeInMB(
        compressedFile,
      );
      print('Compressed file size: ${fileSizeMB.toStringAsFixed(2)} MB');

      // API'ye gönder
      final response = await userRepo.uploadProfilePhoto(compressedFile);
      print('response: $response');

      if (mounted) {
        Flushbar(
          message: 'Profil fotoğrafı başarıyla yüklendi',
          flushbarStyle: FlushbarStyle.FLOATING,
          margin: EdgeInsets.only(top: 100.h, left: 16.w, right: 16.w),
          borderRadius: BorderRadius.circular(10.r),
          flushbarPosition: FlushbarPosition.TOP,
          icon: const Icon(
            Icons.check_circle_outline,
            size: 28.0,
            color: Colors.white,
          ),
          titleColor: Colors.white,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
        ).show(context);

        context.pushNamed(AppRouter.profileDetail);
      }
    } catch (e) {
      print('Upload error: $e');
      if (mounted) {
        Flushbar(
          message: 'Fotoğraf yüklenirken hata oluştu',
          flushbarStyle: FlushbarStyle.FLOATING,
          margin: EdgeInsets.only(top: 100.h, left: 16.w, right: 16.w),
          borderRadius: BorderRadius.circular(10.r),
          flushbarPosition: FlushbarPosition.TOP,
          icon: const Icon(
            Icons.error_outline,
            size: 28.0,
            color: Colors.white,
          ),
          titleColor: Colors.white,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.loginPagePadding,
          ),
          child: AppButton(
            title: "Devam Et",
            onPressed:
                selectedImage != null && !isUploading ? _handleContinue : null,
            isLoading: isUploading,
            isEnabled: selectedImage != null && !isUploading,
          ),
        ),
      ),
      appBar: AppBar(title: Text('profileDetail'.tr())),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.loginPagePadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Fotoğrafınızı seçiniz', style: AppTextStyle.whiteS18SemiBold),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimens.addPhotoPageTextPadding,
              ),
              child: Text(
                'Resources out incentivize relaxation floor loss cc.',
                style: AppTextStyle.whiteS12Regular.copyWith(fontSize: 13.sp),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 47.h),
            GestureDetector(
              onTap: _showPhotoSelectionModal,
              child: Container(
                height: 168.95.h,
                width: 164.3.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 1.55,
                  ),
                  borderRadius: BorderRadius.circular(31.0),
                ),
                child:
                    selectedImage != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(31.0),
                          child: Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                            width: 164.3.w,
                            height: 168.95.h,
                          ),
                        )
                        : Icon(
                          Icons.add,
                          color: AppColors.white.withValues(alpha: 0.5),
                        ),
              ),
            ),
            if (selectedImage != null) ...[
              SizedBox(height: 16.h),
              FutureBuilder<double>(
                future: ImageCompressionHelper.getFileSizeInMB(selectedImage!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final double sizeMB = snapshot.data!;
                    return Text(
                      'Dosya boyutu: ${sizeMB.toStringAsFixed(2)} MB',
                      style: AppTextStyle.whiteS12Regular.copyWith(
                        color: sizeMB > 1.0 ? Colors.orange : Colors.green,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showPhotoSelectionModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => PhotoSelectionModal(
            onCameraTap: _handleCameraTap,
            onGalleryTap: _handleGalleryTap,
          ),
    ).then((value) {
      print('value: $value');
    });
  }

  Future<void> _handleCameraTap() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (photo != null) {
        print('Camera photo selected: ${photo.path}');
        final File imageFile = File(photo.path);

        // Orijinal dosya boyutunu göster
        final double originalSizeMB =
            await ImageCompressionHelper.getFileSizeInMB(imageFile);
        print('Original file size: ${originalSizeMB.toStringAsFixed(2)} MB');

        // Seçilen görseli state'e kaydet
        setState(() {
          selectedImage = imageFile;
        });
      }
    } catch (e) {
      print('Camera error: $e');
      if (mounted) {
        Flushbar(
          message: 'Kamera açılırken hata oluştu',
          flushbarStyle: FlushbarStyle.FLOATING,
          margin: EdgeInsets.only(top: 100.h, left: 16.w, right: 16.w),
          borderRadius: BorderRadius.circular(10.r),
          flushbarPosition: FlushbarPosition.TOP,
          icon: const Icon(
            Icons.error_outline,
            size: 28.0,
            color: Colors.white,
          ),
          titleColor: Colors.white,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
        ).show(context);
      }
    }
  }

  Future<void> _handleGalleryTap() async {
    // Debug: Check current permission status for iOS
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      await _debugPermissionStatus();
    }

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        print('Gallery image selected: ${image.path}');
        final File imageFile = File(image.path);

        // Orijinal dosya boyutunu göster
        final double originalSizeMB =
            await ImageCompressionHelper.getFileSizeInMB(imageFile);
        print('Original file size: ${originalSizeMB.toStringAsFixed(2)} MB');

        // Seçilen görseli state'e kaydet
        setState(() {
          selectedImage = imageFile;
        });
      }
    } catch (e) {
      print('Gallery error: $e');
      if (mounted) {
        Flushbar(
          message: 'Galeri açılırken hata oluştu',
          flushbarStyle: FlushbarStyle.FLOATING,
          margin: EdgeInsets.only(top: 100.h, left: 16.w, right: 16.w),
          borderRadius: BorderRadius.circular(10.r),
          flushbarPosition: FlushbarPosition.TOP,
          icon: const Icon(
            Icons.error_outline,
            size: 28.0,
            color: Colors.white,
          ),
          titleColor: Colors.white,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
        ).show(context);
      }
    }
  }

  Future<void> _debugPermissionStatus() async {
    print('=== DEBUG: iOS Permission Status ===');
    print('Platform: ${Theme.of(context).platform}');

    final cameraStatus = await Permission.camera.status;
    print('Camera: ${cameraStatus.name}');

    final photosStatus = await Permission.photos.status;
    print('Photos: ${photosStatus.name}');

    print('===============================');
  }

  void _showPermissionSettingsDialog(String permissionType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$permissionType İzni Gerekli'),
          content: Text(
            '$permissionType izni kalıcı olarak reddedildi. Bu özelliği kullanmak için uygulama ayarlarından izin vermeniz gerekiyor.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Ayarları Aç'),
            ),
          ],
        );
      },
    );
  }
}
