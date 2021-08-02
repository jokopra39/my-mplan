import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        controller: controller,
        children: List.generate(100, (int i) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/profile.jpg"),
            ),
            title: Text("List Index is $i"),
          );
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(onTap: _onTap, items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), title: Text("My Page")),
      ]),
    );
  }

  void _onTap(int i) {
    controller.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}