import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:my_app/common/app_animation/app_animation.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/router/route_config.dart';
import 'package:my_app/widgets/buttons/app_buttons.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnBoardingPageData> _pages = [
    _OnBoardingPageData(
      image: 'http://www.impawards.com/2025/posters/abrahams_boys.jpg',
      title: 'Son Çıkan Filmleri Arıyorsan',
      description:
          'Yeni ve popüler filmleri kolayca keşfet ve hemen izlemeye başla!',
    ),
    _OnBoardingPageData(
      image:
          'https://www.impawards.com/2024/posters/kingdom_of_the_planet_of_the_apes_ver2_xxlg.jpg',
      title: 'Favorilerini Oluştur',
      description: 'Beğendiğin filmleri listeye ekle, sonra kolayca izle.',
    ),
    _OnBoardingPageData(
      image: 'https://www.impawards.com/2024/posters/dune_part_two_xxlg.jpg',
      title: 'Keşfetmeye Hazır Mısın?',
      description: 'Kişisel önerilerle film keyfini zirveye taşı!',
    ),
    _OnBoardingPageData(
      image: '', // 4. sayfa kategori seçimi için boş
      title: '',
      description: '',
    ),
    _OnBoardingPageData(
      image: '', // 5. sayfa "her şey hazır" için boş
      title: 'Her şey hazır, başlayalım!',
      description: '',
    ),
  ];
  List<String> selectedCategories = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (var page in _pages) {
      if (page.image.isNotEmpty) {
        precacheImage(NetworkImage(page.image), context);
      }
    }
  }

  void _nextPage() {
    // Kategori seçim sayfasında (sayfa 3) en az bir kategori seçilmiş mi kontrol et
    if (_currentPage == 3) {
      if (selectedCategories.isEmpty) {
        Flushbar(
          message: 'Lütfen en az bir kategori seçiniz',
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
        return;
      }
    }

    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.pushNamed(AppRouter.signIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              if (index == 3) {
                return _buildCategorySelectionPage();
              } else if (index == 4) {
                return _buildReadyPage();
              }
              return _buildPage(_pages[index]);
            },
          ),
          Positioned(
            top: 0.1.sh,
            right: 0.05.sw,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: TextButton(
                onPressed: () {
                  _pageController.jumpToPage(3);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(50.w, 30.h),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Atla',
                      style: AppTextStyle.whiteS14.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16.sp,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 0.05.sh,
            left: 30.w,
            right: 30.w,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_pages.length, (index) {
                    final isActive = index == _currentPage;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      height: 8.h,
                      width: isActive ? 20.w : 8.w,
                      decoration: BoxDecoration(
                        color: isActive ? Colors.white : Colors.white54,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20.h),
                AppButton(
                  onPressed: _nextPage,
                  title:
                      _currentPage == _pages.length - 1
                          ? 'Başlayalım'
                          : 'Devam Et',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(_OnBoardingPageData data) {
    return Stack(
      children: [
        Positioned.fill(child: Image.network(data.image, fit: BoxFit.cover)),
        Positioned(
          bottom: 0.22.sh,
          left: 30.w,
          right: 30.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: AppTextStyle.blackS18SemiBold.copyWith(
                  fontSize: 30.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                data.description,
                style: AppTextStyle.whiteS14.copyWith(color: Colors.white70),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySelectionPage() {
    final categories = [
      "Aksiyon",
      "Komedi",
      "Dram",
      "Bilim Kurgu",
      "Korku",
      "Romantik",
      "Gerilim",
      "Animasyon",
      "Belgesel",
      "Fantastik",
      "Macera",
      "Suç",
      "Müzikal",
      "Western",
      "Savaş",
      "Tarih",
      "Aile",
      "Spor",
      "Mistery",
      "Kısa Film",
    ];

    return Container(
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 60.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sevdiğiniz kategorileri seçin",
              style: AppTextStyle.blackS18SemiBold.copyWith(
                fontSize: 28.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.h),
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children:
                  categories.map((e) {
                    final isSelected = selectedCategories.contains(e);
                    return ChoiceChip(
                      label: Text(
                        e,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white70,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (value) {
                        setState(() {
                          if (value) {
                            selectedCategories.add(e);
                          } else {
                            selectedCategories.remove(e);
                          }
                        });
                      },
                      selectedColor: AppColors.buttonColor,
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    );
                  }).toList(),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildReadyPage() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              AppAnimation.movie,
              width: 200.w,
              height: 200.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 30.h),
            Text(
              _pages[4].title,
              style: AppTextStyle.blackS18SemiBold.copyWith(
                fontSize: 28.sp,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _OnBoardingPageData {
  final String image;
  final String title;
  final String description;

  _OnBoardingPageData({
    required this.image,
    required this.title,
    required this.description,
  });
}
