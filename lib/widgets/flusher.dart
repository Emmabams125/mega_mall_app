import 'package:flutter/material.dart';

class Flusher {
  static OverlayEntry? _entry;

  static void show(
    BuildContext context,
    String message, {
    Color color = Colors.green,
    Duration duration = const Duration(seconds: 2),
  }) {
    _entry?.remove();

    final overlay = Overlay.of(context);

    _entry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: _FlushCard(
            message: message,
            color: color,
          ),
        ),
      ),
    );

    overlay.insert(_entry!);

    Future.delayed(duration, () {
      _entry?.remove();
      _entry = null;
    });
  }

  static void success(BuildContext context, String message) {
    show(context, message, color: Colors.green);
  }

  static void error(BuildContext context, String message) {
    show(context, message, color: Colors.red);
  }
}

class _FlushCard extends StatelessWidget {
  final String message;
  final Color color;

  const _FlushCard({
    required this.message,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black26,
          )
        ],
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}