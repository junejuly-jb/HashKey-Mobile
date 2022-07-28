import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/shared/widgets/input.dart';
import 'package:hashkey/shared/widgets/passwordinput.dart';

class WifiForm extends StatefulWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final String ddValue;
  final Function callback;
  final Function callback2;
  final bool isVisible;
  const WifiForm({Key? key, required this.controller1, required this.controller2, required this.ddValue, required this.callback, required this.isVisible, required this.callback2}) : super(key: key);

  @override
  State<WifiForm> createState() => _WifiFormState();
}

class _WifiFormState extends State<WifiForm> {
  bool isPassVisible = false;

  togglePassVisibility(){
    setState(() => isPassVisible = !isPassVisible);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomInputWidget(myController: widget.controller1, hint: 'WiFi SSID', validation: null, autofocus: false,),
          SizedBox(height: 15.h,),
          CustomPasswordInputWidget(
            myController: widget.controller2, 
            hint: 'Password', 
            validation: null, 
            visible: isPassVisible,
            toggler: togglePassVisibility
          ),
          SizedBox(height: 15.h,),
          DropdownButtonFormField(
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
              contentPadding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 15.h)
            ),
            isExpanded: true,
            value: widget.ddValue,
            items: <String>['WEP', 'WPA/WPA2']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (val) {
              widget.callback(val);
            },
          ),
          SizedBox(height: 15.h,),
          Row(
            children: [
              Text('Wifi visibility:'),
              SizedBox(width: 5.w,),
              Text(widget.isVisible ? "Hidden" : "Visible", style: TextStyle( fontWeight: FontWeight.bold),),
              Spacer(),
              CupertinoSwitch(value: widget.isVisible, onChanged: (val){ 
                widget.callback2(val);
              })
            ],
          )
        ],
      ),
    ); 
  }
}