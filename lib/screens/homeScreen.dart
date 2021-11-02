import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/screens/categoryNews.dart';
import 'package:news_app/screens/displayNews.dart';

import '../getNews.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool indicate = true;
  List<NewsArticle> articles = [];
  _getNews() async {
    News news = News();
    await news.getNews();
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

  List<String> category = [
    "Sports",
    "Business",
    "Technology",
    "Entertainment",
    "Health",
    "Science",
  ];

  List<AssetImage> icons = [
    AssetImage("assets/icons/sports.png"),
    AssetImage("assets/icons/business.png"),
    AssetImage("assets/icons/tech.png"),
    AssetImage("assets/icons/enternainment.png"),
    AssetImage("assets/icons/health.png"),
    AssetImage("assets/icons/science.png"),
  ];


  _categoryTile(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    CategoryNews(category: category[index])));
      },
      child: Container(
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  child: Image(image: icons[index],height: 45,width: 45,),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                     // color: Colors.pink,
                  ),
                )),
            Expanded(
                child: Text(
              category[index],
              style: TextStyle(fontSize: 16),
            )),
          ],
        ),
        decoration: BoxDecoration(
          border:Border.all(color:Theme.of(context).primaryColor, ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Color(0xffef7851),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        elevation: 0,
        centerTitle: true,
        title: Text(
          "NewsApp",
          style: TextStyle(),
        ),
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
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Latest News",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: CarouselSlider.builder(
                      itemCount: articles.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext build) =>
                                        DisplayNews(
                                            article: articles[itemIndex])));
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          articles[itemIndex].imageUrl),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.black.withOpacity(.3),
                                        Colors.black87.withOpacity(.3),
                                        Colors.black54.withOpacity(.3),
                                        Colors.black38.withOpacity(.3),
                                      ]),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 5,
                                right: 5,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      articles[itemIndex].title,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        autoPlay: true,
                      ),
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Divider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.fromLTRB(20, 10, 20, 30),
                  child: Text(
                    "Category",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: List.generate(
                        category.length, (index) => _categoryTile(index)),
                  ),
                ),
              ],
            ),
    ));
  }
}
