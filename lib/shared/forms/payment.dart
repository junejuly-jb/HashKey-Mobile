import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/shared/widgets/input.dart';
import 'package:month_year_picker/month_year_picker.dart';

class CardForm extends StatefulWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;
  const CardForm({Key? key, required this.controller1, required this.controller2, required this.controller3}) : super(key: key);

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Text('Card color:'),
              SizedBox(width: 15.w,),
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey,
              ),
              Spacer(),
              IconButton(onPressed: (){}, icon: Icon(Icons.colorize_rounded)),
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
                  enabled: false,
                  controller: widget.controller3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide( color: Colors.transparent, width: 0.w)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(color: Colors.transparent, width: 0.w)
                    ),
                    filled: true,
                    fillColor: Colors.white,
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
}