import 'package:flutter/material.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/screens/displayNewsWeb.dart';

class DisplayNews extends StatefulWidget {

  final NewsArticle article;
  DisplayNews({required this.article});

  @override
  _DisplayNewsState createState() => _DisplayNewsState();
}

class _DisplayNewsState extends State<DisplayNews> {



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                ClipPath(
                  clipper:CurveClipper() ,
                  child: Container(
                    height: MediaQuery.of(context).size.height/2.5,
                    width:  MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(widget.article.imageUrl),fit:BoxFit.cover),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text(widget.article.title,
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      SizedBox(height: 20),
                      Text(widget.article.description,
                        style: TextStyle(
                          fontSize: 18,
                        ),),
                      SizedBox(height: 20),
                      Text(widget.article.content,
                        style: TextStyle(
                          fontSize: 18,
                        ),),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>DisplayWebView(url:widget.article.url,)));
                      }, child: Text("Read full article",style:TextStyle(color: Theme.of(context).primaryColor) ,),)
                    ],
                  ),
                ),

              ],
            ),
          ),

        )
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    // path starts with (0.0, 0.0) point (1)
    path.lineTo(0.0, size.height);
    path.quadraticBezierTo(
        size.width/2 , size.height-100, size.width, size.height);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}