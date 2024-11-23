import 'package:credsafe/utils/sizes/size.dart';
import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  const CommonText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return  Text(
      text,
      style: const TextStyle(color: Colors.blue,fontSize: p15),
    );
  }
}
