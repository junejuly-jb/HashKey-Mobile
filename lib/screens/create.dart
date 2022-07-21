import 'package:flutter/material.dart';

class CreateNew extends StatelessWidget {
  const CreateNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as String;
    print(arg);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Text('data'),
              Text('data'),
              Text('data'),
            ],
          ),
        ),
      ),
    );
  }
}