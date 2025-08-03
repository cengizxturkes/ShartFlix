import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_images/app_svg.dart';
import 'package:my_app/widgets/icon/app_svg_widget.dart';

class AppAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color backgroundColor;
  final bool centerTitle;
  final double elevation;
  final PreferredSizeWidget? bottom;

  const AppAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor = Colors.transparent,
    this.centerTitle = true,
    this.elevation = 4.0,
    this.bottom,
  });

  @override
  State<AppAppBar> createState() => _AppAppBarState();

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}

class _AppAppBarState extends State<AppAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // İstersen animasyon başlatabilirsin burada
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: AppBar(
        backgroundColor: widget.backgroundColor,
        centerTitle: widget.centerTitle,
        elevation: widget.elevation,
        bottom: widget.bottom,
        leading:
            widget.leading ??
            AppSvgWidget(path: AppSvg.back, color: AppColors.white),
        title: widget.title != null ? Text(widget.title!) : null,
        actions: widget.actions,
      ),
    );
  }
}

class AppBackButton extends StatelessWidget {
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  const AppBackButton({
    super.key,
    this.width,
    this.height,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => context.pop(),
      child: Padding(
        padding: padding ?? const EdgeInsets.only(left: 16),
        child: AppSvgWidget(
          path: AppSvg.back,
          color: AppColors.textBlack,
          width: width ?? 40.w,
          height: height ?? 40.h,
        ),
      ),
    );
  }
}
