import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_dimens/app_dimens.dart';
import 'package:my_app/common/app_images/app_images.dart';
import 'package:my_app/common/app_images/app_svg.dart';
import 'package:my_app/widgets/icon/app_svg_widget.dart';
import 'package:my_app/widgets/app_text_field/app_text_field.dart';
import 'package:my_app/ui/pages/home/home_cubit.dart';

class HomeHeader extends StatefulWidget {
  final HomeCubit cubit;

  const HomeHeader({super.key, required this.cubit});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _searchAnimation;
  late Animation<double> _logoAnimation;
  late Animation<double> _textFieldAnimation;

  bool _isSearchExpanded = false;
  bool _isSearchIconPressed = false;
  bool _isCloseIconPressed = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _searchAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _logoAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _textFieldAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Listen to focus changes to handle back button
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus && _isSearchExpanded) {
        _toggleSearch();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearchExpanded = !_isSearchExpanded;
    });

    if (_isSearchExpanded) {
      _animationController.forward();
      // Add a small delay to focus after animation starts
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          _searchFocusNode.requestFocus();
        }
      });
    } else {
      _animationController.reverse();
      _searchFocusNode.unfocus();
      _searchController.clear();
      // Clear search when closing search
      widget.cubit.clearSearch();
    }
  }

  void _onSearchIconTap() {
    setState(() {
      _isSearchIconPressed = true;
    });

    // Reset the pressed state after animation
    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() {
          _isSearchIconPressed = false;
        });
      }
    });

    _toggleSearch();
  }

  void _onCloseIconTap() {
    setState(() {
      _isCloseIconPressed = true;
    });

    // Reset the pressed state after animation
    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() {
          _isCloseIconPressed = false;
        });
      }
    });

    // Clear search and toggle search
    widget.cubit.clearSearch();
    _toggleSearch();
  }

  void _onSearchSubmitted(String value) {
    // Handle search submission
    if (value.trim().isNotEmpty) {
      print('Search submitted: $value');
      widget.cubit.searchMovies(value.trim());
    }
    _toggleSearch();
  }

  void _onSearchChanged(String value) {
    // Real-time search as user types
    widget.cubit.searchMovies(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Row(
            children: [
              // Animated Logo
              if (_logoAnimation.value > 0.1)
                AnimatedOpacity(
                  opacity: _logoAnimation.value,
                  duration: const Duration(milliseconds: 300),
                  child: Image.asset(
                    AppImages.sinFlixLogo,
                    width: AppDimens.logoWidth,
                    height: AppDimens.logoHeight,
                  ),
                ),

              // Animated Search TextField
              Expanded(
                child: AnimatedOpacity(
                  opacity: _textFieldAnimation.value,
                  duration: const Duration(milliseconds: 300),
                  child:
                      _textFieldAnimation.value > 0.5
                          ? AppTextField(
                            controller: _searchController,
                            focusNode: _searchFocusNode,
                            hintText: 'searchMovie'.tr(),
                            onFieldSubmitted: _onSearchSubmitted,
                            onChanged: _onSearchChanged,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: AppSvgWidget(
                                path: AppSvg.search,
                                color: AppColors.textBlack,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 12),
                              child: GestureDetector(
                                onTap: _onCloseIconTap,
                                child: AnimatedScale(
                                  scale: _isCloseIconPressed ? 0.8 : 1.0,
                                  duration: const Duration(milliseconds: 150),
                                  child: Icon(
                                    Icons.close,
                                    color: AppColors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          )
                          : const SizedBox.shrink(),
                ),
              ),

              // Animated Search Icon
              if (_searchAnimation.value > 0.5)
                const SizedBox.shrink()
              else
                GestureDetector(
                  onTap: _onSearchIconTap,
                  child: AnimatedOpacity(
                    opacity: _searchAnimation.value,
                    duration: const Duration(milliseconds: 300),
                    child: AnimatedScale(
                      scale: _isSearchIconPressed ? 0.8 : 1.0,
                      duration: const Duration(milliseconds: 150),
                      child: AppSvgWidget(
                        path: AppSvg.search,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
