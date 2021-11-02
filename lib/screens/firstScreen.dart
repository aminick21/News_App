import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/screens/homeScreen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage("assets/3953918.jpg"),),
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Why Read Newspaper \n when you have NewsApp",
              textAlign: TextAlign.center,
              style: TextStyle(
                letterSpacing: 1,wordSpacing: 1,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),),
          ),
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext build)=>HomeScreen()));
            },
              child: Text("Next",style: TextStyle(
                  fontSize: 30,color:Theme.of(context).scaffoldBackgroundColor ),),
               style: ButtonStyle(
                 backgroundColor:MaterialStateProperty.all<Color>(Theme.of(context).primaryColor) ,
                 fixedSize:MaterialStateProperty.all<Size>(Size(200, 50)),
                 shape: MaterialStateProperty.all<OutlinedBorder>(
                     RoundedRectangleBorder(
                       borderRadius:BorderRadius.circular(20),

                     )),
                 elevation: MaterialStateProperty.all<double>(0),
               ),
            ),
          ),
        ],
      ),
    ));
  }
}
