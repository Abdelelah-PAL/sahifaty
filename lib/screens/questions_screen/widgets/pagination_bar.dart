import 'package:flutter/material.dart';

class PaginationBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;

  const PaginationBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    int endPage = (currentPage + 4).clamp(1, totalPages);

    List<int> pages = [for (int i = currentPage; i <= endPage; i++) i];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Page numbers
        ...pages.map((page) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: page == currentPage ? const Color(0xFF0B503D) : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            page.toString(),
            style: TextStyle(
              color: page == currentPage ? Colors.white : Colors.black,
              fontWeight: page == currentPage ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        )),
        // Forward arrow
        if (currentPage < totalPages)
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 16),
            onPressed: onNext,
          ),
      ],
    );
  }
}
