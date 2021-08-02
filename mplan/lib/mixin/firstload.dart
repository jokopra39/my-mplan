import 'dart:convert';

import 'package:mplan/config/api.dart';
import 'package:mplan/model/message.dart';
import 'package:http/http.dart' as http;
import 'package:mplan/refresh/count1_bloc.dart';

import 'chat.dart';

afterload(final df) async {
  list.clear();
  final response = await http.get(BaseUrl.lihatProduk);
  if (response.contentLength == 2) {
  } else {
    final data = jsonDecode(response.body);
    data.forEach((api) {
      final ab = new ProdukModel(
        api['id'],
        api['namaProduk'],
        api['qty'],
        api['harga'],
        api['createdDate'],
        api['idUsers'],
        api['nama'],
      );
      list.add(ab);
    });
    count1Bloc.incrementCounter(df);
  }
}
