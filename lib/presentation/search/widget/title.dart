import 'package:flutter/material.dart';

class textSearchtitle extends StatelessWidget {
  final String title;
  const textSearchtitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
    );
  }
}
