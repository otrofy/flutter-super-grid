import 'package:flutter/material.dart';

class ScrollControllerWidget extends StatelessWidget {
  final ScrollController controller;
  const ScrollControllerWidget(this.controller, {super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
            onTap: () {
              controller.animateTo(
                controller.offset - MediaQuery.of(context).size.width / 4,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        InkWell(
            onTap: () {
              controller.animateTo(
                controller.offset + MediaQuery.of(context).size.width / 4,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
            child: const Icon(Icons.arrow_forward, color: Colors.white))
      ],
    );
  }
}
