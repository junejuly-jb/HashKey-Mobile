import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class QuestionDialog extends StatelessWidget {
  final String message;
  final Function onConfirm;
  const QuestionDialog({Key? key, required this.message, required this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).theme;
    return AlertDialog(
      backgroundColor: theme == 'dark' ? const Color.fromRGBO(54, 54, 54, 1) : Colors.white,
      shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(FontAwesomeIcons.trash),
              SizedBox(width: 10.w,),
              Text(
                'Delete', 
                style: TextStyle(
                  fontSize: 15.sp,
                  color: theme == 'dark' ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          SizedBox(height: 15.h,),
          Text('Are you sure you want to delete this credential?', style: Theme.of(context).textTheme.subtitle1,)
        ],
      ),
      actions: [
        TextButton(onPressed: (){ onConfirm(false); }, child: const Text('Cancel')),
        TextButton(onPressed: (){ onConfirm(true); }, child: const Text('Delete')),
      ],
    );
  }
}