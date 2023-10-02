import 'package:dedal/constants/colors.dart';
import 'package:flutter/material.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton({super.key, this.onTap, this.text, this.color});

  final VoidCallback? onTap;
  final String? text;
  final Color? color;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => onTap != null ? onTap!.call() : null,
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color: color ?? SharedColorPalette().main,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  )
                ], //B,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: Text(
                text ?? 'valider',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      );
}
