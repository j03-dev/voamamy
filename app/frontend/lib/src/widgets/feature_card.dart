import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback action;
  const FeatureCard({
    super.key,
    required this.icon,
    required this.label,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: action,
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, minHeight: 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 1.5),
        ),
        padding: EdgeInsets.symmetric(
          vertical: screenSize.height * 0.02,
          horizontal: screenSize.width * 0.02,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: constraints.maxWidth * 0.4),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.1,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
