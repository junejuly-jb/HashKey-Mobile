import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/models/payment.dart';


class PaymentList extends StatelessWidget {
  final List arrayList;
  const PaymentList({Key? key, required this.arrayList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: add new layouts for cards
    return ListView.builder(
      shrinkWrap: true,
        itemCount: arrayList.length,
        itemBuilder: (BuildContext context, int index){
          Payment payment = arrayList[index];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.green,
            ),
            padding: EdgeInsets.symmetric(vertical: 5.w),
            child:  Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(payment.cardName),
                  SizedBox(height: 25.h,),
                  Text(payment.cardNumber),
                  SizedBox(height: 5.h,),
                  Row(
                    children: [
                      Text(payment.cardExpiry),
                      Text(payment.cardCcv),
                    ],
                  )
                ],
              ),
            ),
          );
        },
    );
  }
}