import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import 'custom_text.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    super.key,
    required this.third,
    required this.isOpen,
    required this.onToggle,
  });

  final int third;
  final bool isOpen;
  final VoidCallback onToggle;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown>
    with SingleTickerProviderStateMixin {
  String? selectedValue;
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  List<String> get dropdownOptions => widget.third == 1
      ? [
    'الجزء الأول',
    'الجزء الثاني',
    'الجزء الثالث',
    'الجزء الرابع',
    'الجزء الخامس',
    'الجزء السادس',
    'الجزء السابع',
    'الجزء الثامن',
    'الجزء التاسع',
    'الجزء العاشر',
  ]
      : widget.third == 2
      ? [
    'الجزء الحادي عشر',
    'الجزء الثاني عشر',
    'الجزء الثالث عشر',
    'الجزء الرابع عشر',
    'الجزء الخامس عشر',
    'الجزء السادس عشر',
    'الجزء السابع عشر',
    'الجزء الثامن عشر',
    'الجزء التاسع عشر',
    'الجزء العشرون',
  ]
      : [
    'الجزء الحادي والعشرين',
    'الجزء الثاني والعشرين',
    'الجزء الثالث والعشرين',
    'الجزء الرابع والعشرين',
    'الجزء الخامس والعشرين',
    'الجزء السادس والعشرين',
    'الجزء السابع والعشرين',
    'الجزء الثامن والعشرين',
    'الجزء التاسع والعشرين',
    'الجزء الثلاثون',
  ];

  String get hintText => widget.third == 1
      ? "الثلث الأول"
      : widget.third == 2
      ? "الثلث الثاني"
      : "الثلث الثالث";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _positionAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0.25, 0))
            .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: offset.dy,
        left: offset.dx - 80, // shift to the left of the button
        width: 160,
        child: Material(
          borderRadius: BorderRadius.circular(8),
          elevation: 6,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: dropdownOptions.length,
              separatorBuilder: (_, __) =>
              const Divider(color: Colors.grey, height: 1),
              itemBuilder: (_, index) {
                final option = dropdownOptions[index];
                return InkWell(
                  onTap: () {
                    setState(() => selectedValue = option);
                    _removeOverlay();
                    widget.onToggle();
                  },
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void didUpdateWidget(CustomDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen) {
      _controller.forward();
      WidgetsBinding.instance.addPostFrameCallback((_) => _showOverlay());
    } else {
      _controller.reverse();
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
      child: SlideTransition(
        position: _positionAnimation,
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
                text: hintText,
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
  }
}
