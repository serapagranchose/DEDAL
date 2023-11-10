import 'package:flutter/material.dart';

class FilterIcon extends StatelessWidget {
  const FilterIcon({
    super.key,
    required this.icon,
    required this.title,
    required this.action,
  });

  final Icon icon;
  final String title;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => action.call(),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: AspectRatio(
            aspectRatio: 1.6,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  Text(
                    title,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
