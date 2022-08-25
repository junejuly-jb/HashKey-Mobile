import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashkey/models/payment.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:provider/provider.dart';


class PaymentList extends StatelessWidget {
  final List arrayList;
  final Function onDeleteCallback;
  const PaymentList({Key? key, required this.arrayList, required this.onDeleteCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).theme;
    return ListView.builder(
      shrinkWrap: true,
        itemCount: arrayList.length,
        itemBuilder: (BuildContext context, int index){
          Payment payment = arrayList[index];
          return Container(
            margin: EdgeInsets.only(bottom: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: getGradient(payment.cardColor),
                begin: const Alignment(-1, 1),
                end: const Alignment(1, -1),
                stops: const [0.0, 1.0],
                tileMode: TileMode.clamp
              )
            ),
            padding: EdgeInsets.symmetric(vertical: 5.w),
            child:  Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        payment.cardName,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      const Spacer(),
                      // TODO: ADD CONTEXT MENU
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
                              const PopupMenuItem(
                                child: Text("Edit"),
                              ),
                              const PopupMenuItem(
                                child: Text("Copy card number"),
                              ),
                              const PopupMenuItem(
                                child: Text("Copy card expiry"),
                              ),
                              const PopupMenuItem(
                                child: Text("Copy card ccv"),
                              ),
                              PopupMenuItem(
                                child: const Text("Delete"),
                                value: 4,
                                onTap: (){
                                  List<String> ids = [];
                                  ids.add(payment.cardId);
                                  print(ids);
                                  onDeleteCallback('payment', ids);
                                },
                              )
                            ]
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 15.h,),
                  Text(
                    getCardNumber(payment.cardNumber),
                    style: TextStyle(
                      fontFamily: GoogleFonts.questrial().fontFamily,
                      color: Colors.white,
                      fontSize: 18.sp,
                      letterSpacing: 2
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    children: [
                      Text(
                        payment.cardExpiry,
                        style: const TextStyle(
                          color: Colors.white
                        ),
                      ),
                      const Spacer(),
                      Text(
                        payment.cardCcv,
                        style: const TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
    );
  }

  List<Color> getGradient(String color){
    List<Color> colors = [];
    switch (color) {
      case 'card_silver':
          colors.add(const Color.fromRGBO(253, 251, 251, 1));
          colors.add(const Color.fromRGBO(235, 237, 238, 1));
        break;

      case 'card_orange':
        colors.add(const Color.fromRGBO(248, 54, 0, 1));
        colors.add(const Color.fromRGBO(249, 212, 35, 1));
        break;
      
      case 'card_blue':
        colors.add(const Color.fromRGBO(79, 172, 254, 1));
        colors.add(const Color.fromRGBO(0, 242, 254, 1));
        break;
      
      case 'card_dark_blue':
        colors.add(const Color.fromRGBO(102, 126, 234, 1));
        colors.add(const Color.fromRGBO(118, 75, 162, 1));
        break;
      
      case 'card_red':
        colors.add(const Color.fromRGBO(255, 8, 68, 1));
        colors.add(const Color.fromRGBO(255, 177, 153, 1));
        break;
      
      case 'card_gold':
        colors.add(const Color.fromRGBO(230, 185, 128, 1));
        colors.add(const Color.fromRGBO(234, 205, 163, 1));
        break;
      
      case 'card_black':
        colors.add(const Color.fromRGBO(0, 0, 0, 1));
        colors.add(const Color.fromRGBO(67, 67, 67, 1));
        break;
    
      case 'card_dark_green':
        colors.add(const Color.fromRGBO(11, 163, 96, 1));
        colors.add(const Color.fromRGBO(60, 186, 146, 1));
        break;
      
      case 'card_green':
        colors.add(const Color.fromRGBO(32, 226, 215, 1));
        colors.add(const Color.fromRGBO(249, 254, 165, 1));
        break;
    }

    return colors;
  }

  String getCardNumber(String cardNum){
    String a = cardNum.substring(0, cardNum.length - 4);
    String b = a + '****';
    String cardNumber = StringUtils.addCharAtPosition(b, "  ", 4, repeat: true); 
    return cardNumber;
  }
}