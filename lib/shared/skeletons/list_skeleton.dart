import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skeletons/skeletons.dart';

class ListSkeleton extends StatelessWidget {
  const ListSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonListView(padding: EdgeInsets.zero);
  }
}