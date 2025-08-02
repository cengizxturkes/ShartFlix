import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_text/app_text_style.dart';

class HtmlViewerAlternativePage extends StatefulWidget {
  final String title;
  final String htmlAssetPath;

  const HtmlViewerAlternativePage({
    super.key,
    required this.title,
    required this.htmlAssetPath,
  });

  @override
  State<HtmlViewerAlternativePage> createState() =>
      _HtmlViewerAlternativePageState();
}

class _HtmlViewerAlternativePageState extends State<HtmlViewerAlternativePage> {
  String _htmlContent = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHtmlContent();
  }

  Future<void> _loadHtmlContent() async {
    try {
      final htmlContent = await rootBundle.loadString(widget.htmlAssetPath);

      // HTML içeriğini temizle ve sadece body içeriğini al
      final cleanHtml = _extractBodyContent(htmlContent);

      setState(() {
        _htmlContent = cleanHtml;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading HTML: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _extractBodyContent(String html) {
    // Basit bir body extraction
    final bodyStart = html.indexOf('<body>');
    final bodyEnd = html.indexOf('</body>');

    if (bodyStart != -1 && bodyEnd != -1) {
      return html.substring(bodyStart + 6, bodyEnd);
    }

    // Body tag'i yoksa tüm içeriği döndür
    return html;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: AppTextStyle.whiteS15Regular),
        centerTitle: true,
        elevation: 0,
      ),
      body:
          _isLoading
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    SizedBox(height: 16.h),
                    Text('Yükleniyor...', style: AppTextStyle.grayS16),
                  ],
                ),
              )
              : SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Html(
                  data: _htmlContent,
                  style: {
                    "body": Style(
                      fontSize: FontSize(16),
                      color: AppColors.isDarkMode ? Colors.white : Colors.black,
                      fontFamily: 'EuclidCircularA',
                    ),
                    "h1": Style(
                      fontSize: FontSize(24),
                      fontWeight: FontWeight.bold,
                      color: AppColors.isDarkMode ? Colors.white : Colors.black,
                      margin: Margins.only(bottom: 12),
                    ),
                    "h2": Style(
                      fontSize: FontSize(20),
                      fontWeight: FontWeight.w600,
                      color: AppColors.isDarkMode ? Colors.white : Colors.black,
                      margin: Margins.only(bottom: 12),
                    ),
                    "h3": Style(
                      fontSize: FontSize(18),
                      fontWeight: FontWeight.w500,
                      color: AppColors.isDarkMode ? Colors.white : Colors.black,
                      margin: Margins.only(bottom: 12),
                    ),
                    "p": Style(
                      fontSize: FontSize(16),
                      color: AppColors.isDarkMode ? Colors.white : Colors.black,
                      margin: Margins.only(bottom: 12),
                    ),
                    "ul": Style(margin: Margins.only(bottom: 16, left: 20)),
                    "ol": Style(margin: Margins.only(bottom: 16, left: 20)),
                    "li": Style(
                      fontSize: FontSize(16),
                      color: AppColors.isDarkMode ? Colors.white : Colors.black,
                      margin: Margins.only(bottom: 8),
                    ),
                    "a": Style(
                      color: AppColors.secondary,
                      textDecoration: TextDecoration.none,
                    ),
                    "footer": Style(
                      fontSize: FontSize(14),
                      color:
                          AppColors.isDarkMode ? Colors.grey : Colors.grey[600],
                      textAlign: TextAlign.center,
                      margin: Margins.only(top: 48),
                      border: Border(
                        top: BorderSide(
                          color:
                              AppColors.isDarkMode
                                  ? Colors.grey[800]!
                                  : Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      padding: HtmlPaddings.only(top: 16),
                    ),
                  },
                ),
              ),
    );
  }
}
