import 'package:flutter/material.dart';

class IconButton extends StatelessWidget {
  IconButton({
    required this.icon,
    required this.action,
  });

  final IconData icon;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => print('ui'),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.pin_drop,
                color: Colors.black,
              ),
            ),
          ),
        ),
      );
}
