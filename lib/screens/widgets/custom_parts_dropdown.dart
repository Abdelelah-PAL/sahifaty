import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import 'custom_text.dart';

class CustomPartsDropdown extends StatefulWidget {
  final int part;
  final bool isOpen;
  final VoidCallback onToggle;

  const CustomPartsDropdown({
    super.key,
    required this.part,
    required this.isOpen,
    required this.onToggle,
  });

  @override
  State<CustomPartsDropdown> createState() => _CustomPartsDropdownState();
}

class _CustomPartsDropdownState extends State<CustomPartsDropdown>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  late AnimationController _controller;

  final Map<String, List<String>> indexesByPart = {
    "الجزء الأول": ["الفاتحة", "البقرة", "آل عمران"],
    "الجزء الثاني": ["البقرة", "آل عمران", "النساء"],
    "الجزء الثالث": ["آل عمران", "النساء", "المائدة"],
    "الجزء الرابع": ["النساء", "المائدة", "الأنعام"],
    "الجزء الخامس": ["المائدة", "الأنعام", "الأعراف"],
    "الجزء السادس": ["الأنعام", "الأعراف", "الأنفال"],
    "الجزء السابع": ["الأعراف", "الأنفال", "التوبة"],
    "الجزء الثامن": ["الأنفال", "التوبة", "يونس"],
    "الجزء التاسع": ["التوبة", "يونس", "هود"],
    "الجزء العاشر": ["يونس", "هود", "يوسف"],
    "الجزء الحادي عشر": ["هود", "يوسف", "إبراهيم"],
    "الجزء الثاني عشر": ["يوسف", "إبراهيم", "الحجر"],
    "الجزء الثالث عشر": ["إبراهيم", "الحجر", "النحل"],
    "الجزء الرابع عشر": ["الحجر", "النحل", "الإسراء"],
    "الجزء الخامس عشر": ["النحل", "الإسراء", "الكهف"],
    "الجزء السادس عشر": ["الإسراء", "الكهف", "مريم"],
    "الجزء السابع عشر": ["الكهف", "مريم", "طه"],
    "الجزء الثامن عشر": ["مريم", "طه", "الأنبياء"],
    "الجزء التاسع عشر": ["طه", "الأنبياء", "الحج"],
    "الجزء العشرون": ["الأنبياء", "الحج", "المؤمنون"],
    "الجزء الواحد والعشرون": ["الحج", "المؤمنون", "الفرقان"],
    "الجزء الثاني والعشرون": ["المؤمنون", "الفرقان", "النمل"],
    "الجزء الثالث والعشرون": ["الفرقان", "النمل", "العنكبوت"],
    "الجزء الرابع والعشرون": ["النمل", "العنكبوت", "الروم"],
    "الجزء الخامس والعشرون": ["العنكبوت", "الروم", "الأحزاب"],
    "الجزء السادس والعشرون": ["الروم", "الأحزاب", "يس"],
    "الجزء السابع والعشرون": ["الأحزاب", "يس", "الصافات"],
    "الجزء الثامن والعشرون": ["يس", "الصافات", "الزمر"],
    "الجزء التاسع والعشرون": ["الصافات", "الزمر", "فصلت"],
    "الجزء الثلاثون": ["فصلت", "الجن", "الناس"]
  };


  List<String> get indexesForPart {
    final keys = indexesByPart.keys.toList();
    if (widget.part < 0 || widget.part >= keys.length) return [];
    return indexesByPart[keys[widget.part]] ?? [];
  }
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
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
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              behavior: HitTestBehavior.translucent,
            ),
          ),
          Positioned(
            top: offset.dy + size.height + 4,
            left: offset.dx,
            width: size.width,
            child: Material(
              borderRadius: BorderRadius.circular(8),
              elevation: 6,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: indexesForPart.length,
                  separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: Colors.grey),
                  itemBuilder: (context, index) {
                    final item = indexesForPart[index];
                    return InkWell(
                      onTap: () {
                        _removeOverlay();
                        widget.onToggle(); // optional callback
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: CustomText(
                            text: item,
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
    _controller.forward();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted && _controller.isAnimating) {
      _controller.value = 0;
    }
  }

  @override
  void didUpdateWidget(covariant CustomPartsDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen) {
      _showOverlay();
    } else {
      _removeOverlay();
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
              text: indexesByPart.keys.elementAt(widget.part - 1),
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
