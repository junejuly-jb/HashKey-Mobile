import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashkey/lists/contact_list.dart';
import 'package:hashkey/lists/license_list.dart';
import 'package:hashkey/lists/note_list.dart';
import 'package:hashkey/lists/password_list.dart';
import 'package:hashkey/lists/payment_list.dart';
import 'package:hashkey/lists/wifi_list.dart';
import 'package:hashkey/provider/data_provider.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:hashkey/services/app.dart';
import 'package:hashkey/shared/skeletons/list_skeleton.dart';
import 'package:hashkey/shared/widgets/alert.dart';
import 'package:hashkey/shared/widgets/appbar.dart';
import 'package:hashkey/shared/widgets/question_alert.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

class Lists extends StatefulWidget {
  const Lists({ Key? key }) : super(key: key);

  @override
  State<Lists> createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  bool isLoading = false;
  late List myArray = [];
  late Map arg;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, (){
      setState(() {
        arg = ModalRoute.of(context)?.settings.arguments as Map;
      });
      initCredential(arg);
    });
  }

  @override
  void setState(fn){
      if(mounted){
        super.setState(fn);
      }
  }

  onDeleteCredential(String type, List<String> ids, BuildContext context) {
    Future.delayed(Duration.zero).then((value){
      showDialog(
        context: context, builder: (_) => 
        QuestionDialog(
          message: 'Delete $type \'s?',
          onConfirm: (val) async {
            if(!val){
              return Navigator.pop(context);
            }
            Navigator.pop(context);
            showDialog(barrierDismissible: false, context: context, builder: (_) => const CustomAlert(message: 'Deleting credential please wait.', type: 'loading', statusType: null, callback: null));
            String endpoint = getDeleteEndpoint(type);
            Map result = await App().deleteCredential(endpoint, ids);
            Navigator.pop(context);
            print(result);
            if(!result['success'] && mounted){
              if(result['status'] == 401 && mounted){
                return showDialog(
                  barrierDismissible: false,
                  context: context, builder: (_) => 
                  CustomAlert(message: result['message'], type: 'error', statusType: 'error', callback: () {
                    Provider.of<DataProvider>(context, listen: false).setEmpty();
                    Navigator.pushNamedAndRemoveUntil(context, '/authenticate', (route) => false);  
                  })
                );
              }
              else{
                return showDialog(
                  context: context, builder: (_) => 
                  CustomAlert(message: result['message'], type: 'error', statusType: 'error', callback: () => Navigator.pop(context))
                );
              }
            }
            Provider.of<DataProvider>(context, listen: false).deleteCredential(type, ids);
            removeFromLocalState(type, ids);
            Fluttertoast.showToast(msg: result['message']);
          },
        )
      );
    });
  }

  removeFromLocalState(String type, List ids){
    switch (type) {
      case 'password':
        setState(()=> myArray.removeWhere((element) => ids.contains(element.logId)));
        break;
      case 'wifi':
        setState(()=> myArray.removeWhere((element) => ids.contains(element.wifiId)));
        break;
      case 'payment':
        setState(()=> myArray.removeWhere((element) => ids.contains(element.cardId)));
        break;
      case 'contact':
        setState(()=> myArray.removeWhere((element) => ids.contains(element.contactId)));
        break;
      case 'license':
        setState(()=> myArray.removeWhere((element) => ids.contains(element.licenseId)));
        break;
      case 'note':
        setState(()=> myArray.removeWhere((element) => ids.contains(element.noteId)));
        break;
    }
  }

  Future initCredential(Map data) async {
    setState(() => isLoading = true,);
    List array = Provider.of<DataProvider>(context, listen: false).getCategoryType(data['type']);
    setState( () => myArray = array );
    if(array.isEmpty){ 
      String endpoint = getPostEndpoint(data);
      Map result = await App().getCredentials(endpoint);
      setState(() => isLoading = false,);
      if(result['success'] && mounted){
        switch (data['type']) {
          case 'password':
            Provider.of<DataProvider>(context, listen: false).setPasswords(result['data']);
            break;
          case 'wifi':
            Provider.of<DataProvider>(context, listen: false).setWifis(result['data']);
            break;
          case 'payment':
            Provider.of<DataProvider>(context, listen: false).setPayments(result['data']);
            break;
          case 'contact':
            Provider.of<DataProvider>(context, listen: false).setContacts(result['data']);
            break;
          case 'license':
            Provider.of<DataProvider>(context, listen: false).setLicenses(result['data']);
            break;
          case 'note':
            Provider.of<DataProvider>(context, listen: false).setNotes(result['data']);
            break;
        }
      }
      else{
        if(result['status'] == 401 && mounted){
          showDialog(
            barrierDismissible: false,
            context: context, builder: (_) => 
            CustomAlert(message: result['message'], type: 'error', statusType: 'error', callback: (){
              Provider.of<DataProvider>(context, listen: false).setEmpty();
              Navigator.pushNamedAndRemoveUntil(context, '/authenticate', (route) => false);
            })
          );
        }
        else{
          if(mounted){
            showDialog(
              context: context, builder: (_) => 
              CustomAlert(message: result['message'], type: 'error', statusType: null, callback: () => Navigator.pop(context))
            );
          }
        }
      }
    }
    //TODO: check if the localdata and server data is on the same lengths
    else{
      setState(() {
        isLoading = false;
      });
    }
  }

  String getPostEndpoint(Map data){
    String endpoint = '';
    switch (data['type']) {
      case 'password':
        endpoint = 'passwords';
        break;
      case 'wifi':
        endpoint = 'wifis';
        break;
      case 'note':
        endpoint = 'notes';
        break;
      case 'payment':
        endpoint = 'cards';
        break;
      case 'license':
        endpoint = 'licenses';
        break;
      case 'contact':
        endpoint = 'contacts';
        break;
    }
    return endpoint;
  }


  String getDeleteEndpoint(String val){
    String endpoint = '';
    switch (val) {
      case 'password':
        endpoint = 'delete-password';
        break;
      case 'wifi':
        endpoint = 'delete-wifi';
        break;
      case 'note':
        endpoint = 'delete-note';
        break;
      case 'payment':
        endpoint = 'delete-card';
        break;
      case 'license':
        endpoint = 'delete-license';
        break;
      case 'contact':
        endpoint = 'delete-contact';
        break;
    }
    return endpoint;
  }

  void copyData(String val){
    Clipboard.setData(ClipboardData(text: val))
    .then((value) => Fluttertoast.showToast(msg: 'Text copied successfully!'));
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as Map;
    final theme = Provider.of<ThemeProvider>(context).theme;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 50.h,),
                CustomHeader(title: arg['name'], withBackButton: true),
                SizedBox(height: 5.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: (){}, 
                      icon: const Icon(Icons.sort)
                    ),
                    IconButton(
                      onPressed: (){}, 
                      icon: const Icon(Icons.refresh_rounded)
                    )
                  ],
                ),
                SizedBox(height: 5.h,),
                SizedBox(
                  height: 470.h,
                  // color: Colors.amber,
                  child: widgetType(isLoading, myArray, arg['type'], theme, context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetType(bool state, List array, String type, String theme, BuildContext context){
    // print(array);
    print('build');
    if(state){
      return SkeletonTheme(
        themeMode: theme == 'dark' ? ThemeMode.dark : ThemeMode.light,
        //TODO: Configure skeleton listview on each category
        child: skeletonType(type)
      );
    }
    else if(!state && array.isEmpty){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(FontAwesomeIcons.folderOpen, size: 40,),
            SizedBox(height: 20.h,),
            Text(
              'Your vault is empty',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      );
    }
    else{
      return listViewType(type, context);
    }
  }

  Widget listViewType(String type, BuildContext context){
    var arrayList = Provider.of<DataProvider>(context, listen: false).getCategoryType(type);
    if(type == 'password'){
      return PasswordList(
        arrayList: arrayList, 
        onDeleteCallback: (type, ids) => onDeleteCredential(type, ids, context),
        onCopyData: (data) => copyData(data) 
      );
    }
    else if(type == 'wifi'){
      return WifiList(
        arrayList: arrayList, 
        onDeleteCallback: (type, ids) => onDeleteCredential(type, ids, context),
        onCopyData: (data) => copyData(data),
      );
    }
    else if(type == 'payment'){
      return PaymentList(
        arrayList: arrayList, 
        onDeleteCallback: (type, ids) => onDeleteCredential(type, ids, context),
        onCopyData: (data) => copyData(data),
      );
    }
    else if(type == 'contact'){
      return ContactList(arrayList: arrayList, onDeleteCallback: (type, ids) => onDeleteCredential(type, ids, context),);
    }
    else if(type == 'license'){
      return LicenseList(arrayList: arrayList, onDeleteCallback: (type, ids) => onDeleteCredential(type, ids, context),);
    }
    else if(type == 'note'){
      return NoteList(arrayList: arrayList, onDeleteCallback: (type, ids) => onDeleteCredential(type, ids, context),);
    }
    else{
      return Container();
    }
  }

  Widget skeletonType(String type){
    if(type == 'password' || type == 'wifi' || type == 'contact'){
      return const ListSkeleton();
    }
    else{
      // return SkeletonParagraph();
      return SkeletonAvatar(
        style: SkeletonAvatarStyle(
          width: double.infinity, height: 100),
      );
    }
  }
}