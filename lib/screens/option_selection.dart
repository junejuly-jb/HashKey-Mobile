import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashkey/shared/widgets/appbar.dart';
import 'package:hashkey/shared/widgets/large_buttons.dart';
import 'package:hashkey/shared/widgets/selection_card.dart';

class OptionSelection extends StatefulWidget {
  const OptionSelection({Key? key}) : super(key: key);

  @override
  State<OptionSelection> createState() => _OptionSelectionState();
}

class _OptionSelectionState extends State<OptionSelection> {
  String selected = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          child: Column(
            children: [
              SizedBox(height: 50.h,),
              const CustomHeader(title: 'Select', withBackButton: true,),
              SizedBox(height: 30.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectionCard(
                    name: 'Password', 
                    icon: FontAwesomeIcons.lock,
                    callback: (val) => setState(() => selected = val),
                    isSelected: selected == 'Password' ? true : false,
                  ),
                  SizedBox(width: 20.w,),
                  SelectionCard(
                    name: 'Wifi', 
                    icon: FontAwesomeIcons.wifi,
                    callback: (val) => setState(() => selected = val),
                    isSelected: selected == 'Wifi' ? true : false,
                  ),
                ],
              ),
              SizedBox(height: 20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectionCard(
                    name: 'Payment', 
                    icon: FontAwesomeIcons.solidCreditCard,
                    callback: (val) => setState(() => selected = val),
                    isSelected: selected == 'Payment' ? true : false,
                  ),
                  SizedBox(width: 20.w,),
                  SelectionCard(name: 'Contact', 
                    icon: FontAwesomeIcons.idBadge,
                    callback: (val) => setState(() => selected = val),
                    isSelected: selected == 'Contact' ? true : false,
                  ),
                ],
              ),
              SizedBox(height: 20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectionCard(
                    name: 'Note', 
                    icon: FontAwesomeIcons.solidNoteSticky,
                    callback: (val) => setState(() => selected = val),
                    isSelected: selected == 'Note' ? true : false,
                  ),
                  SizedBox(width: 20.w,),
                  SelectionCard(
                    name: 'License', 
                    icon: FontAwesomeIcons.idCard,
                    callback: (val) => setState(() => selected = val),
                    isSelected: selected == 'License' ? true : false,
                  ),
                ],
              ),
              const Spacer(),
              XtraLargeButton(
                title: 'Next', 
                callback: () => Navigator.pushNamed(context, '/options/create', arguments: selected), 
                isGradient: true),
              SizedBox(height: 30.h,),
            ],
          ),
        ),
      ),
    );
  }
}