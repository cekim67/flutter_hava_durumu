import 'package:flutter/material.dart';

/// Animated snowflake widget for snowy weather background
class SnowFlake extends StatefulWidget {
  final int index;

  const SnowFlake({super.key, required this.index});

  @override
  State<SnowFlake> createState() => _SnowFlakeState();
}

class _SnowFlakeState extends State<SnowFlake>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double left;
  late double duration;
  late double size;

  @override
  void initState() {
    super.initState();
    left = (widget.index * 43) % 100;
    duration = 3 + (widget.index % 4) * 0.5;
    size = 4 + (widget.index % 3) * 2;

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
          left: left + (10 * _controller.value),
          top: _controller.value * MediaQuery.of(context).size.height,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
