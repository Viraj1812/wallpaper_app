import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.categoryName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: isSelected ? Colors.blue : null,
        child: SizedBox(
          width: 0.4 * MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              categoryName,
              style: GoogleFonts.montserrat(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
