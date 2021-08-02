import 'package:flutter/material.dart';
import 'package:mplan/mixin/chat.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:mplan/mixin/chat.dart';
import 'package:mplan/mixin/firstload.dart';
import 'package:mplan/refresh/count1_bloc.dart';
//import 'package:mplan/refresh/main_bloc.dart';
import 'package:mplan/tab/call_screen.dart';
import 'package:mplan/tab/camera_screen.dart';
import 'package:mplan/tab/chat_screen.dart';
import 'package:mplan/tab/detail.dart';
import 'package:mplan/tab/status_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user.dart';

class MainMenu extends StatefulWidget {
  final VoidCallback signOut;
  MainMenu(this.signOut);
  @override
  _MainMenuState createState() => _MainMenuState();
}

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class _MainMenuState extends State<MainMenu>
    with SingleTickerProviderStateMixin {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  String username = "", nama = "";
  TabController tabController;
  TabController _tabController;
  bool showFab = true;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("username");
      nama = preferences.getString("nama");
    });
  }

  selectPopBtn(result) {
    setState(() {
      if (result == WhyFarther.smarter) {
        signOut();
        print("okey $result");
      } else if (result == WhyFarther.harder) {
        // Fluttertoast.showToast(
        //     msg: "Halo gaess",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.grey,
        //     textColor: Colors.white,
        //     fontSize: 13.0);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ForUser()));
      } else if (result == WhyFarther.selfStarter) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ChatDetails()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count1Bloc = Count1Bloc();

    getPref();
    _tabController = TabController(initialIndex: 1, length: 4, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        showFab = true;
      } else {
        showFab = false;
      }
      setState(() {});
    });
    afterload(this);
    //afterLoadChart(this);
  }

  @override
  void dispose() {
    count1Bloc = null;
    super.dispose();
  }

  int counter = 7;

  // setState(() {
  //         counter++;
  //       });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mplan'),
        elevation: 0.7,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.camera_alt)),
            Tab(text: "CHATS"),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "CALLS",
            ),
          ],
        ),
        actions: <Widget>[
          Icon(Icons.search),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
          new Stack(
            children: <Widget>[
              PopupMenuButton<WhyFarther>(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 16.8),
                onSelected: (WhyFarther result) {
                  selectPopBtn(result);
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<WhyFarther>>[
                  const PopupMenuItem<WhyFarther>(
                    value: WhyFarther.harder,
                    child: Text('User'),
                  ),
                  const PopupMenuItem<WhyFarther>(
                    value: WhyFarther.selfStarter,
                    child: Text('Chat'),
                  ),
                  const PopupMenuItem<WhyFarther>(
                    value: WhyFarther.smarter,
                    child: Text('LogOut'),
                  ),
                ],
              ),
              counter != 0
                  ? new Positioned(
                      right: 6,
                      top: 9,
                      child: new Container(
                        padding: EdgeInsets.only(left:3, right: 3, top: 3, bottom: 3),
                        decoration: new BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: Text(
                          '$counter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : new Container()
            ],
          ),

          // Icon(Icons.search),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 5.0),
          // ),
          // PopupMenuButton<WhyFarther>(
          //   onSelected: (WhyFarther result) {
          //      selectPopBtn(result);
          //   },
          //   itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
          //     const PopupMenuItem<WhyFarther>(
          //       value: WhyFarther.harder,
          //       child: Text('User'),
          //     ),
          //     const PopupMenuItem<WhyFarther>(
          //       value: WhyFarther.selfStarter,
          //       child: Text('Chat'),
          //     ),
          //     const PopupMenuItem<WhyFarther>(
          //       value: WhyFarther.smarter,
          //       child: Text('LogOut'),
          //     ),
          //   ],
          // ),
        ],
      ),
      body: new Container(
          margin: new EdgeInsets.only(top: 2),
          transform: Matrix4.translationValues(0.0, -7.0, 0.0),
          //padding: new EdgeInsets.only(top: ),
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              //CameraScreen(widget.cameras),
              CamScreen(),
              ChatScreen(),
              StatusScreen(),
              CallsScreen(),
            ],
          )),
      floatingActionButton: showFab
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(
                Icons.message,
                color: Colors.white,
              ),
              onPressed: () => afterload(this),
            )
          : null,
    );
  }
}
