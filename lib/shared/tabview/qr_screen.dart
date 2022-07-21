import 'package:flutter/material.dart';
import 'package:hashkey/shared/widgets/qr_view.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code Scanner', style: TextStyle(color: Colors.black),), backgroundColor: const Color.fromRGBO(241, 240, 247, 1), elevation: 0,),
      body: const QRViewExample(),
      
      // Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       Navigator.of(context).push(MaterialPageRoute(
      //         builder: (context) => const QRViewExample(),
      //       ));
      //     },
      //     child: const Text('qrView'),
      //   ),
      // ),
    );
  }
}