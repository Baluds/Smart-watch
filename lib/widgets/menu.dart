import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({
    required this.width,
    required this.height,
    required this.multiple,
    required this.callback,
    required this.menuColor,
    required this.childWidget,
    Key? key,
  }) : super(key: key);
  final double width;
  final double height;
  final int multiple;
  final Function callback;
  final Color menuColor;
  final Widget childWidget;
  check() {
    if (multiple == 1) {
      return const EdgeInsets.symmetric(horizontal: 10, vertical: 12);
    } else if (multiple == 2) {
      return const EdgeInsets.only(left: 8, right: 10, top: 10, bottom: 12);
    } else {
      return const EdgeInsets.only(right: 8, left: 10, top: 10, bottom: 12);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            margin: check(),
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: menuColor,
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: childWidget),
        Positioned.fill(
            child: Material(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
          child: InkResponse(
            highlightShape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            onTap: () => callback(),
          ),
        ))
      ],
    );
  }
}
