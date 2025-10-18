import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../controllers/categories.dart';
import '../../controllers/general_controller.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/fonts.dart';
import '../../core/utils/size_config.dart';

class IndexPage extends StatefulWidget {
  IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<Map<String, dynamic>> ayahData = [
    {'text': "الحَمدُ لِلَهِ رَبّ العالَمِينْ", 'category': Categories.desire},
    {'text': "الرَّحمنِ الرَّحِيمْ", 'category': Categories.strong},
    {'text': "مالِكِ يَوْمِ الدِّينْ", 'category': Categories.easy},
    {
      'text': "إِيّاكَ نعبدُ وإِيّاكَ نَسْتَعينْ",
      'category': Categories.strong
    },
    {
      'text': "اِهْدِنا الصّرَاطَ المُسْتَقِيم",
      'category': Categories.revision
    },
    {'text': "صِراطَ الّذينَ أنْعَمتَ عَلَيهِم", 'category': Categories.hard},
    {'text': "غَيْرِ المَغْضُوبِ عَلَيهِم", 'category': Categories.hard},
    {
      'text':
          "اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ وَلَا يَئُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُْ",
      'category': Categories.uncategorized
    },
    {
      'text':
          " يَا أَيُّهَا الَّذِينَ آمَنُوا إِذَا تَدَايَنتُم بِدَيْنٍ إِلَىٰ أَجَلٍ مُّسَمًّى فَاكْتُبُوهُ ۚ وَلْيَكْتُب بَّيْنَكُمْ كَاتِبٌ بِالْعَدْلِ ۚ وَلَا يَأْبَ كَاتِبٌ أَن يَكْتُبَ كَمَا عَلَّمَهُ اللَّهُ ۚ فَلْيَكْتُبْ وَلْيُمْلِلِ الَّذِي عَلَيْهِ الْحَقُّ وَلْيَتَّقِ اللَّهَ رَبَّهُ وَلَا يَبْخَسْ مِنْهُ شَيْئًا ۚ فَإِن كَانَ الَّذِي عَلَيْهِ الْحَقُّ سَفِيهًا أَوْ ضَعِيفًا أَوْ لَا يَسْتَطِيعُ أَن يُمِلَّ هُوَ فَلْيُمْلِلْ وَلِيُّهُ بِالْعَدْلِ ۚ وَاسْتَشْهِدُوا شَهِيدَيْنِ مِن رِّجَالِكُمْ ۖ فَإِن لَّمْ يَكُونَا رَجُلَيْنِ فَرَجُلٌ وَامْرَأَتَانِ مِمَّن تَرْضَوْنَ مِنَ الشُّهَدَاءِ أَن تَضِلَّ إِحْدَاهُمَا فَتُذَكِّرَ إِحْدَاهُمَا الْأُخْرَىٰ ۚ وَلَا يَأْبَ الشُّهَدَاءُ إِذَا مَا دُعُوا ۚ وَلَا تَسْأَمُوا أَن تَكْتُبُوهُ صَغِيرًا أَوْ كَبِيرًا إِلَىٰ أَجَلِهِ ۚ ذَٰلِكُمْ أَقْسَطُ عِندَ اللَّهِ وَأَقْوَمُ لِلشَّهَادَةِ وَأَدْنَىٰ أَلَّا تَرْتَابُوا ۖ إِلَّا أَن تَكُونَ تِجَارَةً حَاضِرَةً تُدِيرُونَهَا بَيْنَكُمْ فَلَيْسَ عَلَيْكُمْ جُنَاحٌ أَلَّا تَكْتُبُوهَا ۗ وَأَشْهِدُوا إِذَا تَبَايَعْتُمْ ۚ وَلَا يُضَارَّ كَاتِبٌ وَلَا شَهِيدٌ ۚ وَإِن تَفْعَلُوا فَإِنَّهُ فُسُوقٌ بِكُمْ ۗ وَاتَّقُوا اللَّهَ ۖ وَيُعَلِّمُكُمُ اللَّهُ ۗ وَاللَّهُ بِكُلِّ شَيْءٍ عَلِيمٌ",
      'category': Categories.desire
    },
  ];
  final gc = GeneralController();

  OverlayEntry? _menuEntry;

  int _categoryFromOption(int idx) {
    switch (idx) {
      case 0:
        return Categories.strong; // متمكن
      case 1:
        return Categories.revision; // للمراجعة
      case 2:
        return Categories.desire; // رغبة
      case 3:
        return Categories.easy; // سهل
      case 4:
        return Categories.hard; // صعب
      default:
        return Categories.uncategorized; // غير مصنف
    }
  }

  Color _onColor(Color bg) {
    final b = ThemeData.estimateBrightnessForColor(bg);
    return b == Brightness.dark ? Colors.white : Colors.black87;
  }

  void _removeMenu() {
    _menuEntry?.remove();
    _menuEntry = null;
  }

  void _showOptionsAt(Offset globalPos, int ayahIndex) {
    _removeMenu();
    final overlayBox =
    Overlay.of(context).context.findRenderObject() as RenderBox;
    final screen = overlayBox.size;

    const double menuWidth = 240;
    const double vGap = 8;

    // Position under the tap; flip above if near bottom; clamp horizontally
    double top = globalPos.dy + vGap;
    final approxMenuHeight = gc.dropdownOptions.length * 44.0 + 12.0;
    if (top + approxMenuHeight > screen.height - 16) {
      top = globalPos.dy - approxMenuHeight - vGap;
    }

    final double right =
    (screen.width - globalPos.dx).clamp(0.0, screen.width - menuWidth);

    _menuEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Dismiss barrier
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeMenu,
              behavior: HitTestBehavior.translucent,
              child: const SizedBox(),
            ),
          ),
          Positioned(
            top: top,
            right: right,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: menuWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: gc.dropdownOptions.asMap().entries.map((e) {
                      final idx = e.key;
                      final text = e.value['text'] as String;
                      final bg = e.value['color'] as Color;

                      return InkWell(
                        onTap: () {
                          setState(() {
                            ayahData[ayahIndex]['category'] =
                                _categoryFromOption(idx);
                          });
                          _removeMenu();
                        },
                        borderRadius: idx == 0
                            ? const BorderRadius.vertical(
                            top: Radius.circular(12))
                            : idx == gc.dropdownOptions.length - 1
                            ? const BorderRadius.vertical(
                            bottom: Radius.circular(12))
                            : BorderRadius.zero,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: bg,
                            borderRadius: idx == 0
                                ? const BorderRadius.vertical(
                                top: Radius.circular(12))
                                : idx == gc.dropdownOptions.length - 1
                                ? const BorderRadius.vertical(
                                bottom: Radius.circular(12))
                                : null,
                          ),
                          child: Text(
                            text,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: _onColor(bg),
                              fontWeight: FontWeight.w700,
                              fontFamily: AppFonts.versesFont,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_menuEntry!);
  }

  @override
  void dispose() {
    _removeMenu();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("سورة الفاتحة"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.getProportionalHeight(5),
          horizontal: SizeConfig.getProportionalWidth(10),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
                style: TextStyle(
                  fontSize: 20,
                  height: 2,
                  color: AppColors.blackFontColor,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.versesFont,
                ),
              ),
              SizeConfig.customSizedBox(null, 30, null),

              // Keep single paragraph design
              Text.rich(
                TextSpan(
                  children: ayahData.asMap().entries.map((entry) {
                    final ayah = entry.value;
                    final n = entry.key;
                    final color = gc.getColorFromCategory(ayah['category']);
                    return TextSpan(
                        text: '${ayah['text']}${gc.ayahMarker(n)} ',
                        style: TextStyle(
                          fontSize: 20,
                          height: 2,
                          color: AppColors.whiteFontColor,
                          backgroundColor: color,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.versesFont,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTapDown = (details) =>
                              _showOptionsAt(details.globalPosition, n));
                  }).toList(),
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.justify,
                strutStyle: const StrutStyle(
                    fontSize: 20, height: 2, forceStrutHeight: true),
                locale: const Locale('ar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IndexPage2 extends StatefulWidget {
  const IndexPage2({super.key});

  @override
  State<IndexPage2> createState() => _IndexPage2State();
}

class _IndexPage2State extends State<IndexPage2> {
  final gc = GeneralController();

  final List<Map<String, dynamic>> ayahData = [
    {'text': "الحَمدُ لِلَهِ رَبّ العالَمِينْ", 'category': Categories.desire},
    {'text': "الرَّحمنِ الرَّحِيمْ", 'category': Categories.strong},
    {'text': "مالِكِ يَوْمِ الدِّينْ", 'category': Categories.easy},
    {
      'text': "إِيّاكَ نعبدُ وإِيّاكَ نَسْتَعينْ",
      'category': Categories.strong
    },
    {
      'text': "اِهْدِنا الصّرَاطَ المُسْتَقِيم",
      'category': Categories.revision
    },
    {'text': "صِراطَ الّذينَ أنْعَمتَ عَلَيهِم", 'category': Categories.hard},
    {
      'text': "غَيْرِ المَغْضُوبِ عَلَيهِم ولا الضَالين ",
      'category': Categories.hard
    },
    {
      'text':
          "اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ وَلَا يَئُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُْ",
      'category': Categories.uncategorized
    },
    {
      'text':
          " يَا أَيُّهَا الَّذِينَ آمَنُوا إِذَا تَدَايَنتُم بِدَيْنٍ إِلَىٰ أَجَلٍ مُّسَمًّى فَاكْتُبُوهُ ۚ وَلْيَكْتُب بَّيْنَكُمْ كَاتِبٌ بِالْعَدْلِ ۚ وَلَا يَأْبَ كَاتِبٌ أَن يَكْتُبَ كَمَا عَلَّمَهُ اللَّهُ ۚ فَلْيَكْتُبْ وَلْيُمْلِلِ الَّذِي عَلَيْهِ الْحَقُّ وَلْيَتَّقِ اللَّهَ رَبَّهُ وَلَا يَبْخَسْ مِنْهُ شَيْئًا ۚ فَإِن كَانَ الَّذِي عَلَيْهِ الْحَقُّ سَفِيهًا أَوْ ضَعِيفًا أَوْ لَا يَسْتَطِيعُ أَن يُمِلَّ هُوَ فَلْيُمْلِلْ وَلِيُّهُ بِالْعَدْلِ ۚ وَاسْتَشْهِدُوا شَهِيدَيْنِ مِن رِّجَالِكُمْ ۖ فَإِن لَّمْ يَكُونَا رَجُلَيْنِ فَرَجُلٌ وَامْرَأَتَانِ مِمَّن تَرْضَوْنَ مِنَ الشُّهَدَاءِ أَن تَضِلَّ إِحْدَاهُمَا فَتُذَكِّرَ إِحْدَاهُمَا الْأُخْرَىٰ ۚ وَلَا يَأْبَ الشُّهَدَاءُ إِذَا مَا دُعُوا ۚ وَلَا تَسْأَمُوا أَن تَكْتُبُوهُ صَغِيرًا أَوْ كَبِيرًا إِلَىٰ أَجَلِهِ ۚ ذَٰلِكُمْ أَقْسَطُ عِندَ اللَّهِ وَأَقْوَمُ لِلشَّهَادَةِ وَأَدْنَىٰ أَلَّا تَرْتَابُوا ۖ إِلَّا أَن تَكُونَ تِجَارَةً حَاضِرَةً تُدِيرُونَهَا بَيْنَكُمْ فَلَيْسَ عَلَيْكُمْ جُنَاحٌ أَلَّا تَكْتُبُوهَا ۗ وَأَشْهِدُوا إِذَا تَبَايَعْتُمْ ۚ وَلَا يُضَارَّ كَاتِبٌ وَلَا شَهِيدٌ ۚ وَإِن تَفْعَلُوا فَإِنَّهُ فُسُوقٌ بِكُمْ ۗ وَاتَّقُوا اللَّهَ ۖ وَيُعَلِّمُكُمُ اللَّهُ ۗ وَاللَّهُ بِكُلِّ شَيْءٍ عَلِيمٌ",
      'category': Categories.desire
    },
  ];

  OverlayEntry? _menuEntry;

  int _categoryFromOption(int idx) {
    switch (idx) {
      case 0:
        return Categories.strong; // متمكن
      case 1:
        return Categories.revision; // للمراجعة
      case 2:
        return Categories.desire; // رغبة
      case 3:
        return Categories.easy; // سهل
      case 4:
        return Categories.hard; // صعب
      default:
        return Categories.uncategorized; // غير مصنف
    }
  }

  Color _onColor(Color bg) {
    final b = ThemeData.estimateBrightnessForColor(bg);
    return b == Brightness.dark ? Colors.white : Colors.black87;
  }

  void _removeMenu() {
    _menuEntry?.remove();
    _menuEntry = null;
  }

  void _showOptionsAt(Offset globalPos, int ayahIndex) {
    _removeMenu();
    final overlayBox =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final screen = overlayBox.size;

    const double menuWidth = 240;
    const double vGap = 8;

    // Position under the tap; flip above if near bottom; clamp horizontally
    double top = globalPos.dy + vGap;
    final approxMenuHeight = gc.dropdownOptions.length * 44.0 + 12.0;
    if (top + approxMenuHeight > screen.height - 16) {
      top = globalPos.dy - approxMenuHeight - vGap;
    }

    final double right =
        (screen.width - globalPos.dx).clamp(0.0, screen.width - menuWidth);

    _menuEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Dismiss barrier
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeMenu,
              behavior: HitTestBehavior.translucent,
              child: const SizedBox(),
            ),
          ),
          Positioned(
            top: top,
            right: right,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: menuWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: gc.dropdownOptions.asMap().entries.map((e) {
                      final idx = e.key;
                      final text = e.value['text'] as String;
                      final bg = e.value['color'] as Color;

                      return InkWell(
                        onTap: () {
                          setState(() {
                            ayahData[ayahIndex]['category'] =
                                _categoryFromOption(idx);
                          });
                          _removeMenu();
                        },
                        borderRadius: idx == 0
                            ? const BorderRadius.vertical(
                                top: Radius.circular(12))
                            : idx == gc.dropdownOptions.length - 1
                                ? const BorderRadius.vertical(
                                    bottom: Radius.circular(12))
                                : BorderRadius.zero,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: bg,
                            borderRadius: idx == 0
                                ? const BorderRadius.vertical(
                                    top: Radius.circular(12))
                                : idx == gc.dropdownOptions.length - 1
                                    ? const BorderRadius.vertical(
                                        bottom: Radius.circular(12))
                                    : null,
                          ),
                          child: Text(
                            text,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: _onColor(bg),
                              fontWeight: FontWeight.w700,
                              fontFamily: AppFonts.versesFont,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_menuEntry!);
  }

  @override
  void dispose() {
    _removeMenu();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("سورة الفاتحة"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.getProportionalHeight(5),
          horizontal: SizeConfig.getProportionalWidth(10),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
                style: TextStyle(
                  fontSize: 20,
                  height: 2,
                  color: AppColors.blackFontColor,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.versesFont,
                ),
              ),
              SizeConfig.customSizedBox(null, 30, null),

              // Keep single paragraph design
              Text.rich(
                TextSpan(
                  children: ayahData.asMap().entries.map((entry) {
                    final ayah = entry.value;
                    final n = entry.key;
                    final color = gc.getColorFromCategory(ayah['category']);
                    return TextSpan(
                        text: '${ayah['text']}${gc.ayahMarker(n)} ',
                        style: TextStyle(
                          fontSize: 20,
                          height: 2,
                          color: color,
                          // recolored when selection changes
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.versesFont,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTapDown = (details) =>
                              _showOptionsAt(details.globalPosition, n));
                  }).toList(),
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.justify,
                strutStyle: const StrutStyle(
                    fontSize: 20, height: 2, forceStrutHeight: true),
                locale: const Locale('ar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
