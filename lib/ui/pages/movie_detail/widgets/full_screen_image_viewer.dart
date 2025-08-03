import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/card/app_decoartion.dart';
import 'package:my_app/widgets/image/image_url_secured.dart';

class FullScreenImageViewer extends StatefulWidget {
  final List<String> images;
  final String poster;
  final int initialIndex;
  final String movieId;

  const FullScreenImageViewer({
    super.key,
    required this.images,
    required this.poster,
    required this.initialIndex,
    required this.movieId,
  });

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background
        Positioned.fill(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(color: Colors.black.withValues(alpha: 0.9)),
          ),
        ),
        // Image carousel or single image
        Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 1.sw,
              height: 1.sh,
              child: _buildImageContent(),
            ),
          ),
        ),
        // Close button
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          right: 16,
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close, color: Colors.white, size: 30),
          ),
        ),
        // Image indicators (if multiple images)
        if (widget.images.isNotEmpty)
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 20,
            left: 0,
            right: 0,
            child: _buildImageIndicators(),
          ),
      ],
    );
  }

  Widget _buildImageContent() {
    if (widget.images.isNotEmpty) {
      final allImages = [widget.poster, ...widget.images];

      return PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemCount: allImages.length,
        itemBuilder: (context, index) {
          final isPoster = index == 0;
          return Hero(
            tag:
                isPoster
                    ? 'fullscreen_movie_poster_${widget.movieId}'
                    : 'fullscreen_movie_image_${widget.movieId}_${index - 1}',
            child: ImageUrlSecured(
              imageUrl: allImages[index],
              fit: BoxFit.contain,
            ),
          );
        },
      );
    } else {
      return Hero(
        tag: 'fullscreen_movie_poster_${widget.movieId}',
        child: ImageUrlSecured(imageUrl: widget.poster, fit: BoxFit.contain),
      );
    }
  }

  Widget _buildImageIndicators() {
    final totalImages =
        widget.images.isNotEmpty
            ? widget.images.length +
                1 // poster + images
            : 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalImages, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: 8.h,
          width: _currentIndex == index ? 24.w : 8.w,
          decoration:
              _currentIndex == index
                  ? context.imageIndicatorDecoration
                  : context.inactiveImageIndicatorDecoration,
        );
      }),
    );
  }
}
