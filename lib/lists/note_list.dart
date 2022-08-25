
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashkey/models/note.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:provider/provider.dart';

class NoteList extends StatelessWidget {
  final List arrayList;
  final Function onDeleteCallback;
  const NoteList({Key? key, required this.arrayList, required this.onDeleteCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).theme;
    return MasonryGrid(
      column: 2,
      children: List.generate(
        arrayList.length, (index){
          Note note = arrayList[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r)
            ),
            color: getNoteColor(note.noteColor, theme),
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        note.noteTitle,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold
                        ),  
                      ),
                      const Spacer(),
                      PopupMenuButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0))
                        ),
                        color: theme == 'dark' ? const Color.fromRGBO(54, 54, 54, 1) : Colors.white,
                        child: const Icon(
                              FontAwesomeIcons.ellipsisVertical, color: Colors.black,
                              size: 20,
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: const Text("Delete"),
                                value: 4,
                                onTap: (){
                                  List<String> ids = [];
                                  ids.add(note.noteId);
                                  onDeleteCallback('note', ids);
                                },
                              )
                            ]
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Text(
                    getNoteContent(note.noteContent)
                  ),
                ],
              ),
            ),
          );
        }
      )
    );
  }

  Color getNoteColor(String val, String theme){
    Color? myColor;
    switch (val) {
      case 'custom_red':
        myColor = theme == 'light' ? Colors.red[100] : Colors.red[400];
        break;
      case 'custom_orange':
        myColor = theme == 'light' ? Colors.orange[100] : Colors.orange[400];
        break;
      case 'custom_yellow':
        myColor = theme == 'light' ? Colors.yellow[100] : Colors.yellow[400];
        break;
      case 'custom_green':
        myColor = theme == 'light' ? Colors.green[100] : Colors.green[400];
        break;
      case 'custom_teal':
        myColor = theme == 'light' ? Colors.teal[100] : Colors.teal[400];
        break;
      case 'custom_blue':
        myColor = theme == 'light' ? Colors.blue[100] : Colors.blue[400];
        break;
      case 'custom_darkblue':
        myColor = theme == 'light' ? Colors.blue[400] :  Colors.blue[900];
        break;
      case 'custom_purple':
        myColor = theme == 'light' ? Colors.purple[100] :  Colors.purple[400];
        break;
      case 'custom_pink':
        myColor = theme == 'light' ? Colors.pink[100] :  Colors.pink[400];
        break;
      default:
        myColor = theme == 'light' ? Colors.lime[100] :  Colors.lime[900];
        break;
    }
    return myColor!;
  }

  String getNoteContent(String val){
    String text = val.length > 140 ? val.substring(0, 140) + '...' : val;
    return text;
  }
}