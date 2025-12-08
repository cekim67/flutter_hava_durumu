import 'package:flutter/material.dart';

/// Animated rain drop widget for rainy weather background
class RainDrop extends StatefulWidget {
  final int index;

  const RainDrop({super.key, required this.index});

  @override
  State<RainDrop> createState() => _RainDropState();
}

class _RainDropState extends State<RainDrop>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double left;
  late double duration;

  @override
  void initState() {
    super.initState();
    left = (widget.index * 37) % 100;
    duration = 1 + (widget.index % 3) * 0.5;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (duration * 1000).toInt()),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: left.toDouble(),
          top: _controller.value * MediaQuery.of(context).size.height,
          child: Container(
            width: 2,
            height: 15,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.white.withOpacity(0.1)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }
}
