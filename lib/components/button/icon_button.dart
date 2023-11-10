import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.action,
  });

  final Icon icon;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => action.call(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: DecoratedBox(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 16,
                    spreadRadius: 8,
                    offset: const Offset(1, 4),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(padding: const EdgeInsets.all(8), child: icon),
          ),
        ),
      );
}
