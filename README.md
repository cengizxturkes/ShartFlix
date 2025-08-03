Uygulama, Clean Architecture, Bloc (Cubit) state yönetimi kullanılarak geliştirilmiştir.
Amaç; Flutter Developer teknik becerilerini, kod kalitesi ve mimari yaklaşımı göstermek.
Özellikler=>
Kullanıcı giriş & kayıt işlemleri
Güvenli token yönetimi (flutter_secure_storage) path=>lib/database/secure_storage_helper.dart
Başarılı giriş sonrası otomatik yönlendirme (Home)
Kullanılan Teknolojiler ve Paketler
State Yönetimi: flutter_bloc
Ağ İşlemleri: dio, retrofit
Depolama: shared_preferences, flutter_secure_storage
Navigasyon: go_router
Çoklu Dil: easy_localization
UI & Animasyon: shimmer, lottie, cached_network_image, flutter_svg
Resim İşleme: image_picker, photo_view
Logger: logger, pretty_dio_logger
Firebase: firebase_core, firebase_crashlytics, firebase_analytics
Analytics: clarity_flutter
HTML Renderer: flutter_html
📄 Yardım & Destek
Uygulama içerisinde WebView ile gösterilen özel bir yardım ve destek sayfası bulunmaktadır.
HTML yapısı ile hazırlanmış, SSS ve iletişim bilgilerinin yer aldığı sayfa eklenmiştir.
(Ayrıca "Legal" sayfası da eklenmiştir.)
Burada kullanılmış olan api servisi dio ile yazılıp loglama işlemleri de eklenilmiştir.
Uygulamaya Microsoft Clarity entegrasyonu ekledim.
Bu sayede:
Kullanıcıların uygulama içinde gerçekleştirdiği tüm işlemleri canlı olarak gözlemleyebiliyorum.
Isı haritaları aracılığıyla en çok tıklanan ve en az etkileşim alan bölgeleri analiz edebiliyorum.
Bu analizler sonucunda hatalı veya kullanıcı dostu olmayan UX noktalarını tespit edip hızlıca iyileştirme fırsatı yakalayabiliyorum.
Bu özellik, kullanıcı deneyimini sürekli geliştirmek için önemli bir avantaj sağlıyor.
