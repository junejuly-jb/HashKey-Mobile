import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallButton extends StatelessWidget {
  final IconData icon;
  final Function callback;
  const SmallButton({ Key? key, required this.icon, required this.callback }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
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
          child: Icon(icon, size: 15,),
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size.zero),
            padding:  MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 17.w, vertical: 5.h)),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            foregroundColor: MaterialStateProperty.all(Colors.white),
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