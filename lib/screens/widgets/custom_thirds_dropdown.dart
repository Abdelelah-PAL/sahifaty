import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahifaty/controllers/general_controller.dart';
import 'package:sahifaty/screens/quran_view/index_page.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import 'custom_text.dart';

class CustomThirdsDropdown extends StatefulWidget {
  const CustomThirdsDropdown({
    super.key,
    required this.third,
    required this.isOpen,
    required this.onToggle,
  });

  final int third;
  final bool isOpen;
  final VoidCallback onToggle;

  @override
  State<CustomThirdsDropdown> createState() => _CustomThirdsDropdownState();
}

class _CustomThirdsDropdownState extends State<CustomThirdsDropdown>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  OverlayEntry? _sideOverlayEntry;
  int? _tappedIndex;

  late AnimationController _controller;

  List<String> get dropdownOptions => widget.third == 1
      ? GeneralController().firstThird
      : widget.third == 2
          ? GeneralController().secondThird
          : GeneralController().thirdThird;

  final Map<String, List<String>> indexesByPart = {
    "الجزء الأول": ["الفاتحة", "البقرة"],
    "الجزء الثاني": ["البقرة", "آل عمران"],
    "الجزء الثالث": ["آل عمران", "النساء"],
    "الجزء الرابع": ["النساء", "المائدة"],
    "الجزء الخامس": ["المائدة", "الأنعام"],
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

  }


  void _showOverlay() {
    if (_overlayEntry != null) return;

    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Full-screen GestureDetector to detect taps outside
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                // Close overlay AND return button to original position
                _removeOverlay();
                _controller.reverse();
                widget.onToggle(); // notify parent
              },
              behavior: HitTestBehavior.translucent,
            ),
          ),
          Positioned(
            top: offset.dy + size.height + 4,
            left: offset.dx + (_controller.value * 80),
            width: size.width,
            child: Material(
              borderRadius: BorderRadius.circular(8),
              elevation: 6,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 260),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: dropdownOptions.length,
                  separatorBuilder: (_, __) =>
                      const Divider(color: Colors.grey, height: 1),
                  itemBuilder: (context, index) {
                    final option = dropdownOptions[index];
                    return InkWell(
                      onTap: () =>
                          _showSideOverlay(option, index, offset, size),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: CustomText(
                            text: option,
                            fontSize: 14,
                            withBackground: false,
                            color: Colors.black87,
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

    // Slide the button **only when overlay is shown**
    _controller.forward();
  }

  void _showSideOverlay(
      String option, int index, Offset parentOffset, Size buttonSize) {
    _removeSideOverlay();
    if (!indexesByPart.containsKey(option)) return;

    _tappedIndex = index;
    const double itemHeight = 40;
    final double topPosition =
        parentOffset.dy + buttonSize.height + (index * itemHeight);

    _sideOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: topPosition,
        left: parentOffset.dx - 180 + (_controller.value * 100),
        width: 160,
        child: Material(
          borderRadius: BorderRadius.circular(8),
          elevation: 6,
          color: Colors.white,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: indexesByPart[option]!.length,
              itemBuilder: (_, i) {
                final sura = indexesByPart[option]![i];
                return InkWell(
                  onTap: () {
                    _removeSideOverlay();
                    _removeOverlay();
                    _controller.value = 0.0;
                    Get.to( const IndexPage());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CustomText(
                        text: sura,
                        fontSize: 13,
                        withBackground: false,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_sideOverlayEntry!);
  }

  void _removeSideOverlay() {
    _sideOverlayEntry?.remove();
    _sideOverlayEntry = null;
    _tappedIndex = null;
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;

    if (mounted && _controller.isAnimating) {
      _controller.value = 0;
    }
  }

  void _toggleAnimation() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(CustomThirdsDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen) {
      _toggleAnimation();
      WidgetsBinding.instance.addPostFrameCallback((_) => _showOverlay());
    } else {
      _toggleAnimation();
      _removeOverlay();
      _removeSideOverlay();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(widget.isOpen ? _controller.value * 80 : 0, 0),
          child: CompositedTransformTarget(
            link: _layerLink,
            child: GestureDetector(
              onTap: widget.onToggle,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.getProportionalWidth(12),
                  vertical: SizeConfig.getProportionalWidth(4),
                ),
                decoration: BoxDecoration(
                  color: AppColors.buttonColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: CustomText(
                    text: widget.third == 1
                        ? "الثلث الأول"
                        : widget.third == 2
                            ? "الثلث الثاني"
                            : "الثلث الثالث",
                    fontSize: 14,
                    color: Colors.white,
                    withBackground: false,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
