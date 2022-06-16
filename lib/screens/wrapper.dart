import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/provider/user_provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  _checkAuth() async{
    await Future.delayed(const Duration(seconds: 2));
    final prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString('user');
    if(user != null){
      final Map userData = jsonDecode(user);
      bool isExpired = JwtDecoder.isExpired(userData['token']);
      if(userData['token'] == null || isExpired){
        await prefs.remove('user');
        Navigator.pushReplacementNamed(context, '/welcome');
      }
      else{
        Provider.of<UserProvider>(context, listen: false).getUserDetails();
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
    else{
        Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingAnimationWidget.inkDrop(color: Colors.indigo, size: 20),
                SizedBox(width: 15.w),
                const Text('Authenticating...')
              ],
            ),
          )
        ],
      ),
    ); 
  }
}