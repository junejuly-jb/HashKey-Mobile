import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectionCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool isSelected;
  final Function callback;
  const SelectionCard({Key? key, required this.name, required this.icon, required this.isSelected, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: !isSelected ? Colors.white : Colors.blue,
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          splashColor: Colors.blue,
          onTap: (){ callback(name); },
          child: Container(
            width: 120.w,
            height: 100.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: isSelected ? Colors.white : Colors.grey,),
                SizedBox(height: 10.h,),
                Text(name, style: TextStyle( color: isSelected ? Colors.white : Colors.grey,))
              ],
            ),
          ),
        ),
        color: Colors.transparent,
      ),
    );
  }
}