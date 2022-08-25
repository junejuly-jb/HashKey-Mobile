import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashkey/models/contact.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:provider/provider.dart'; 

class ContactList extends StatelessWidget {
  final List arrayList;
  final Function onDeleteCallback;
  const ContactList({Key? key, required this.arrayList, required this.onDeleteCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).theme;
    return ListView.builder(
      itemCount: arrayList.length,
      itemBuilder: (BuildContext context, int index){
        Contact contact = arrayList[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: InkWell(
            splashColor: Colors.blue[200],
            onTap: () => print('Test'),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: getAvatarColor(contact.contactAvatarColor),
                    child: const Icon(FontAwesomeIcons.user, color: Colors.white,),
                  ),
                  SizedBox(width: 20.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.contactFname + " " + contact.contactLname,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(height: 3.h,),
                      Text(
                        contact.contactNumber,
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  ),
                  const Spacer(),
                  PopupMenuButton(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))
                    ),
                    color: theme == 'dark' ? const Color.fromRGBO(54, 54, 54, 1) : Colors.white,
                    child: const  Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10, 
                            vertical: 20
                          ),
                          child: Icon(FontAwesomeIcons.ellipsisVertical),
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: const Text("Delete"),
                            onTap: (){
                              List<String> ids = [];
                              ids.add(contact.contactId);
                              print(ids);
                              onDeleteCallback('contact', ids);
                            },
                          )
                        ]
                  ),
                ],
              ),
            )
          ),
        );
      }
    );
  }

  Color getAvatarColor(String val){
    Color? color;
    switch (val) {
      case 'red':
        color = Colors.red;
        break;
      case 'pink':
        color = Colors.pink;
        break;
      case 'purple':
        color = Colors.purple;
        break;
      case 'indigo':
        color = Colors.indigo;
        break;
      case 'blue':
        color = Colors.blue;
        break;
      case 'cyan':
        color = Colors.cyan;
        break;
      case 'teal':
        color = Colors.teal;
        break;
      case 'green':
        color = Colors.green;
        break;
      case 'lime':
        color = Colors.lime;
        break;
      case 'orange':
        color = Colors.orange;
        break;
      case 'brown':
        color = Colors.brown;
        break;
    }

    return color!;
  }
}