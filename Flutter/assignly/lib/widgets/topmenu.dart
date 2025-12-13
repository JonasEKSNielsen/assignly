
import 'package:assignly/colors.dart';
import 'package:flutter/material.dart';

class TopMenu extends StatelessWidget implements PreferredSizeWidget {
  const TopMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Assignly', style: TextStyle(color: Colors.white)),
      backgroundColor: ocean1,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text('Planning', style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Reporting', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Sign in'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
