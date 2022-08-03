import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/shared/widgets/input.dart';
import 'package:hashkey/shared/widgets/note_color_picker.dart';

class NoteForm extends StatelessWidget {
  final String color;
  final TextEditingController controller1;
  final TextEditingController controller2;
  final Function onChooseColor;
  const NoteForm({Key? key, required this.controller1, required this.controller2, required this.color, required this.onChooseColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
           Row(
            children: [
              Text('Note color:', style: Theme.of(context).textTheme.subtitle1,),
              SizedBox(width: 15.w,),
              CircleAvatar(
                radius: 15,
                backgroundColor: getCardColor(color),
              ),
              const Spacer(),
              IconButton(
                onPressed: (){
                  showDialog(context: context, builder: (_) => NoteColorPicker(selected: color, cardPickerCallback: (val) => onChooseColor(val)));
                },
                icon: const Icon(Icons.colorize_rounded)
              ),
            ],
          ),
          SizedBox(height: 15.h,),
          CustomInputWidget(myController: controller1, hint: 'Title', validation: null, autofocus: false, keyboardType: 'text',),
          SizedBox(height: 15.h,),
          CustomInputWidget(myController: controller2, hint: 'Note', validation: null, autofocus: false,  keyboardType: 'text',),
          SizedBox(height: 15.h,),
        ],
      )
    );
  }


  Color getCardColor(String val){
    Color? myColor;
    switch (val) {
      case 'custom_red':
        myColor = Colors.red[400];
        break;
      case 'custom_orange':
        myColor = Colors.orange[400];
        break;
      case 'custom_yellow':
        myColor = Colors.yellow[400];
        break;
      case 'custom_green':
        myColor = Colors.green[400];
        break;
      case 'custom_teal':
        myColor = Colors.teal[400];
        break;
      case 'custom_blue':
        myColor = Colors.blue[400];
        break;
      case 'custom_darkblue':
        myColor = Colors.blue[900];
        break;
      case 'custom_purple':
        myColor = Colors.purple[400];
        break;
      case 'custom_pink':
        myColor = Colors.pink[400];
        break;
    }
    return myColor!;
  }
}