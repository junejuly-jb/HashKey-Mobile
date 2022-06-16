import 'package:flutter/material.dart';
import 'package:hashkey/shared/widgets/alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(onPressed: () async{ 
        final prefs = await SharedPreferences.getInstance();
        final success = await prefs.remove('user');
        if(success){
          Navigator.pushReplacementNamed(context, '/login');
        }
        else{
          const CustomAlert(message: 'Unable to log-out', type: 'error');
        }
      }, child: const Text('Logout')),
    );
  }
}