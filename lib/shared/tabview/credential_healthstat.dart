import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

class CredentialHealthStatus extends StatelessWidget {
  const CredentialHealthStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          color: Colors.green,
          height: 50.h,
          child: SkeletonAvatar(
            style: SkeletonAvatarStyle(
              borderRadius: BorderRadius.circular(20.r)
            ),
          ),
        )
      ],
    );
  }
}