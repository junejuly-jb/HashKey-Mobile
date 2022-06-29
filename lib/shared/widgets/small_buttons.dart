import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class XtraLargeButton extends StatelessWidget {
  final String title;
  final Function callback;
  const XtraLargeButton({ Key? key, required this.title, required this.callback }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(106, 17, 203, 1),
              Color.fromRGBO(37, 117, 252, 1),
            ],
            begin: Alignment(-1, 1),
            end: Alignment(1, -1),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp)
        ),
        child: TextButton(
          onPressed: () {
            callback();
          }, 
          child: Text(title, style: TextStyle( fontSize: 15.sp, fontWeight: FontWeight.w700 ),),
          style: ButtonStyle(
            // backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(34, 166, 255, 1)),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 13.h)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r)
              ),
            ),
          ),
        ),
      ),
    );
  }
}