import 'package:flutter/material.dart';

class HeaderWorker extends StatelessWidget {
  const HeaderWorker(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.iconLeft,
      required this.functionLeft,
      this.iconRight = '', // Menjadikan iconRight opsional, dengan default ''
      this.functionRight}); // Menjadikan functionRight opsional

  final String title;
  final String subtitle;
  final String iconLeft;
  final VoidCallback functionLeft;
  final String iconRight;
  final VoidCallback? functionRight; // Menjadikan functionRight opsional

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center, // Menjaga header tetap di tengah
        children: [
          IconButton.filled(
            onPressed: functionLeft,
            icon: ImageIcon(AssetImage(iconLeft)),
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Colors.white,
              ),
              foregroundColor: MaterialStatePropertyAll(
                Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          // Menangani jika iconRight dan functionRight null
          if (iconRight.isNotEmpty && functionRight != null)
            IconButton.filled(
              onPressed: functionRight,
              icon: ImageIcon(AssetImage(iconRight)),
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Colors.white,
                ),
                foregroundColor: MaterialStatePropertyAll(
                  Colors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
