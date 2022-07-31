import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final bool withBackButton;
  const CustomHeader({ Key? key, required this.title, required this.withBackButton }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 4,child: Text(title, style: Theme.of(context).textTheme.headline1!)),
        const Spacer(),
        Expanded(
          flex: 1,
          child: Container(
            child: withBackButton ? IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)) : null,
          ),
        )
      ],
    );
  }
}