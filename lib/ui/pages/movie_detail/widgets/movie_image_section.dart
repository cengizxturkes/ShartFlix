import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/card/app_decoartion.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';
import 'package:my_app/widgets/image/image_url_secured.dart';

class MovieImageSection extends StatefulWidget {
  final Movie movie;
  final VoidCallback onImageTap;
  final int currentImageIndex;
  final Function(int) onPageChanged;

  const MovieImageSection({
    super.key,
    required this.movie,
    required this.onImageTap,
    required this.currentImageIndex,
    required this.onPageChanged,
  });

  @override
  State<MovieImageSection> createState() => _MovieImageSectionState();
}

class _MovieImageSectionState extends State<MovieImageSection> {
  final PageController _imagePageController = PageController();

  @override
  void dispose() {
    _imagePageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildImageContent(),
        IgnorePointer(child: Container(decoration: context.movieImageGradient)),
        if (widget.movie.images.isNotEmpty) ...[
          Positioned(
            top: 100.h,
            left: 0,
            right: 0,
            child: _buildImageIndicators(),
          ),
        ],
      ],
    );
  }

  Widget _buildImageContent() {
    if (widget.movie.images.isNotEmpty) {
      final allImages = [widget.movie.poster, ...widget.movie.images];

      return GestureDetector(
        onTap: widget.onImageTap,
        child: PageView.builder(
          controller: _imagePageController,
          onPageChanged: widget.onPageChanged,
          itemCount: allImages.length,
          itemBuilder: (context, index) {
            final isPoster = index == 0;
            return Hero(
              tag:
                  isPoster
                      ? 'movie_detail_poster_${widget.movie.id}'
                      : 'movie_detail_image_${widget.movie.id}_${index - 1}',
              child: ImageUrlSecured(
                imageUrl: allImages[index],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      );
    } else {
      return Hero(
        tag: 'movie_detail_poster_${widget.movie.id}',
        child: ImageUrlSecured(
          imageUrl: widget.movie.poster,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  Widget _buildImageIndicators() {
    final totalImages =
        widget.movie.images.isNotEmpty
            ? widget.movie.images.length +
                1 // poster + images
            : 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalImages, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: 8.h,
          width: widget.currentImageIndex == index ? 24.w : 8.w,
          decoration:
              widget.currentImageIndex == index
                  ? context.imageIndicatorDecoration
                  : context.inactiveImageIndicatorDecoration,
        );
      }),
    );
  }
}
