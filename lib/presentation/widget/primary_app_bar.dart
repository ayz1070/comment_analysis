import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double maxWidth;
  const PrimaryAppBar({super.key, required this.title, this.maxWidth = 420});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: AppBar(
            title: Text(title, style: GoogleFonts.notoSansKr(fontWeight: FontWeight.bold)),
            backgroundColor: AppColors.main,
            elevation: 2,
            centerTitle: true,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
} 