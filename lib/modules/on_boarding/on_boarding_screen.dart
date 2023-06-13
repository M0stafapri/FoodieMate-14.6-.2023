import 'package:flutter/material.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';


class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({

   required this.image,
   required this.title,
   required this.body
  }
  );

}


class OnBoardingScreen extends StatelessWidget {

  List<BoardingModel> boarding=[
    BoardingModel(
        image:'assets/images/blood-donation-symbol.jpg' ,
        title: 'Food Detection',
        body: 'Detects whether food is fresh or rotten'
    ),
    BoardingModel(
        image:'assets/images/burns.jpg' ,
        title: 'Food Recipes and Excerise Plans',
        body: 'Displays a food recipe page including its ingredients and calories, also shows a step by step how to deploy an Excerise on its proper way'
    ),
    BoardingModel(
        image:'assets/images/firstAid.jpg',
        title: 'Get in touch with your Personal Trainer',
        body: 'Choosing a program to follow and requesting it from one of many Trainers we are providing'
    ),
  ];

  var boardController= PageController();

  bool isLast = false;

  void submit (context) {
    CacheHelper.saveData(key: 'onBoarding', value:true).then((value){
      if(value)
        {
         navigatAndFinish(context, LoginScreen());
        }
    });

  }

  @override
  Widget build(BuildContext context) {

    Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          '${model.body}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),

      ],
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 10.0),
            child: TextButton(
                onPressed: () {
                  submit(context);
                },
                child: Text(
                  'SKIP',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: defaultColor,
                  ),
                ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  controller: boardController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder:(context, index) => buildBoardingItem(boarding[index]),
                  onPageChanged: (index) {
                    if(index==boarding.length-1)
                      {
                        isLast=true;
                      }
                    else
                      {
                        isLast=false;
                      }
                  },
                  itemCount:boarding.length,
                  ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect:ExpandingDotsEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      activeDotColor:defaultColor??Color.fromARGB(255,157, 7, 89),
                      dotColor: Colors.grey,
                      spacing: 5.0,
                      expansionFactor: 4,
                    ) ,
                ),
                Spacer(),
                FloatingActionButton(
                    onPressed:() {
                      if(isLast)
                        {
                          submit(context);
                        }
                      else
                        {
                          boardController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );

                        }
                    },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
