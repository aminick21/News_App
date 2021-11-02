import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:news_app/getNews.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/screens/displayNews.dart';
class CategoryNews extends StatefulWidget {
final String category;
CategoryNews({required this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  bool indicate = true;
  List<NewsArticle> articles = [];
  _getNews() async {
    News news = News();
    await news.getNews(tag: widget.category);
    setState(() {
      articles = news.listOfArticle;
      indicate = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNews();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.category),
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
        ),
        body: indicate
            ? Center(
          child: Container(
            height: 100,
            width: 200,
            child: LoadingIndicator(
              indicatorType: Indicator.ballPulse,
              colors: [
                Theme.of(context).primaryColor,
                Colors.grey,
              ],
            ),
          ),
        )
            :ListView.separated(
            itemBuilder: (BuildContext context,int index){
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>DisplayNews(article: articles[index])));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                       boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0, // soften the shadow
                          spreadRadius: 2.0, //extend the shadow
                          offset: Offset(
                            2.0, // Move to right 10  horizontally
                            2.0, // Move to bottom 10 Vertically
                          ),
                        )
                        ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Expanded(flex: 3,
                          child: Container(
                            width:double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(image: NetworkImage(articles[index].imageUrl),fit: BoxFit.cover,
                            ),),
                          ),
                        ),
                        Expanded(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${articles[index].title}+hfuojbsaouabfjakjshfuojbsaouabfjakjshfuojbsaouabfjakjsd",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis ,
                          maxLines: 2,),
                        )),
                      ],
                    ) ,
                  ),
                ),
              ) ;
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 1,
                color: Colors.grey,
              );
              },
            itemCount: articles.length),


      ),
    );
  }
}

