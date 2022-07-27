import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashkey/models/category.dart';
import 'package:hashkey/provider/data_provider.dart';
import 'package:provider/provider.dart';

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

      case 'contact': {
        return FontAwesomeIcons.idBadge;
      }

      case 'license': {
        return FontAwesomeIcons.idCard;
      }

      case 'notes': {
        return FontAwesomeIcons.solidNoteSticky;
      }

      default: {
        return FontAwesomeIcons.solidPenToSquare;
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<DataProvider>(context).cards;

    return SizedBox(
      height: 120.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index){
          Category category = categories[index];
          return InkWell(
            onTap: () => Navigator.pushNamed(context, '/lists', arguments: {
              "type": category.category,
              "name": category.name
            } ),
            // onTap: () { print(category.name);},
            child: Container(
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
                      child: FaIcon(getIconForName(category.icon), color: const Color.fromRGBO(172, 203, 238, 1),)
                    ),
                  ),
                  SizedBox(height: 7.h,),
                  Text(category.name, style: TextStyle( fontSize: 15.sp, fontWeight: FontWeight.bold),),
                  Text(category.count.toString() + " " +category.content, style: TextStyle( fontSize: 12.sp, fontWeight: FontWeight.w400, color: Colors.grey[500]),)
                ],
              ),
            ),
          );
        }
      )
    );
  }
}