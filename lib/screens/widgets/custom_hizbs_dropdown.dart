import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sahifaty/controllers/surahs_controller.dart';
import 'package:sahifaty/providers/surahs_provider.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../quran_view/index_page.dart';
import 'custom_text.dart';

class CustomHizbsDropdown extends StatefulWidget {
  final Map<String, dynamic> hizb;
  final bool isOpen;
  final VoidCallback onToggle;

  const CustomHizbsDropdown({
    super.key,
    required this.hizb,
    required this.isOpen,
    required this.onToggle,
  });

  @override
  State<CustomHizbsDropdown> createState() => _CustomHizbsDropdownState();
}

class _CustomHizbsDropdownState extends State<CustomHizbsDropdown>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _showOverlay(SurahsProvider surahsProvider) async {
    if (_overlayEntry != null) return;

    // Start fetching surahs for the selected hizb
    // await surahsProvider.getSurahsByJuz(widget.hizb['id']);
    final surahs = await SurahsController().loadSurahsByHizb(widget.hizb['id']);

    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    // Screen height
    final screenHeight = MediaQuery.of(context).size.height;

    // How much space remains below this widget
    final spaceBelow = screenHeight - (offset.dy + size.height);

    // If little space below → open upwards
    final bool openUpward = spaceBelow < 260;

    final double dropdownTop =
        openUpward ? offset.dy - 50 : offset.dy + size.height + 4;
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Tap outside to close
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              behavior: HitTestBehavior.translucent,
            ),
          ),
          // Dropdown list
          Positioned(
            top: dropdownTop,
            left: offset.dx,
            width: size.width,
            child: Material(
              borderRadius: BorderRadius.circular(8),
              elevation: 6,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: surahsProvider.isLoading
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: surahs.length,
                        // itemCount: surahsProvider.totalSurahs,
                        separatorBuilder: (_, __) =>
                            const Divider(height: 1, color: Colors.grey),
                        itemBuilder: (context, index) {
                          final surah = surahs[index];
                          // final surah = surahsProvider.surahsByJuz[index];
                          return InkWell(
                            onTap: () {
                              Get.to(IndexPage(
                                surah: surah,
                                filterTypeId: 3,
                                hizb: widget.hizb['id'],
                              ));
                              _removeOverlay();
                              widget.onToggle();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 12),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  surah.nameAr,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _controller.forward();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      _controller.reset();
    }
  }

  @override
  void didUpdateWidget(covariant CustomHizbsDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    SurahsProvider surahsProvider = Provider.of<SurahsProvider>(context);
    // Avoid triggering overlay changes during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (widget.isOpen && _overlayEntry == null) {
        _showOverlay(surahsProvider);
      } else if (!widget.isOpen && _overlayEntry != null) {
        _removeOverlay();
      }
    });
  }

  @override
  void dispose() {
    _removeOverlay();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: widget.onToggle,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.getProportionalWidth(12),
            vertical: SizeConfig.getProportionalHeight(4),
          ),
          decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: Center(
            child: CustomText(
              text: widget.hizb['name'],
              fontSize: 14,
              color: Colors.white,
              withBackground: false,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
