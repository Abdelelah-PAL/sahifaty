import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahifaty/controllers/ayatController.dart';
import 'package:sahifaty/controllers/evaluations_controller.dart';
import 'package:sahifaty/models/ayat.dart';
import 'package:sahifaty/providers/evaluations_provider.dart';
import '../../controllers/general_controller.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/fonts.dart';
import '../../core/utils/size_config.dart';
import '../../models/surah.dart';

class IndexPage extends StatefulWidget {
  IndexPage({super.key, required this.surah});

  final Surah surah;

  List<Ayat> ayat = [];

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final gc = GeneralController();
  OverlayEntry? _menuEntry;
  final Map<int, Color> _selectedColors = {};

  Color _onColor(Color bg) {
    final b = ThemeData.estimateBrightnessForColor(bg);
    return b == Brightness.dark ? Colors.white : Colors.black87;
  }

  void _removeMenu() {
    _menuEntry?.remove();
    _menuEntry = null;
  }

  void _showOptionsAt(Offset globalPos,
      Ayat ayah,
      EvaluationsProvider evaluationsProvider,) {
    _removeMenu();

    final overlayBox =
    Overlay
        .of(context)
        .context
        .findRenderObject() as RenderBox;
    final screen = overlayBox.size;

    const double menuWidth = 150;
    const double vGap = 8;

    double top = globalPos.dy + vGap;
    final approxMenuHeight =
        evaluationsProvider.evaluations.length * 44.0 + 12.0;
    if (top + approxMenuHeight > screen.height - 16) {
      top = globalPos.dy - approxMenuHeight - vGap;
    }

    final double right =
    (screen.width - globalPos.dx).clamp(0.0, screen.width - menuWidth);

    _menuEntry = OverlayEntry(
      builder: (context) =>
          Stack(
            children: [
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
                        children: evaluationsProvider.evaluations.map((
                            evaluation) {
                          final text = evaluation.nameAr;
                          final color = gc.getColorFromCategory(evaluation.id!);

                          return InkWell(
                            onTap: () {
                              setState(() {
                                _selectedColors[ayah.id!] =
                                    color; // update local map
                              });
                              _removeMenu();
                              EvaluationsController().sendEvaluation(
                                  ayah, evaluation, evaluationsProvider, null);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              color: color,
                              child: Text(
                                text,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: _onColor(color),
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

  Future<void> _loadAyat() async {
    final ayat = await AyatController().loadAyatBySurah(widget.surah.id);

    // Update the state with the loaded ayat
    setState(() {
      widget.ayat = ayat;
    });
  }

  @override
  void initState() {
    super.initState();

    // Fetch surah Ayat after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAyat();
      // context.read<AyatProvider>().getAyatBySurahId(widget.surah.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final ayatProvider = context.watch<AyatProvider>();
    final evaluationProvider = Provider.of<EvaluationsProvider>(context);
    // if (ayatProvider.isLoading) {
    //   return const Scaffold(
    //     body: Center(child: CircularProgressIndicator()),
    //   );
    // }

    return FutureBuilder(
        future: GeneralController().checkConnectivity(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if ((snapshot.hasError)) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          }
          final hasConnection = snapshot.data ?? false;

          return Scaffold(
            appBar: AppBar(
              title: Text(widget.surah.nameAr),
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
                      'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
                      style: TextStyle(
                        fontSize: 20,
                        height: 2,
                        color: AppColors.blackFontColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.versesFont,
                      ),
                    ),
                    SizeConfig.customSizedBox(null, 30, null),
                    Text.rich(
                      TextSpan(
                          children:
                          // ayatProvider.surahAyat.map((ayah) {
                          widget.ayat
                              .asMap()
                              .entries
                              .map((entry) {
                            final index = entry.key;
                            final ayah = entry.value;
                            // 1️⃣ Use local selected color if exists
                            final color =
                            // hasConnection ?
                            // _selectedColors[ayah.id!] ??
                            // // 2️⃣ Otherwise use backend evaluation color
                            // (ayah.userEvaluation?.evaluation?.id != null
                            // ? gc.getColorFromCategory( // ayah.userEvaluation!.evaluation!.id!)
                            // : Colors.grey)
                            // :
                            AppColors.ayatTextDefaultColor;

                            // --- START MODIFIED AYAH SPAN ---
                            return TextSpan(
                              // The Ayah text itself
                              text: '${ayah.text} ',
                              style: TextStyle(
                                fontSize: 20,
                                height: 2,
                                color: color,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFonts.versesFont,
                              ),
                              recognizer: hasConnection
                                  ? (TapGestureRecognizer()
                                ..onTapDown =
                                    (details) =>
                                    _showOptionsAt(
                                      details.globalPosition,
                                      ayah,
                                      evaluationProvider,
                                    ))
                                  : null,
                              children: [
                                // The WidgetSpan contains the IconButton
                                ayah.userEvaluation != null
                                    ? WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                        color: AppColors.errorColor,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        print('Icon pressed for Ayah ${ayah.id}');
                                      },
                                    ),
                                  ),
                                )
                                    : const WidgetSpan(
                                  child: SizedBox(width: 0, height: 0),
                                ),
                                // The TextSpan contains the Ayah Marker (Number)
                                TextSpan(
                                  text: '${gc.ayahMarker(index)} ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    height: 2,
                                    color: color,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppFonts.versesFont,
                                  ),
                                ),
                              ],
                            );
                            // --- END MODIFIED AYAH SPAN ---
                          }).toList()
                      ),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.justify,
                      strutStyle: const StrutStyle(
                        fontSize: 20,
                        height: 2,
                        forceStrutHeight: true,
                      ),
                      locale: const Locale('ar'),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}