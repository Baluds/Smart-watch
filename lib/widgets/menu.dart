import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({
    required this.width,
    required this.height,
    required this.imageName,
    required this.multiple,
    required this.callback,
    Key? key,
  }) : super(key: key);
  final double width;
  final double height;
  final String imageName;
  final int multiple;
  final Function callback;
  check() {
    if (multiple == 1) {
      return const EdgeInsets.symmetric(horizontal: 8);
    } else if (multiple == 2) {
      return const EdgeInsets.only(left: 8);
    } else {
      return const EdgeInsets.only(right: 8);
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
            image: DecorationImage(
              image: AssetImage(imageName),
            ),
          ),
        ),
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
