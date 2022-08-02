import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:hashkey/shared/widgets/card_color_picker.dart';
import 'package:hashkey/shared/widgets/input.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';

class CardForm extends StatefulWidget {
  final String color;
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;
  final Function callback;
  const CardForm({Key? key, required this.controller1, required this.controller2, required this.controller3, required this.color, required this.callback}) : super(key: key);

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).theme;

    // card_orange','card_blue','card_dark_blue','card_red','card_gold','card_silver','card_black','card_dark_green','card_green

    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Text('Card color:', style: Theme.of(context).textTheme.subtitle1,),
              SizedBox(width: 15.w,),
              CircleAvatar(
                radius: 15,
                backgroundColor: getCardColor(widget.color),
              ),
              const Spacer(),
              IconButton(onPressed: (){
                showDialog(context: context, builder: (_) => CardColorPicker(selected: widget.color, cardPickerCallback: (val) => widget.callback(val)));
              }, icon: const Icon(Icons.colorize_rounded)),
            ],
          ),
          SizedBox(height: 15.h,),
          CustomInputWidget(myController: widget.controller1, hint: 'Card name', validation: null, autofocus: false),
          SizedBox(height: 15.h,),
          CustomInputWidget(myController: widget.controller2, hint: 'Card number', validation: null, autofocus: false),
          SizedBox(height: 15.h,),
          Row(
            children: [
              Expanded(
                flex: 3,
                child:TextField(
                  style: TextStyle(
                    color: theme == 'dark' ? Colors.white : Colors.black
                  ),
                  enabled: false,
                  controller: widget.controller3,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: theme == 'dark' ? Colors.white : Colors.black
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide( color: Colors.transparent, width: 0.w)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(color: Colors.transparent, width: 0.w)
                    ),
                    filled: true,
                    fillColor: theme == 'dark' ? const Color.fromRGBO(54, 54, 54, 1) : Colors.white,
                    hintText: 'Expiration date',
                    contentPadding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 15.h)
                  ),
                ),
              ),
              
              Expanded(child: IconButton(onPressed: () async {
                final selected = await showMonthYearPicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2022),
                  lastDate: DateTime(2030),
                );
                print(selected);
              }, 
              icon: const Icon(Icons.date_range)))
            ],
          ),
          SizedBox(height: 15.h,),
          CustomInputWidget(myController: widget.controller2, hint: 'CCV', validation: null, autofocus: false)
        ],
      )
    );
  }

  Color getCardColor(String val){
    Color? myColor;
    switch (val) {
      case 'card_silver':
        myColor = Colors.grey;
        break;
      case 'card_orange':
        myColor = Colors.orange;
        break;
      case 'card_blue':
        myColor = Colors.blue;
        break;
      case 'card_dark_blue':
        myColor = Colors.blue[900];
        break;
      case 'card_red':
        myColor = Colors.red;
        break;
      case 'card_gold':
        myColor = Colors.yellow[900];
        break;
      case 'card_black':
        myColor = Colors.black;
        break;
      case 'card_dark_green':
        myColor = Colors.green[900];
        break;
      case 'card_green':
        myColor = Colors.green;
        break;
    }
    return myColor!;
  }
}