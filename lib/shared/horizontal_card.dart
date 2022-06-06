import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Cards extends StatelessWidget {
  const Cards({ Key? key }) : super(key: key);

  IconData getIconForName(String iconName) {
    switch(iconName) {
      case 'wifi': {
      return FontAwesomeIcons.wifi;
      }

      case 'lock': {
        return FontAwesomeIcons.lock;
      }

      case 'card': {
        return FontAwesomeIcons.solidCreditCard;
      }

      default: {
        return FontAwesomeIcons.solidPenToSquare;
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    List categories = [
      {
        "name": "Passwords",
        "category": "password",
        "icon": "lock",
        "content": "1 password"
      },
      {
        "name": "Wifi",
        "category": "wifi",
        "icon": "wifi",
        "content": "3 passwords"
      },
      {
        "name": "Payments",
        "category": "payment",
        "icon": "card",
        "content": "3 cards"
      }
    ];

    return SizedBox(
      height: 120.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index){
          Map myCategory = categories[index];
          return Container(
            width: 105.w,
            margin: EdgeInsets.symmetric(horizontal: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: Colors.white
            ),
            child: Column(
              children: [
                SizedBox(height: 15.h,), 
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(231, 240, 253, 1),
                    borderRadius: BorderRadius.circular(100.r)
                  ),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromRGBO(231, 240, 253, 1),
                    radius: 15.r,
                    child: FaIcon(getIconForName(myCategory['icon']), color: const Color.fromRGBO(172, 203, 238, 1),)
                  ),
                ),
                SizedBox(height: 7.h,),
                Text(myCategory['name'], style: TextStyle( fontSize: 15.sp, fontWeight: FontWeight.bold),),
                Text(myCategory['content'], style: TextStyle( fontSize: 12.sp, fontWeight: FontWeight.w400, color: Colors.grey[500]),)
              ],
            ),
          );
        }
      )
    );
  }
}