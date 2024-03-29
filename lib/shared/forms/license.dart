import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:hashkey/shared/widgets/input.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class LicenseForm extends StatelessWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;
  final List items;
  final String string2, string3;
  final Function callback1, callback2;
  const LicenseForm({Key? key, required this.controller1, required this.controller2, required this.controller3, required this.items, required this.string2, required this.string3, required this.callback1, required this.callback2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).theme;
    return Form(
      child: Column(
        children: [
          CustomInputWidget(myController: controller1, hint: 'Name', validation: null, autofocus: false, keyboardType: 'text'),
          SizedBox(height: 15.h,),
          CustomInputWidget(myController: controller2, hint: 'License Number', validation: null, autofocus: false, keyboardType: 'text'),
          SizedBox(height: 15.h,),
          Row(
            children: [
              Expanded(
                flex: 3,
                child:TextField(
                  style: TextStyle(
                    color: theme == 'dark' ? Colors.white : Colors.black
                  ),
                  readOnly: true,
                  controller: controller3,
                  decoration: InputDecoration(
                    suffixIcon: controller3.text.isNotEmpty ? GestureDetector(
                      onTap: () => controller3.text = '',
                      child: Icon(Icons.close, color: theme == 'light' ? Colors.grey : Colors.white,)
                    ) : null,
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
                DateTime selectedDate = DateTime.now();
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2015, 8),
                    lastDate: DateTime(2101));
                if (picked != null && picked != selectedDate) {
                  String formattedDate = DateFormat("yyyy-MM-dd").format(picked);
                  controller3.text = formattedDate;
                }
              }, 
              icon: const Icon(Icons.date_range)))
            ],
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
              fillColor: theme == 'dark' ? const Color.fromRGBO(54, 54, 54, 1) : Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 15.h)
            ),
            isExpanded: true,
            value: string2,
            items: items.map((e) => 
              DropdownMenuItem<String>(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(e['flags']['png']),
                    ),
                    SizedBox(width: 10.w),
                    Text(e['name']['common'])
                  ],
                ),
                value: e['name']['common'],
              )
            ).toList(),
            onChanged: (val) {
              int idx = items.indexWhere((element) => element['name']['common'] == val);
              callback1(val);
              callback2(items[idx]['flags']['png']);
            },
          ),
        ],
      )
    );
  }
}