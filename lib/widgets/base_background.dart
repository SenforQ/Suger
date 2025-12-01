import 'package:flutter/material.dart';

class BaseBackground extends StatelessWidget {
  const BaseBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: child,
    );
  }
}

