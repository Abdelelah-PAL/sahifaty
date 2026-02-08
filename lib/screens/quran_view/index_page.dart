import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sahifaty/controllers/ayat_controller.dart';
import 'package:sahifaty/controllers/evaluations_controller.dart';
import 'package:sahifaty/controllers/filter_types.dart';
import 'package:sahifaty/models/ayat.dart';
import 'package:sahifaty/providers/evaluations_provider.dart';
import 'package:sahifaty/providers/users_provider.dart';
import '../../controllers/general_controller.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/fonts.dart';
import '../../core/utils/size_config.dart';
import '../../models/surah.dart';
import '../../providers/general_provider.dart';

class IndexPage extends StatefulWidget {
  IndexPage(
      {super.key,
      required this.surah,
      required this.filterTypeId,
      this.hizb,
      this.hizbQuarter,
      this.juz});

  final Surah surah;
  final int filterTypeId;
  final int? hizb;
  final int? hizbQuarter;
  final int? juz;

  List<Ayat> ayat = [];

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final gc = GeneralController();
  OverlayEntry? _menuEntry;
  final Map<int, Color> _selectedColors = {};
  int? _currentHizbQuarter;
  int? _minHizbQuarter;
  int? _maxHizbQuarter;
  int? _lastDisplayedSurahId;
  final ScrollController _scrollController = ScrollController(keepScrollOffset: true);

  Color _onColor(Color bg) {
    final b = ThemeData.estimateBrightnessForColor(bg);
    return b == Brightness.dark ? Colors.white : Colors.black87;
  }

  void _removeMenu() {
    _menuEntry?.remove();
    _menuEntry = null;
  }

  void _showOptionsAt( Offset globalPos, Ayat ayah, EvaluationsProvider evaluationsProvider) {
    _removeMenu();

    final overlayBox =
        Overlay.of(context).context.findRenderObject() as RenderBox;
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
      builder: (context) => Stack(
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
                  constraints: const BoxConstraints(minWidth: 150, maxWidth: 150),
                  child: Column(
                    children: evaluationsProvider.evaluations.map((evaluation) {
                      final color = gc.getColorFromCategory(evaluation.id!);

                      return InkWell(
                        onTap:  () async {
                          final savedScrollOffset = _scrollController.offset;
                          setState(() {
                            _selectedColors[ayah.id!] = color;
                          });

                          _removeMenu();
                          await EvaluationsController().sendEvaluation(
                              ayah, evaluation, evaluationsProvider, null);
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (_scrollController.hasClients) {
                              _scrollController.jumpTo(savedScrollOffset);
                            }
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          height: SizeConfig.getProportionalHeight(50),
                          color: color,
                          child: Center(
                            child: Text(
                              EvaluationsController().getLocalizedName(evaluation.id),
                              style: TextStyle(
                                  color: _onColor(color),
                                  fontFamily: AppFonts.versesFont),
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _removeMenu();
    super.dispose();
  }

  Future<void> _loadAyat(
      int userId, EvaluationsProvider evaluationsProvider) async {
    if (_currentHizbQuarter == null ||
        _minHizbQuarter == null ||
        _maxHizbQuarter == null) {
      if (widget.hizbQuarter != null) {
        _currentHizbQuarter = widget.hizbQuarter;
        _minHizbQuarter = 1;
        _maxHizbQuarter = 240;
      } else if (widget.filterTypeId == FilterTypes.parts &&
          widget.juz != null) {
        // Start from the beginning of the Juz (Part)
        _minHizbQuarter = (widget.juz! - 1) * 8 + 1;
        _maxHizbQuarter = widget.juz! * 8;
        _currentHizbQuarter = _minHizbQuarter;
      } else {
        List<Ayat> initialAyat;
        if (widget.filterTypeId == FilterTypes.parts ||
            widget.filterTypeId == FilterTypes.thirds) {
          initialAyat = await AyatController().loadAyatBySurah(widget.surah.id);
        } else {
          initialAyat = await AyatController().loadAyatByHizb(widget.hizb!);
        }

        if (initialAyat.isNotEmpty) {
          final quarters =
              initialAyat.map((e) => e.hizbQuarter).whereType<int>().toList();

          quarters.sort();
          _minHizbQuarter = quarters.first;
          _maxHizbQuarter = quarters.last;
          _currentHizbQuarter = _minHizbQuarter;
        }
      }
    }

    List<Ayat> ayat =
        await AyatController().loadAyatByHizbQuarter(_currentHizbQuarter!);

    // ---------------------------------------------
    // FILTER AYAT BY SELECTED SURAH
    // ---------------------------------------------
    if (widget.filterTypeId == FilterTypes.parts ||
        widget.filterTypeId == FilterTypes.thirds) {
      ayat = ayat.where((a) => a.surah.id == widget.surah.id).toList();

      // 🔥 DO NOT START A NEW SURAH IN THIS PAGE
      if (ayat.isEmpty || ayat.last.ayahNo == widget.surah.ayahCount) {
        _maxHizbQuarter = _currentHizbQuarter!;
      }
    }

    // ---------------------------------------------

    List<int> ayatIds = ayat.map((ayah) => ayah.id!).toList();
    if (evaluationsProvider.evaluations.isEmpty) {
      await evaluationsProvider.getAllEvaluations();
    }
    await evaluationsProvider.getAllUserEvaluations(userId, ayatIds);
    _lastDisplayedSurahId = null;

    setState(() {
      widget.ayat = ayat;
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int userId = context.read<UsersProvider>().selectedUser!.id;
      EvaluationsProvider evaluationsProvider =
          context.read<EvaluationsProvider>();
      _loadAyat(userId, evaluationsProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final evaluationProvider = Provider.of<EvaluationsProvider>(context);

    if (evaluationProvider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return FutureBuilder(
        future: GeneralController().checkConnectivity(),
        builder: (context, snapshot) {
          final hasConnection = snapshot.data ?? false;

          return Consumer<GeneralProvider>(
            builder: (context, generalProvider, _) {
              final isDarkMode = generalProvider.themeMode == ThemeMode.dark;
              
              return Theme(
                data: isDarkMode
                    ? ThemeData(
                        scaffoldBackgroundColor: const Color(0xFF121212),
                        brightness: Brightness.dark,
                        textTheme: const TextTheme(
                          bodyLarge: TextStyle(color: Colors.white),
                        ),
                        colorScheme: const ColorScheme.dark(
                          surface: Color(0xFF1E1E1E),
                          primary: Color(0xFF121212),
                          secondary: AppColors.buttonColor,
                        ),
                        appBarTheme: const AppBarTheme(
                          backgroundColor: Color(0xFF121212),
                          foregroundColor: Colors.white,
                        ),
                      )
                    : ThemeData(
                        scaffoldBackgroundColor: AppColors.backgroundColor,
                        brightness: Brightness.light,
                        textTheme: const TextTheme(
                          bodyLarge: TextStyle(color: AppColors.blackFontColor),
                        ),
                        colorScheme: const ColorScheme.light(
                          surface: AppColors.backgroundColor,
                          primary: AppColors.backgroundColor,
                          secondary: AppColors.buttonColor,
                        ),
                        appBarTheme: const AppBarTheme(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.black,
                        ),
                      ),
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(kToolbarHeight),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: AppBar(
                        title: Text(
                          widget.filterTypeId == FilterTypes.hizbs
                              ? "${"hizb".tr} ${widget.hizb}"
                              : widget.surah.nameAr,
                        ),
                        centerTitle: true,
                      ),
                    ),
                  ),
                  body: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.getProportionalHeight(5),
                      horizontal: SizeConfig.getProportionalWidth(10),
                    ),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ..._buildAyatWidgets(evaluationProvider, hasConnection, isDarkMode),

                          // ORIGINAL PAGINATION BUTTONS (UNCHANGED)
                          if (_currentHizbQuarter != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 20, bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if (_currentHizbQuarter! > _minHizbQuarter!)
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryPurple,
                                        foregroundColor: Colors.white,
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(12),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _currentHizbQuarter =
                                              _currentHizbQuarter! - 1;
                                        });
                                        final userId = context
                                            .read<UsersProvider>()
                                            .selectedUser!
                                            .id;
                                        final evalProvider =
                                            context.read<EvaluationsProvider>();
                                        _loadAyat(userId, evalProvider);
                                      },
                                      child: const Icon(Icons.arrow_back_ios_new, size: 20),
                                    )
                                  else
                                    const SizedBox(width: 48),
                                  if (_currentHizbQuarter! < _maxHizbQuarter!)
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryPurple,
                                        foregroundColor: Colors.white,
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(12),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _currentHizbQuarter =
                                              _currentHizbQuarter! + 1;
                                        });
                                        final userId = context
                                            .read<UsersProvider>()
                                            .selectedUser!
                                            .id;
                                        final evalProvider =
                                            context.read<EvaluationsProvider>();
                                        _loadAyat(userId, evalProvider);
                                      },
                                      child: const Icon(Icons.arrow_forward_ios, size: 20),
                                    )
                                  else
                                    const SizedBox(width: 48),
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  List<Widget> _buildAyatWidgets(
      EvaluationsProvider evaluationProvider, bool hasConnection, bool isDarkMode) {
    List<Widget> widgets = [];
    if (widget.ayat.isEmpty) return widgets;

    List<List<Ayat>> groups = [];
    List<Ayat> currentGroup = [];
    int? currentSurahId;

    for (var ayah in widget.ayat) {
      if (currentSurahId != null && ayah.surah.id != currentSurahId) {
        groups.add(currentGroup);
        currentGroup = [];
      }
      currentGroup.add(ayah);
      currentSurahId = ayah.surah.id;
    }
    if (currentGroup.isNotEmpty) groups.add(currentGroup);

    for (var group in groups) {
      final firstAyah = group.first;

      // 🔥 Show surah title only when entering a NEW surah
      final showBasmalah = firstAyah.ayahNo == 1 &&
          firstAyah.surah.id != 1 &&
          firstAyah.surah.id != 9;

      if (showBasmalah) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              '${"surah_prefix".tr} ${firstAyah.surah.nameAr}',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );

        // Update last displayed surah
        _lastDisplayedSurahId = firstAyah.surah.id;

        widgets.add(
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'basmalah'.tr,
                style: TextStyle(
                  fontSize: 20,
                  height: 2,
                  color: isDarkMode ? Colors.white : AppColors.blackFontColor,
                  fontFamily: AppFonts.versesFont,
                ),
              ),
            ),
          ),
        );
      }

      widgets.add(
        Text.rich(
          TextSpan(
            children: group.map((ayah) {
              final userEvaluation = evaluationProvider.userEvaluations
                  .firstWhereOrNull((e) => e.ayah!.id == ayah.id);

              Color color = hasConnection
                  ? _selectedColors[ayah.id!] ??
                      (userEvaluation?.evaluation != null
                          ? gc.getColorFromCategory(
                              userEvaluation!.evaluation!.id!)
                          : Colors.grey)
                  : AppColors.ayatTextDefaultColor;

              return TextSpan(
                text: '${ayah.text} ',
                style: TextStyle(
                  fontSize: 20,
                  height: 2,
                  color: color,
                  fontFamily: AppFonts.versesFont,
                ),
                recognizer: hasConnection
                    ? (TapGestureRecognizer()
                      ..onTapDown = (details) => _showOptionsAt(
                          details.globalPosition, ayah, evaluationProvider))
                    : null,
                children: [
                  TextSpan(
                    text: '${gc.ayahMarker(ayah.ayahNo)} ',
                    style: TextStyle(
                      fontSize: 20,
                      height: 2,
                      color: color,
                      fontFamily: AppFonts.versesFont,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.justify,
        ),
      );
    }

    return widgets;
  }
}
