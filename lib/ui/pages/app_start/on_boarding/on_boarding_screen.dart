import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
      image: '', // Son sayfa farklı olacağı için gerek yok
      title: '',
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
              if (index == _pages.length - 1) {
                return _buildCategorySelectionPage();
              }
              return _buildPage(_pages[index]);
            },
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
