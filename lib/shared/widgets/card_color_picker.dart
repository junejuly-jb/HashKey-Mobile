import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class CardColorPicker extends StatelessWidget {
  final String selected;
  final Function cardPickerCallback;
  const CardColorPicker({Key? key, required this.selected, required this.cardPickerCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).theme;
    return AlertDialog(
      backgroundColor: theme == 'dark' ? const Color.fromRGBO(42, 42, 42, 1) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0))
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    cardPickerCallback('card_orange');
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: selected == 'card_orange' ? const Icon(Icons.check, color: Colors.white,) : null,
                    radius: 15,
                    backgroundColor: Colors.orange,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    cardPickerCallback('card_silver');
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: selected == 'card_silver' ? const Icon(Icons.check, color: Colors.white,) : null,
                    radius: 15,
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    cardPickerCallback('card_blue');
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: selected == 'card_blue' ? const Icon(Icons.check, color: Colors.white,) : null,
                    radius: 15,
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h,),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    cardPickerCallback('card_dark_blue');
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: selected == 'card_dark_blue' ? const Icon(Icons.check, color: Colors.white,) : null,
                    radius: 15,
                    backgroundColor: Colors.blue[900],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    cardPickerCallback('card_red');
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: selected == 'card_red' ? const Icon(Icons.check, color: Colors.white,) : null,
                    radius: 15,
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    cardPickerCallback('card_gold');
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: selected == 'card_gold' ? const Icon(Icons.check, color: Colors.white,) : null,
                    radius: 15,
                    backgroundColor: Colors.yellow[900],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h,),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    cardPickerCallback('card_black');
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: selected == 'card_black' ? const Icon(Icons.check, color: Colors.white,) : null,
                    radius: 15,
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    cardPickerCallback('card_dark_green');
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: selected == 'card_dark_green' ? const Icon(Icons.check, color: Colors.white,) : null,
                    radius: 15,
                    backgroundColor: Colors.green[900],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    cardPickerCallback('card_green');
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: selected == 'card_green' ? const Icon(Icons.check, color: Colors.white,) : null,
                    radius: 15,
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}