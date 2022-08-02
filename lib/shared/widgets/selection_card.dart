import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class SelectionCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool isSelected;
  final Function callback;
  const SelectionCard({Key? key, required this.name, required this.icon, required this.isSelected, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).theme;
    return Container(
      decoration: BoxDecoration(
        color: getColor(isSelected, theme),
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          splashColor: Colors.blue,
          onTap: (){ callback(name); },
          child: SizedBox(
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

  Color getColor(bool isSelected, String theme){
    if(isSelected){
      return Colors.blue;
    }
    else if(theme == 'dark' && !isSelected){
      return const Color.fromRGBO(54, 54, 54, 1);
    }
    else{
      return Colors.white;
    }
  }
}