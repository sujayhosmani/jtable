import 'package:flutter/material.dart';
import 'package:jtable/Helpers/signalR_services.dart';
import 'package:jtable/Models/Users.dart';
import 'package:jtable/Screens/NavScreen/persistance_screen.dart';
import 'package:jtable/Screens/Providers/global_provider.dart';
import 'package:jtable/Screens/Providers/network_provider.dart';
import 'package:jtable/Screens/StudentScreen/Components/student_screen.dart';
import 'package:jtable/Screens/TableScreens/Components/main_table_screen.dart';
import 'package:jtable/Screens/shared/loading_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../Helpers/Utils.dart';
import '../NavScreen/nav_screen.dart';
import '../shared/input.dart';

class MainLogin extends StatelessWidget {

  TextEditingController mUserName = TextEditingController();
  TextEditingController mResUniq = TextEditingController();
  TextEditingController mPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Presidency"),
      // ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
              child:  Container(
                width: double.infinity,
                // decoration: BoxDecoration(
                //     color: Colors.white,
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey,
                //         blurRadius: 25.0, // soften the shadow
                //         spreadRadius: 5.0, //extend the shadow
                //         offset: Offset(10,5),
                //       )
                //     ],
                //     borderRadius: BorderRadius.circular(10)
                // ),
                margin: EdgeInsets.only(top: 80),
                child: Consumer<NetworkProvider>(builder: (context, network, child){
                  mResUniq.text = network.resUniqLogin ?? "";
                  mUserName.text = network.userIdLogin ?? "";
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Image.asset("assets/images/ottomanlogo2.png", fit: BoxFit.cover, height: 100,),
                      SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("OttoMan", style: TextStyle(fontSize: 18, ),)),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                        child: Align(alignment: Alignment.topLeft, child: Text("Login", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
                      ),
                      SizedBox(height: 6,),
                      InputText(isPassword: false,title: "Restaurent Id",icon: Icons.rectangle_sharp, mCtrl: mResUniq),
                      SizedBox(height: 6,),
                      InputText(isPassword: false,title: "Username",icon: Icons.person, mCtrl: mUserName),
                      SizedBox(height: 6,),
                      InputText(isPassword: true,title: "Password",icon: Icons.lock, mCtrl: mPassword),
                      SizedBox(height: 15,),

                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: Utils.btnGradient
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60)
                              )
                          ),

                          child: new Text('Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          onPressed: () { onLoginClicked(context); },
                        ),
                      ),

                      SizedBox(height: 60,),
                    ],
                  );
                })
              )
          ),
          Consumer<GlobalProvider>(builder: (context, global, child){
            print(global.error);
            return LoadingScreen(isBusy: global.isBusy,error: global?.error ?? "", onPressed: (){},);
          })
        ],
      )
    );
  }

  void onLoginClicked(BuildContext context) async{
    Users? res = await Provider.of<NetworkProvider>(context, listen: false).UserLogin(context, mUserName.text, mPassword.text, mResUniq.text);
    //context != null ? Provider.of<GlobalProvider>(context, listen: false).setIsBusy(false, null): print("c null");
    if(res != null){
      await Future.delayed(const Duration(seconds: 0));
      if (context.mounted) {
        print("in side navigation");
        Provider.of<SignalRService>(context, listen: false).initializeConnection(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
          return MainTableScreen(isFromLogin: true);
        }));
        // PersistentNavBarNavigator.pushNewScreen(
        //     context,
        //     screen: PersistStyleNavBar(menuScreenContext: context,));
      }
    }

  }
}
