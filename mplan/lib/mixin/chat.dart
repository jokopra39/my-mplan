import 'dart:convert';

import 'package:mplan/config/api.dart';
//import 'package:mplan/model/message.dart';
import 'package:http/http.dart' as http;
import 'package:mplan/model/chat.dart';
import 'package:mplan/refresh/chat.dart';
import 'package:mplan/refresh/count1_bloc.dart';
//import 'package:mplan/refresh/count1_bloc.dart';

afterLoadChart(final df) async {
  listChat.clear();
  final response = await http.get(BaseUrl.getChat);
  if (response.contentLength == 2) {
  } else {
    final data = jsonDecode(response.body);
    data.forEach((api) {
      final ab = new ChatModel(
        api['id'],
        api['from'],
        api['to'],
        api['message'],
        api['isread'],
        api['isdelete'],
        api['idUser'],
        api['time'],
        api['idOffice'],
        api['nameOfUser'],
      );
      listChat.add(ab);
    });
    count1Bloc.incrementCounter(df);
    //countChart.incrementCounterChart(df);
    // countChart.incrementCounterChart(df);
  }
}
