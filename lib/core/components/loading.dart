import 'package:flutter/material.dart';

class LoadingIcon extends StatefulWidget {
  const LoadingIcon({super.key});

  @override
  _LoadingIconState createState() => _LoadingIconState();
}

class _LoadingIconState extends State<LoadingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();

    _animations = List.generate(4, (index) {
      return Tween<double>(begin: 0, end: 15).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index * 0.2, 1, curve: Curves.easeInOut),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, -_animations[index].value),
              child: child,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 5,
              backgroundColor: [
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.yellow
              ][index],
            ),
          ),
        );
      }),
    );
  }
}
