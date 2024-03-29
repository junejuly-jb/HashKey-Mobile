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
import 'package:hashkey/shared/skeletons/card_skeleton.dart';
import 'package:hashkey/shared/skeletons/list_skeleton.dart';
import 'package:hashkey/shared/widgets/alert.dart';
import 'package:hashkey/shared/widgets/appbar.dart';
import 'package:hashkey/shared/widgets/question_alert.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

class Lists extends StatefulWidget {
  const Lists({ Key? key }) : super(key: key);

  @override
  State<Lists> createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  bool isLoading = false;
  bool isUpdating = false;
  bool isRefreshing = false;
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
        setState(()=> myArray.removeWhere((element) => ids.contains(element['log_id'])));
        break;
      case 'wifi':
        setState(()=> myArray.removeWhere((element) => ids.contains(element['wifi_id'])));
        break;
      case 'payment':
        setState(()=> myArray.removeWhere((element) => ids.contains(element['card_id'])));
        break;
      case 'contact':
        setState(()=> myArray.removeWhere((element) => ids.contains(element['contact_id'])));
        break;
      case 'license':
        setState(()=> myArray.removeWhere((element) => ids.contains(element['license_id'])));
        break;
      case 'note':
        setState(()=> myArray.removeWhere((element) => ids.contains(element['note_id'])));
        break;
    }
  }

  Future initCredential(Map data) async {
    List array = Provider.of<DataProvider>(context, listen: false).getCategoryType(data['type']);
    setState( () => myArray = array );
    if(myArray.isNotEmpty){
      setState(() => isUpdating = true );
    }
    else{
      setState(() => isLoading = true );
    }
    String endpoint = getPostEndpoint(data);
    Map result = await App().getCredentials(endpoint);
    if(!result['success'] && mounted){
      if(result['status'] == 401 && mounted){
        return showDialog(
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
          return showDialog(
            context: context, builder: (_) => 
            CustomAlert(message: result['message'], type: 'error', statusType: null, callback: () => Navigator.pop(context))
          );
        }
      }
    }
    if(myArray.isNotEmpty){
      Fluttertoast.showToast(msg: 'Credentials are up to date');
    }
    Provider.of<DataProvider>(context, listen: false).setEmptyByType(data['type']);
    Provider.of<DataProvider>(context, listen: false).setCredentialsFromAPI(result['data'], data['type']);
    setState(() {
      myArray = result['data'];
      isLoading = false;
      isUpdating = false;
    });
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
                            child: Icon(Icons.sort)
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 30.w,
                                    child: const Icon(Icons.check)
                                  ),
                                  SizedBox(width: 10.w,),
                                  const Text('Date added')
                                ],
                              ),
                              onTap: (){},
                            ),
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 30.w,
                                    child: null
                                  ),
                                  SizedBox(width: 10.w,),
                                  const Text('Name')
                                ],
                              ),
                              onTap: (){},
                            )
                          ]
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: isRefreshing ? 
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: LoadingAnimationWidget.threeArchedCircle(color: Colors.indigo, size: 20),
                      ) : 
                      IconButton(
                        onPressed: () async {
                          setState(() => isRefreshing = true);
                          await initCredential(arg);
                          setState(() => isRefreshing = false);
                        }, 
                        icon: const Icon(Icons.refresh_rounded)
                      ),
                    ),
                  ],
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: isUpdating ? 30.h : 0.0,
                  width: double.infinity,
                  child: isUpdating ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingAnimationWidget.horizontalRotatingDots(color: Colors.indigo, size: 30),
                      SizedBox(width: 10.w,),
                      Text('Updating credentials...', style: Theme.of(context).textTheme.subtitle1,)
                    ],
                  ) : null,
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
    if(state){
      return SkeletonTheme(
        themeMode: theme == 'dark' ? ThemeMode.dark : ThemeMode.light,
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
      return const CardSkeleton();
    }
  }
}