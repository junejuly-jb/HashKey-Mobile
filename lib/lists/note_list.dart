import 'package:flutter/material.dart';
import 'package:hashkey/models/note.dart';

class NoteList extends StatelessWidget {
  final List arrayList;
  const NoteList({Key? key, required this.arrayList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
}