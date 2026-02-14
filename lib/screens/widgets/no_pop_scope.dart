import 'package:flutter/material.dart';

class NoPopScope extends StatelessWidget {
  final Widget child;
  const NoPopScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: child,
    );
  }
}
