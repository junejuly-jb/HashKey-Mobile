import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({ Key? key }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 240, 247, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(
              children: [
                SizedBox(height: 50.h,),
                Row(
                  children: [
                    Text('Search...', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp, letterSpacing: 2),),
                    const Spacer(),
                    IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close))
                  ],
                ),
                SizedBox(height: 30.h,),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide( color: Colors.transparent, width: 0.w)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(color: Colors.transparent, width: 0.w)
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search ...",
                    contentPadding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 15.h)
                  ),
                ),
              ],
            ),
          )
        )
      )
    );
  }
}