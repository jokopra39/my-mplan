import 'package:flutter/material.dart';
import 'package:mplan/model/custom.dart';

class CamScreen extends StatefulWidget {
  @override
  ChatScreenState createState() {
    return new ChatScreenState();
  }
}

class ChatScreenState extends State<CamScreen> {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: sData.length,
      itemBuilder: (context, i) => new Column(
        children: <Widget>[
          new Divider(
            height: 10.0,
            color: Colors.grey,
            indent: 72,
            endIndent: 13,
          ),
          new ListTile(
            leading: new CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey,
              backgroundImage: new NetworkImage(sData[i].avatarUrl),
            ),
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  sData[i].name,
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
                new Text(
                  sData[i].time,
                  style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: new Text(
                sData[i].message,
                style: new TextStyle(color: Colors.grey, fontSize: 15.0),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                      text: sData[i].name, data: sData[i].avatarUrl),
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
  final text, data;
  //var cards = new List.generate(20, (i)=>new CustomCard());
  DetailScreen({this.text, this.data});

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
        appBar: AppBar(
          title: Text(text),
        ),
        // body: Padding(
        //   padding: EdgeInsets.all(16.0),
        //   child: Card(
        //     semanticContainer: true,
        //     clipBehavior: Clip.antiAliasWithSaveLayer,
        //     child: Image.network(
        //       data,
        //       fit: BoxFit.cover,
        //       height: 200.0,
        //       width: double.infinity,
        //       alignment: Alignment.center,
        //     ),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(10.0),
        //     ),
        //     elevation: 5,
        //     margin: EdgeInsets.all(0),
        //   ),
        // ),
        body: new Container(
          child: //new ListView(
              CustomCard(data),
          //)
        ));
  }
}

class CustomCard extends StatelessWidget {
  final data;
  CustomCard(this.data);
  @override
  Widget build(BuildContext context) {
    return new Container(
              child: new Column(
                children: <Widget>[
                  new Card(
                         semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: new Column(
                      children: <Widget>[
                        Image.network(
              data,
              fit: BoxFit.cover,
              height: 200.0,
              width: double.infinity,
              alignment: Alignment.center,
            ),
                        new Padding(
                          padding: new EdgeInsets.all(7.0),
                          child: new Row(
                            children: <Widget>[
                             new Padding(
                               padding: new EdgeInsets.all(7.0),
                               child: new Icon(Icons.thumb_up, size: 14.0, color: Colors.blue),
                             ),
                             new Padding(
                               padding: new EdgeInsets.all(7.0),
                               child: new Text('Like',style: new TextStyle(fontSize: 13.0),),
                             ),
                             new Padding(
                               padding: new EdgeInsets.all(7.0),
                               child: new Icon(Icons.comment, size: 14.0, color: Colors.grey),
                             ),
                             new Padding(
                               padding: new EdgeInsets.all(7.0),
                               child: new Text('Comments',style: new TextStyle(fontSize: 13.0)),
                             )

                            ],
                          )
                        )
                      ],
                    ),
                  )
                ],
              ),

           // )

        );
  }
}
