import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/models/contact.dart'; 

class ContactList extends StatelessWidget {
  final List arrayList;
  const ContactList({Key? key, required this.arrayList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: arrayList.length,
      itemBuilder: (BuildContext context, int index){
        //TODO: Polish design for contacts
        Contact contact = arrayList[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: InkWell(
            splashColor: Colors.blue[200],
            onTap: () => print('Test'),
            child: ListTile(
              minLeadingWidth: 55.w,
              leading: const CircleAvatar(backgroundColor: Colors.red,),
              title: Text(
                contact.contactFname + " " + contact.contactLname
              ),
              subtitle: Text(contact.contactNumber),
            ),
          ),
        );
      }
    );
  }
}