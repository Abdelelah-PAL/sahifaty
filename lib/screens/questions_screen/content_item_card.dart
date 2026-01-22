import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahifaty/controllers/ayat_controller.dart';
import 'package:sahifaty/controllers/evaluations_controller.dart';
import 'package:sahifaty/controllers/general_controller.dart';
import 'package:sahifaty/controllers/surahs_controller.dart';
import 'package:sahifaty/models/ayat.dart';
import 'package:sahifaty/models/evaluation.dart';
import 'package:sahifaty/models/surah.dart';
import 'package:sahifaty/providers/evaluations_provider.dart';
import 'package:sahifaty/providers/users_provider.dart';
import 'package:sahifaty/models/user_evaluation.dart';
import '../../core/utils/size_config.dart';
import '../../models/school_level_content.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import 'package:collection/collection.dart';

class ContentItemCard extends StatefulWidget {
  final SchoolLevelContent content;
  final int index;

  const ContentItemCard({
    super.key,
    required this.content,
    required this.index,
  });

  @override
  State<ContentItemCard> createState() => _ContentItemCardState();
}

class _ContentItemCardState extends State<ContentItemCard> {
  bool isEvaluating = false;
  bool isCompleted = false;
  bool isLoadingStatus = true;
  String unitName = "الوحدة";

  @override
  void initState() {
    super.initState();
    _setUnitName();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkCompletion();
    });
  }

  Future<void> _checkCompletion() async {
    if (!mounted) return;
    setState(() {
      isLoadingStatus = true;
    });

    try {
      final ayahs = await _fetchAyahs(withEvaluations: true);
      if (ayahs.isNotEmpty) {
        final allEvaluated = ayahs.every((ayah) => ayah.userEvaluation != null);
        if (mounted) {
          setState(() {
            isCompleted = allEvaluated;
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error checking completion: $e");
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoadingStatus = false;
        });
      }
    }
  }

  Future<List<Ayat>> _fetchAyahs({bool withEvaluations = false}) async {
    final ayatController = AyatController();
    List<Ayat> ayahs = [];

    // Prioritize range check if start/end ayah are present
    if (widget.content.startAyah != null &&
        widget.content.endAyah != null &&
        widget.content.surahId != null) {
      ayahs = await ayatController.loadAyatByRange(
        widget.content.surahId!,
        widget.content.startAyah!,
        widget.content.endAyah!,
      );
    } else if (widget.content.type.contains('surah') &&
        widget.content.surahId != null) {
      ayahs = await ayatController.loadAyatBySurah(widget.content.surahId!);
    } else if (widget.content.type.contains('hizb') &&
        widget.content.hizb != null) {
      ayahs = await ayatController.loadAyatByHizb(widget.content.hizb!);
    } else if (widget.content.type.contains('hizbQuarter') &&
        widget.content.hizbQuarter != null) {
      ayahs = await ayatController
          .loadAyatByHizbQuarter(widget.content.hizbQuarter!);



    } else if (widget.content.type.contains('juz') &&
        widget.content.juz != null) {
      ayahs = await ayatController.loadAyatByJuz(widget.content.juz!);
    }

    if (withEvaluations && ayahs.isNotEmpty && mounted) {
      final usersProvider = context.read<UsersProvider>();
      final evaluationsProvider = context.read<EvaluationsProvider>();

      if (usersProvider.selectedUser != null) {
        final userId = usersProvider.selectedUser!.id;
        final ayatIds = ayahs.map((e) => e.id!).toList();

        await evaluationsProvider.getAllUserEvaluations(userId, ayatIds);

        // Map evaluations to ayahs
        for (var ayah in ayahs) {
          final userEval = evaluationsProvider.userEvaluations.firstWhereOrNull(
              (e) => e.ayah?.id == ayah.id || e.ayahId == ayah.id);
          ayah.userEvaluation = userEval;
        }
      }
    }

    return ayahs;
  }

  Future<void> _evaluateUnit(BuildContext context) async {
    final evaluationsProvider = context.read<EvaluationsProvider>();

    // Show dialog to select evaluation
    final selectedEvaluation = await showDialog<Evaluation>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('اختر التقييم', textAlign: TextAlign.center),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: evaluationsProvider.evaluations.map((evaluation) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: EvaluationsController()
                      .getColorForEvaluation(evaluation.id),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: EvaluationsController()
                        .getColorForEvaluation(evaluation.id),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    evaluation.nameAr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () => Navigator.pop(context, evaluation),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );

    if (selectedEvaluation == null) return;

    setState(() {
      isEvaluating = true;
    });

    try {
      final ayahs = await _fetchAyahs();

      if (ayahs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لم يتم العثور على آيات للتقييم')),
        );
        return;
      }


      await EvaluationsController().sendMultipleEvaluations(
          ayahs, selectedEvaluation, evaluationsProvider, null, unitName);

      // Immediately update local state for UI feedback
      for (var ayah in ayahs) {
        ayah.userEvaluation = UserEvaluation(
          evaluation: selectedEvaluation,
          evaluationId: selectedEvaluation.id,
          ayahId: ayah.id,
        );
      }

      // Update completion status
      _checkCompletion();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء التقييم: $e')),
      );
    } finally {
      setState(() {
        isEvaluating = false;
      });
    }
  }

  Future<void> _showIndividualEvaluation(BuildContext context) async {
    if (widget.content.type == 'juz' && widget.content.juz != null) {
      _showJuzBreakdown(context, widget.content.juz!);
      return;
    }

    final evaluationsProvider = context.read<EvaluationsProvider>();

    try {
      final ayahs = await _fetchAyahs(withEvaluations: true);

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) => StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CustomText(
                    text: 'تقييم الآيات',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    withBackground: false,
                  ),
                ),
                Expanded(
                  child: ayahs.isEmpty
                      ? const Center(child: Text("لا توجد آيات لعرضها"))
                      : ListView.builder(
                          controller: scrollController,
                          itemCount: ayahs.length,
                          itemBuilder: (context, index) {
                            final ayah = ayahs[index];
                            Color? cardColor;
                            if (ayah.userEvaluation?.evaluation != null) {
                              cardColor = EvaluationsController()
                                  .getColorForEvaluation(
                                      ayah.userEvaluation!.evaluation!.id);
                            }

                            return Card(
                              color: cardColor,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      ayah.text,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'UthmanicHafs',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('آية ${ayah.ayahNo}'),
                                        ElevatedButton(
                                          onPressed: () async {
                                            final selectedEvaluation =
                                                await showDialog<Evaluation>(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text(
                                                    'اختر التقييم',
                                                    textAlign:
                                                        TextAlign.center),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children:
                                                        evaluationsProvider
                                                            .evaluations
                                                            .map((evaluation) {
                                                      return Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 4),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: EvaluationsController()
                                                              .getColorForEvaluation(
                                                                  evaluation
                                                                      .id),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            color: EvaluationsController()
                                                                .getColorForEvaluation(
                                                                    evaluation
                                                                        .id),
                                                          ),
                                                        ),
                                                        child: ListTile(
                                                          title: Text(
                                                            evaluation.nameAr,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          onTap: () =>
                                                              Navigator.pop(
                                                                  context,
                                                                  evaluation),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                            );

                                            if (selectedEvaluation != null) {
                                              await EvaluationsController()
                                                  .sendEvaluation(
                                                ayah,
                                                selectedEvaluation,
                                                evaluationsProvider,
                                                null,
                                              );

                                              setModalState(() {
                                                ayah.userEvaluation =
                                                    UserEvaluation(
                                                  evaluation:
                                                      selectedEvaluation,
                                                  evaluationId:
                                                      selectedEvaluation.id,
                                                  ayahId: ayah.id,
                                                );
                                              });

                                              _checkCompletion(); // Update unit status
                                            }
                                          },
                                          child: const Text('تقييم'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          }),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء تحميل الآيات: $e')),
      );
    }
  }

  Future<void> _showJuzBreakdown(BuildContext context, int juz) async {
    final surahsController = SurahsController();
    final evaluationsProvider = context.read<EvaluationsProvider>();

    try {
      final surahs = await surahsController.loadSurahsByJuz(juz);

      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.4,
              maxChildSize: 0.9,
              expand: false,
              builder: (context, scrollController) {
                Map<int, Color> surahColors = {};
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setModalState) {
                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CustomText(
                          text: 'سور الجزء',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          withBackground: false,
                        ),
                      ),
                      Expanded(
                          child: surahs.isEmpty
                              ? const Center(child: Text("لا توجد سور للعرض"))
                              : ListView.builder(
                                  controller: scrollController,
                                  itemCount: surahs.length,
                                  itemBuilder: (context, index) {
                                    final surah = surahs[index];
                                    final cardColor = surahColors[surah.id];

                                    return Card(
                                      color: cardColor,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: ListTile(
                                        title: Text(
                                          surah.nameAr,
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          "سورة رقم ${surah.id}",
                                          textAlign: TextAlign.right,
                                        ),
                                        trailing: ElevatedButton(
                                          onPressed: () async {
                                            // Show evaluation selection dialog
                                            final selectedEvaluation =
                                                await showDialog<Evaluation>(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text(
                                                  'اختر التقييم',
                                                  textAlign: TextAlign.center,
                                                ),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children:
                                                        evaluationsProvider
                                                            .evaluations
                                                            .map((evaluation) {
                                                      final color =
                                                          EvaluationsController()
                                                              .getColorForEvaluation(
                                                                  evaluation
                                                                      .id);
                                                      return Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 4),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: color,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                              color: color),
                                                        ),
                                                        child: ListTile(
                                                          title: Text(
                                                            evaluation.nameAr,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          onTap: () =>
                                                              Navigator.pop(
                                                                  context,
                                                                  evaluation),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                            );

                                            if (selectedEvaluation != null) {
                                              // Load ayahs for the surah
                                              final ayatController =
                                                  AyatController();
                                              List<Ayat> surahAyahs =
                                                  await ayatController
                                                      .loadAyatBySurah(
                                                          surah.id);

                                              // Filter ayahs to current Juz
                                              surahAyahs = surahAyahs
                                                  .where((a) => a.juz == juz)
                                                  .toList();

                                              if (surahAyahs.isNotEmpty) {
                                                // Send evaluation
                                                await EvaluationsController()
                                                    .sendMultipleEvaluations(
                                                  surahAyahs,
                                                  selectedEvaluation,
                                                  evaluationsProvider,
                                                  null,
                                                  "سورة ${surah.nameAr}",
                                                );

                                                // Update card color in StatefulBuilder
                                                setModalState(() {
                                                  surahColors[surah.id] =
                                                      EvaluationsController()
                                                          .getColorForEvaluation(
                                                              selectedEvaluation
                                                                  .id);
                                                });

                                                _checkCompletion();
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'لا توجد آيات لهذه السورة في هذا الجزء'),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                          child: const Text("تقييم"),
                                        ),
                                        onTap: () {
                                          _showJuzSurahAyahs(context, surah, juz);
                                        },
                                      ),
                                    );
                                  },
                                )),
                    ],
                  );
                });
              }));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء تحميل السور: $e')),
      );
    }
  }

  Future<void> _showJuzSurahAyahs(BuildContext context, Surah surah, int juz) async {
    final evaluationsProvider = context.read<EvaluationsProvider>();
    final ayatController = AyatController();

    try {
      List<Ayat> ayahs = await ayatController.loadAyatBySurah(surah.id);
      // Filter by Juz
      ayahs = ayahs.where((a) => a.juz == juz).toList();

      if (ayahs.isNotEmpty) {
        final usersProvider = context.read<UsersProvider>();
        if (usersProvider.selectedUser != null) {
          final userId = usersProvider.selectedUser!.id;
          final ayatIds = ayahs.map((e) => e.id!).toList();
          await evaluationsProvider.getAllUserEvaluations(userId, ayatIds);
          for (var ayah in ayahs) {
            final userEval = evaluationsProvider.userEvaluations
                .firstWhereOrNull(
                    (e) => e.ayah?.id == ayah.id || e.ayahId == ayah.id);
            ayah.userEvaluation = userEval;
          }
        }
      }

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) => StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomText(
                    text: 'آيات سورة ${surah.nameAr} (جزء $juz)',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    withBackground: false,
                  ),
                ),
                Expanded(
                  child: ayahs.isEmpty
                      ? const Center(child: Text("لا توجد آيات لعرضها"))
                      : ListView.builder(
                          controller: scrollController,
                          itemCount: ayahs.length,
                          itemBuilder: (context, index) {
                            final ayah = ayahs[index];
                            Color? cardColor;
                            if (ayah.userEvaluation?.evaluation != null) {
                              cardColor = EvaluationsController()
                                  .getColorForEvaluation(
                                      ayah.userEvaluation!.evaluation!.id);
                            }

                            return Card(
                              color: cardColor,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      ayah.text,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'UthmanicHafs',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('آية ${ayah.ayahNo}'),
                                        ElevatedButton(
                                          onPressed: () async {
                                            final selectedEvaluation =
                                                await showDialog<Evaluation>(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text(
                                                    'اختر التقييم',
                                                    textAlign:
                                                        TextAlign.center),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children:
                                                        evaluationsProvider
                                                            .evaluations
                                                            .map((evaluation) {
                                                      return Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 4),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: EvaluationsController()
                                                              .getColorForEvaluation(
                                                                  evaluation
                                                                      .id),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            color: EvaluationsController()
                                                                .getColorForEvaluation(
                                                                    evaluation
                                                                        .id),
                                                          ),
                                                        ),
                                                        child: ListTile(
                                                          title: Text(
                                                            evaluation.nameAr,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          onTap: () =>
                                                              Navigator.pop(
                                                                  context,
                                                                  evaluation),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                            );

                                            if (selectedEvaluation != null) {
                                              await EvaluationsController()
                                                  .sendEvaluation(
                                                ayah,
                                                selectedEvaluation,
                                                evaluationsProvider,
                                                null,
                                              );

                                              setModalState(() {
                                                ayah.userEvaluation =
                                                    UserEvaluation(
                                                  evaluation:
                                                      selectedEvaluation,
                                                  evaluationId:
                                                      selectedEvaluation.id,
                                                  ayahId: ayah.id,
                                                );
                                              });

                                              _checkCompletion();
                                            }
                                          },
                                          child: const Text('تقييم'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          }),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء تحميل الآيات: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (widget.content.type == 'juz' && widget.content.juz != null) {
            _showJuzBreakdown(context, widget.content.juz!);
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: SizeConfig.getProportionalHeight(10),
            horizontal: SizeConfig.getProportionalWidth(5),
          ),
          padding: EdgeInsets.all(SizeConfig.getProportionalHeight(15)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
            border:
                isCompleted ? Border.all(color: Colors.green, width: 2) : null,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: SizeConfig.getProportionalWidth(40),
                    height: SizeConfig.getProportionalWidth(40),
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? Colors.green
                          : Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: isCompleted
                        ? const Icon(Icons.check, color: Colors.white)
                        : CustomText(
                            text: '${widget.index + 1}',
                            withBackground: false,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                  ),
                  SizeConfig.customSizedBox(25, null, null),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(children: [
                          if (widget.content.surahId != null) ...[
                            CustomText(
                              text:
                              'سورة ${GeneralController().getSurahNameByNumber(widget.content.surahId!)}',
                              withBackground: false,
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ],
                          if (widget.content.startAyah != null &&
                              widget.content.endAyah != null) ...[
                            CustomText(
                              text:
                              'الآيات: ${widget.content.startAyah} - ${widget.content.endAyah}',
                              withBackground: false,
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ],
                          if (widget.content.type == "hizb" &&
                              widget.content.hizb != null) ...[
                            CustomText(
                              text: 'الحزب ${widget.content.hizb}',
                              withBackground: false,
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ],
                          if (widget.content.type == "hizbQuarter" &&
                              widget.content.hizbQuarter != null) ...[
                            CustomText(
                              text: 'ريع الحزب ${widget.content.hizbQuarter}',
                              withBackground: false,
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ],
                          if (widget.content.type == "juz" &&
                              widget.content.juz != null) ...[
                            CustomText(
                              text: 'جزء ${widget.content.juz}',
                              withBackground: false,
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ],
                          // SizedBox(height: SizeConfig.getProportionalHeight(5)),
                          // Container(
                          //   padding: const EdgeInsets.symmetric(
                          //       horizontal: 8, vertical: 4),
                          //   decoration: BoxDecoration(
                          //     color: isCompleted
                          //         ? Colors.green.withOpacity(0.1)
                          //         : Colors.grey.withOpacity(0.1),
                          //     borderRadius: BorderRadius.circular(4),
                          //     border: Border.all(
                          //       color: isCompleted ? Colors.green : Colors.grey,
                          //       width: 1,
                          //     ),
                          //   ),
                          //   child: Text(
                          //     isCompleted ? 'مكتمل' : 'غير مكتمل',
                          //     style: TextStyle(
                          //       color:
                          //       isCompleted ? Colors.green : Colors.grey[700],
                          //       fontSize: 12,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // ),
                        ],)
                      ],
                    ),
                  ),
                ],
              ),
              if (widget.content.type != "ayat range") ...[
                SizedBox(height: SizeConfig.getProportionalHeight(15)),
                isEvaluating
                    ? const CircularProgressIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButton(
                            onPressed: () => _evaluateUnit(context),
                            text: "تقييم $unitName",
                            width: 120,
                            height: 35,
                          ),
                          CustomButton(
                            onPressed: () => _showIndividualEvaluation(context),
                            text: "تقييم الآيات",
                            width: 120,
                            height: 35,
                          ),
                        ],
                      ),
              ] else ...[
                SizedBox(height: SizeConfig.getProportionalHeight(15)),
                CustomButton(
                  onPressed: () => _showIndividualEvaluation(context),
                  text: "تقييم الآيات",
                  width: 150,
                  height: 35,
                ),
              ],
            ],
          ),
        ));
  }

  void _setUnitName() {
    if (widget.content.type == "ayatRange") {
      unitName = "نطاق الآيات";
    } else if (widget.content.type == "surah") {
      unitName = "السورة";
    } else if (widget.content.type == "hizb") {
      unitName = "الحزب";
    } else if (widget.content.type == "hizbQuarter") {
      unitName = "ربع الحزب";
    } else if (widget.content.type == "juz") {
      unitName = "الجزء";
    } else {
      unitName = "الوحدة";
    }
  }
}
