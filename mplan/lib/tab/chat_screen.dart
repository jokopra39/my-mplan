//import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:mplan/mixin/firstload.dart';
//import 'package:mplan/config/api.dart';
import 'package:mplan/model/custom.dart';
import 'package:mplan/model/message.dart';
//import 'package:mplan/model/message.dart';
//import 'package:http/http.dart' as http;
import 'package:mplan/refresh/count1_bloc.dart';
import 'package:mplan/refresh/main_bloc.dart';

import 'detail.dart';

class ChatScreen extends StatefulWidget {
  @override
  ChatScreenState createState() {
    return new ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
     count1Bloc = Count1Bloc();
    //  if(mainBloc.counter1 > 2){
    //    print("lihat data == 3");
    //  }
  }

 @override
  void dispose() {
    count1Bloc = null;
    super.dispose();
  }

var loading = false;
  // final list = new List<ProdukModel>();
  // //final GlobalKey<RefreshIndicatorState> _refresh = GlobalKey<RefreshIndicatorState>();
  // Future<void> _lihatData() async {
  //   list.clear();
  //   setState(() {
  //     loading = true;
  //   });
  //   final response = await http.get(BaseUrl.lihatProduk);
  //   if (response.contentLength == 2) {
  //   } else {
  //     final data = jsonDecode(response.body);
  //     data.forEach((api) {
  //       final ab = new ProdukModel(
  //         api['id'],
  //         api['namaProduk'],
  //         api['qty'],
  //         api['harga'],
  //         api['createdDate'],
  //         api['idUsers'],
  //         api['nama'],
  //       );
  //       list.add(ab);
  //     });
  //     setState(() {
  //       loading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: list.length,
      itemBuilder: (context, i) => new Column(
        children: <Widget>[
          new Divider(
            thickness: 0.15,
            height: 10.0,
            color: Colors.black87,
            indent: 72,
            endIndent: 13,
          ),
          new ListTile(
            leading: new CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey,
              backgroundImage: new NetworkImage(dummyData[i].avatarUrl),
            ),
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  list[i].namaProduk,
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
                new Text(
                  list[i].id,
                  style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: new Text(
                list[i].namaProduk,
                style: new TextStyle(color: Colors.grey, fontSize: 15.0),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => 
                  //ChatDetails()
                  DetailScreen(text: list[i].id, data: list[i].namaProduk),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo.
  //final Todo todo;

  // In the constructor, require a Todo.
  //DetailScreen({Key key, @required this.todo}) : super(key: key);
  // var details = new Map();
  final text, data;

  DetailScreen({this.text, this.data});

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text('$data'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Message : $data'),
      ),
    );
  }
}
