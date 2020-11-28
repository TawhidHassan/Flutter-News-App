import 'dart:convert';

import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;

Future<List> rssToJson(String category,{String baseUrl='https://www.hindustantimes.com/rss/'})async{

  var client=http.Client();
  final myTranformar=Xml2Json();
 return await client.get(baseUrl + category + '/rssfeed.xml').then((response){
    return response.body;
  }).then((bodyString) {
    myTranformar.parse(bodyString);
    var json=myTranformar.toGData();
    return jsonDecode(json)['rss']['channel']['item'];

  });
}