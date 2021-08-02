import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mplan/config/api.dart';
import 'package:mplan/mixin/chat.dart';
import 'package:mplan/model/chat.dart';
import 'package:mplan/refresh/chat.dart';
import 'package:mplan/refresh/count1_bloc.dart';
import 'package:mplan/refresh/count2_bloc.dart';
import 'package:mplan/refresh/main_bloc.dart';
import 'package:http/http.dart' as http;
//import 'package:mplan/refresh/count1_bloc.dart';

class ChatDetails extends StatefulWidget {
  @override
  //_ChatDetailsState createState() => _ChatDetailsState();
  _ChatDetailsState createState() {
    return new _ChatDetailsState();
  }
}

class _ChatDetailsState extends State<ChatDetails> {
  final _key = new GlobalKey<FormState>();
  List<Widget> getRandomWidgetArray() {
    List<Widget> gameCells = List<Widget>();
    gameCells.add(
      Text(
        'Today',
        style: TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
    for (var i = 0; i < listChat.length; i++) {
      gameCells.add(Bubble(
        message: listChat[i].message,
        isMe: listChat[i].idUser == GlobalVar.getIdUser ? true : false,
      ));
    }
    return gameCells;
  }

  // @override
  // void initState() {
  //   super.initState();

  //   count1Bloc = Count1Bloc();
  //   print('listchart ====> ${GlobalVar.getIdUser}');
  //   afterLoadChart(this);
  // }

  ScrollController _scrollController = ScrollController();

  void _onTap() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
    afterLoadChart(this);
    //getPref();
    var i = 0;
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // setState(() {
        //   siap = "Push Messaging token: $message";
        // });

        if (i % 2 == 0) {
          print(33);
          afterLoadChart(this);

          //testChat(dataName);
        }
        i++;
      },
      // onLaunch: (Map<String, dynamic> message) async {
      //     print(siap);
      //     //onBackgroundMessages(message);
      //   getDataFcm(message);
      // },
      // onResume: (Map<String, dynamic> message) async {
      //     print(siap);
      //   getDataFcm(message);
      // },
    );
    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(
    //         sound: true, badge: true, alert: true));

    // _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
    //   print("Settings registered: $settings");
    // });

    //mainBloc = MainBloc();
    count1Bloc = Count1Bloc();
    //mainBloc = null;
  }

  @override
  void dispose() {
    //count1Bloc = null;
    mainBloc = null;
    super.dispose();
  }

  Widget _buildStatContainer() {
    return Column(children: getRandomWidgetArray()
        // <Widget>[
        //   Text(
        //     'Today',
        //     style: TextStyle(color: Colors.grey, fontSize: 12),
        //   ),
        //   Bubble(
        //     message: 'Hi How are you ?',
        //     isMe: true,
        //   ),
        //   Bubble(
        //     message: 'have you seen ikoion kjkjfe kjfefehj ihjiefe finhiefe the docs yet?',
        //     isMe: true,
        //   ),
        //   Text(
        //     'Feb 25, 2018',
        //     style: TextStyle(color: Colors.grey, fontSize: 12),
        //   ),
        //   Bubble(
        //     message: 'i am fine !',
        //     isMe: false,
        //   ),
        //   Bubble(
        //     message: 'yes i\'ve seen the docs',
        //     isMe: false,
        //   ),
        // ],
        );
  }

  saveMessage() {
    print("pc === ${_controller.text}");
    if (_controller.text != "") {
      save();
    }
  }

  save() async {
    final response = await http.post(BaseUrl.sendChat, body: {
      "message": _controller.text,
      "idUsers": GlobalVar.getIdUser
    });
    await http.post(BaseUrl.sendFcm, body: {
      "message": _controller.text,
      "idUsers": GlobalVar.getIdUser
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      _controller.clear();
    } else {
      print(pesan);
      _controller.clear();
    }
  }

  var _controller = TextEditingController();
  String enterMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: _key,
        elevation: 0.4,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://image.freepik.com/free-photo/beautiful-beach-sea_74190-6620.jpg'),
                backgroundColor: Colors.grey[200],
                minRadius: 30,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Your Chat',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  'Online Now',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 68),
            color: Colors.white10,
            child: Column(
              children: <Widget>[
                Flexible(
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: listChat.length,
                      reverse: true,
                      shrinkWrap: true,
                      itemBuilder: (context, i) =>
                          new Column(children: <Widget>[
                            //new Text(listChat[i].message)
                            new Text(
                              '',
                              style: TextStyle(color: Colors.grey, fontSize: 3),
                            ),
                            Bubble(
                              message: '${listChat[i].message}',
                              isMe: listChat[i].idUser == GlobalVar.getIdUser
                                  ? false
                                  : true,
                              nameOfUser: '${listChat[i].nameOfUser}'    
                            ),
                          ])
                      // (BuildContext context, int index) {
                      //   return Padding(
                      //     padding: EdgeInsets.all(10),
                      //     child: _buildStatContainer(),
                      //     // Column(
                      //     //   children: <Widget>[
                      //     //     _buildStatContainer(),
                      //     //   ],
                      //     // ),
                      //   );
                      // },

                      ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(-2, 0),
                  blurRadius: 5,
                ),
              ]),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.camera,
                      color: Color(0xff3E8DF3),
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(
                  //     Icons.image,
                  //     color: Color(0xff3E8DF3),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _controller,
                      onSaved: (e) => enterMessage = e,
                      decoration: InputDecoration(
                        hintText: 'Enter Message',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _onTap();
                      saveMessage();
                    },
                    icon: Icon(
                      Icons.send,
                      color: Color(0xff3E8DF3),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Bubble extends StatelessWidget {
  final bool isMe;
  final String message;
  final String nameOfUser;

  Bubble({this.message, this.isMe, this.nameOfUser});

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: isMe ? EdgeInsets.only(left: 40) : EdgeInsets.only(right: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  gradient: isMe
                      ? LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [
                              0.1,
                              1
                            ],
                          colors: [
                              Color(0xFFF6D365),
                              Color(0xFFFDA085),
                            ])
                      : LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [
                              0.1,
                              1
                            ],
                          colors: [
                              Color(0xFFEBF5FC),
                              Color(0xFFEBF5FC),
                            ]),
                  borderRadius: isMe
                      ? BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(0),
                          bottomLeft: Radius.circular(15),
                        )
                      : BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(0),
                        ),
                ),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: <Widget>[
                    isMe ? Text(nameOfUser,
                     style: TextStyle(
                        color: isMe ? Colors.black26: Colors.grey,
                        fontSize: 10
                      ),
                    ) : Text('', style: TextStyle(
                        color: isMe ? Colors.white : Colors.grey,
                        fontSize: 1
                      ),),
                    Text(
                      message,
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
