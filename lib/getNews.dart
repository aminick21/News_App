import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news_app/model/news.dart';
import 'package:http/http.dart' as http;
class News{
  static const apiKey="249b0116d20241539a0a2fd0be96e2d7";
  List<NewsArticle> listOfArticle=[];
  Future getNews({ String tag='empty'}) async{
    var url;
    if(tag == 'empty'){
      url=Uri.parse("https://newsapi.org/v2/top-headlines?country=in&apiKey=$apiKey");
    }
    else
    {url=Uri.parse("https://newsapi.org/v2/top-headlines?country=in&category=$tag&apiKey=$apiKey");}
    var response= await http.get(url);
    var jsonData=jsonDecode(response.body);
    if(jsonData['status']=="ok"){
      jsonData["articles"].forEach((element){
        if(element['urlToImage']!=null&&element['description']!=null) {
          NewsArticle newsArticle = NewsArticle(
              element['title'],element['url'],element['urlToImage'],element['description'], element['content']);
          listOfArticle.add(newsArticle);
        }

      });
    }
    print(listOfArticle.length);
  }

}