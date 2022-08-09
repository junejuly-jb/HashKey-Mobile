import 'package:flutter/material.dart';
import 'package:hashkey/models/note.dart';

class NoteList extends StatelessWidget {
  final List arrayList;
  const NoteList({Key? key, required this.arrayList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: Enhance UI on cards.
    return GridView.builder(
      itemCount: arrayList.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20
      ), 
      itemBuilder: (BuildContext context, index){
        Note note = arrayList[index];
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Text(note.noteTitle),
        );
      }
    );
  }

  //TODO: update color on notes based on noteColor in database
  Color getNoteColor(String val){
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