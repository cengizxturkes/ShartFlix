import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/common/card/app_decoartion.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';
import 'package:my_app/widgets/buttons/app_buttons.dart';
import 'package:my_app/widgets/expandable_text/expandable_text.dart';

class MovieContentSection extends StatelessWidget {
  final Movie movie;

  const MovieContentSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppButton(onPressed: () {}, title: 'play'.tr()),
          SizedBox(height: 24.h),
          if (movie.plot.isNotEmpty) ...[
            _buildSectionTitle('summary'.tr()),
            SizedBox(height: 8.h),
            ExpandableText(
              text: movie.plot,
              maxCharacters: 100,
              textStyle: AppTextStyle.whiteS14.copyWith(
                color: Colors.white70,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24.h),
          ],
          if (movie.genre.isNotEmpty) ...[
            _buildSectionTitle('genre'.tr()),
            SizedBox(height: 8.h),
            _buildGenreChips(),
            SizedBox(height: 24.h),
          ],
          if (movie.director.isNotEmpty) ...[
            _buildSectionTitle('director'.tr()),
            SizedBox(height: 8.h),
            _buildSectionContent(movie.director),
            SizedBox(height: 24.h),
          ],
          if (movie.actors.isNotEmpty) ...[
            _buildSectionTitle('cast'.tr()),
            SizedBox(height: 8.h),
            _buildSectionContent(movie.actors),
            SizedBox(height: 24.h),
          ],
          if (movie.awards.isNotEmpty) ...[
            _buildSectionTitle('awards'.tr()),
            SizedBox(height: 8.h),
            _buildSectionContent(movie.awards),
            SizedBox(height: 24.h),
          ],
          if (movie.language.isNotEmpty || movie.country.isNotEmpty) ...[
            _buildSectionTitle('details'.tr()),
            SizedBox(height: 8.h),
            _buildDetailsSection(),
          ],
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyle.whiteS18Bold.copyWith(color: Colors.white),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: AppTextStyle.whiteS14.copyWith(color: Colors.white70),
    );
  }

  Widget _buildGenreChips() {
    return Builder(
      builder:
          (context) => Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children:
                movie.genre
                    .split(',')
                    .map(
                      (genre) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: context.genreChipDecoration,
                        child: Text(
                          genre.trim(),
                          style: AppTextStyle.whiteS12.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
    );
  }

  Widget _buildDetailsSection() {
    return Column(
      children: [
        if (movie.language.isNotEmpty) ...[
          _buildDetailRow('language'.tr(), movie.language),
          SizedBox(height: 4.h),
        ],
        if (movie.country.isNotEmpty) ...[
          _buildDetailRow('country'.tr(), movie.country),
          SizedBox(height: 4.h),
        ],
        if (movie.released.isNotEmpty) ...[
          _buildDetailRow('releaseDate'.tr(), movie.released),
        ],
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            label,
            style: AppTextStyle.whiteS12.copyWith(color: Colors.white70),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyle.whiteS12.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
