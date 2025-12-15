
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
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Log ud'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
