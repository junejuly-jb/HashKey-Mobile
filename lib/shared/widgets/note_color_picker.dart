import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class NoteColorPicker extends StatelessWidget {
  final String selected;
  final Function cardPickerCallback;
  const NoteColorPicker({Key? key, required this.selected, required this.cardPickerCallback}) : super(key: key);

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
                    cardPickerCallback('custom_red');
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: selected == 'custom_red' ? const Icon(Icons.check, color: Colors.white,) : null,
                    radius: 15,
                    backgroundColor: Colors.red[400],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    cardPickerCallback('custom_orange');
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: selected == 'custom_orange' ? const Icon(Icons.check, color: Colors.white,) : null,
                    radius: 15,
                    backgroundColor: Colors.orange[400],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    cardPickerCallback('custom_yellow');
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: selected == 'custom_yellow' ? const Icon(Icons.check, color: Colors.white,) : null,
                    radius: 15,
                    backgroundColor: Colors.yellow[400],
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
                    cardPickerCallback('custom_green');
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: selected == 'custom_green' ? const Icon(Icons.check, color: Colors.white,) : null,
                    radius: 15,
                    backgroundColor: Colors.green[400],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    cardPickerCallback('custom_teal');
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: selected == 'custom_teal' ? const Icon(Icons.check, color: Colors.white,) : null,
                    radius: 15,
                    backgroundColor: Colors.teal[400],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    cardPickerCallback('custom_blue');
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: selected == 'custom_blue' ? const Icon(Icons.check, color: Colors.white,) : null,
                    radius: 15,
                    backgroundColor: Colors.blue[400],
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
                    cardPickerCallback('custom_darkblue');
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: selected == 'custom_darkblue' ? const Icon(Icons.check, color: Colors.white,) : null,
                    radius: 15,
                    backgroundColor: Colors.blue[900],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    cardPickerCallback('custom_purple');
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: selected == 'custom_purple' ? const Icon(Icons.check, color: Colors.white,) : null,
                    radius: 15,
                    backgroundColor: Colors.purple[400],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    cardPickerCallback('custom_pink');
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: selected == 'custom_pink' ? const Icon(Icons.check, color: Colors.white,) : null,
                    radius: 15,
                    backgroundColor: Colors.pink[400],
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