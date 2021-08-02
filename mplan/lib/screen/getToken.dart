import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mplan/config/api.dart';
import 'package:mplan/mixin/chat.dart';
import 'package:mplan/mixin/firstload.dart';
//import 'package:mplan/mixin/firstload.dart';
import 'package:mplan/mixin/global_var.dart';
import 'package:mplan/refresh/main_bloc.dart';
//import 'package:mplan/mixin/global_var.dart';
// import 'package:mplan/mixin/test.dart';
import 'package:mplan/screen/register.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'mainMenu.dart';

//import 'newscreen.dart';
class PushMessagingExample extends StatefulWidget {
  @override
  _PushMessagingExampleState createState() => _PushMessagingExampleState();
}

enum LoginStatus { notSignIn, signIn }
String _homeScreenText = "Waiting for token...";
String siap = "siap...";

class _PushMessagingExampleState extends State<PushMessagingExample> with Coba{ 
   final scaffoldState = GlobalKey<ScaffoldState>();
   LoginStatus _loginStatus = LoginStatus.notSignIn;
  String username, password;
  static int i = 0;
  final _key = new GlobalKey<FormState>();

  bool _secureText = true;
  
  //final List<Message> messages = [];

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

 static String dataName = '';
  static String dataAge = '';

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  login() async {
    final response = await http.post(BaseUrl.login,
        body: {"username": username, "password": password});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    String usernameAPI = data['username'];
    String namaAPI = data['nama'];
    String id = data['id'];
    String idOffice = data['id_office'];
    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, usernameAPI, namaAPI, id, idOffice);
      });
      print(pesan);
    } else {
      print(pesan);
    }
  }


  savePref(int value, String username, String nama, String id, String idOffice) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("nama", nama);
      preferences.setString("username", username);
      preferences.setString("id", id);
      preferences.setString("idoffice", idOffice);
      //preferences.commit();
    });
  }

  var value;
  var getuser;
  var idoffice;
  var getId;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      getuser =  preferences.getString("username");
      idoffice = preferences.getString("idoffice");
      getId = preferences.getString("id");
      GlobalVar.getIdUser = getId;
      print("val getuser =====> $getId");
      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      //preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
      preferences.setInt("value", 2);
    });
  }

  @override
  void initState() { 
    super.initState();
    getPref();
    _firebaseMessaging.configure(
      // onMessage: (Map<String, dynamic> message) async {
      //   print("onMessage: $message");
      //   setState(() {
      //     siap = "Push Messaging token: $message";
      //   });
        
      //    if(i%2==0) {
      //       afterload(this);
      //      //test(dataName);
      //      //afterLoadChart(this);
      //      //testChat(dataName);
      //   }
      //   i++;
      // },
      onLaunch: (Map<String, dynamic> message) async {
          print(siap);
          //onBackgroundMessages(message);
        getDataFcm(message);
      },
      onResume: (Map<String, dynamic> message) async {
          print(siap);
        getDataFcm(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true));

    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = token;
        GlobalVar.homeScreenText = token;
      });
      print(_homeScreenText);
    });
     mainBloc = MainBloc();
     
  }

  @override
  void dispose() {
    mainBloc = null;
   // mainBlocChart = null; // destroying the mainBloc object to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     switch (_loginStatus) {
      case LoginStatus.notSignIn: 
      print("staus login $_loginStatus");
      return Scaffold(
       key: scaffoldState,
      appBar: AppBar(
        title: const Text('Push Messaging Demo'),
      ),
      // For testing -- simulate a message being received
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     //Navigator.pop(context);
      //         Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => HomePage()),
      //       );
      //   },
      //   tooltip: 'Simulate Message',
      //   child: const Icon(Icons.message),
      // ),
      body: Material(
        child: Form(
            key: _key,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Please insert username";
                    }
                  },
                  onSaved: (e) => username = e,
                  decoration: InputDecoration(
                    labelText: "Username",
                  ),
                ),
                TextFormField(
                  obscureText: _secureText,
                  onSaved: (e) => password = e,
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                      onPressed: showHide,
                      icon: Icon(_secureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    check();
                  },
                  child: Text("Login"),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: Text(
                    "Create a new account, in here",
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        // Column(
        //   children: <Widget>[
        //     Center(
        //       child: Text(_homeScreenText),
        //     ),
        //     Center(
        //       child: Text(siap),
        //     ),
        //     Divider(thickness: 1),
        //     Text(
        //       'DATA',
        //       style: TextStyle(fontWeight: FontWeight.bold),
        //     ),
        //     _buildWidgetTextDataFcm(),
        //   ],
        // ),
      ),
    );
    break;
      case LoginStatus.signIn:
        return MainMenu(signOut);
        break;
     }
  }

  // Widget _buildWidgetTextDataFcm() {
  //   if (dataName == null || dataName.isEmpty || dataAge == null || dataAge.isEmpty) {
  //     return Text('Your data FCM is here');
  //   } else {
  //     return Text('Name: $dataName & Age: $dataAge');
  //   }
  // }

void getDataFcm(Map<String, dynamic> message) {
    String name = '';
    String age = '';
    if (Platform.isIOS) {
      name = message['name'];
      age = message['age'];
    } else if (Platform.isAndroid) {
      var data = message['data'];
      name = data['name'];
      age = data['age'];
    }
    if (name.isNotEmpty && age.isNotEmpty) {
      setState(() {
        dataName = name;
        dataAge = age;
      });
    }
    debugPrint('getDataFcm: name: $name & age: $age');
  }

}
