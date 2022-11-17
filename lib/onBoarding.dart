import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Component.dart';
import 'package:shop_app/Login_Screem_Shop.dart';
import 'package:shop_app/local/cashHelper.dart';
import 'package:shop_app/salla/Register/registerScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class modelBoarding {
  late final String image;

  late final String title;

  late final String body;

  modelBoarding({
    required this.image,
    required this.title,
    required this.body,
  });
}

class onBoardingScreen extends StatefulWidget {
  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  var boardController = PageController();

  List<modelBoarding> boarding = [
    modelBoarding(
      image: 'assets/images/onboard_1.jpg',
      title: 'Screen Title 1',
      body: 'Screen Body 1',
    ),
    modelBoarding(
      image: 'assets/images/onboard_1.jpg',
      title: 'Screen Title 2',
      body: 'Screen Body 2',
    ),
    modelBoarding(
      image: 'assets/images/onboard_1.jpg',
      title: 'Screen Title 3',
      body: 'Screen Body 3',
    ),
  ];

  // عند الوصول لاخر board
bool isLast = false ;

void submit()
{
  CashHelper.saveData(key: 'onBoarding', value: true).then((value) {

    if(value ?? true){
      navigateTo(context,  loginScreenShop());
    }
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       actions: [
         TextButton(
             onPressed: submit ,
             child: const Text(
               'SKIP',
               style: TextStyle(
                 color: Colors.brown,
               ),
             )),
       ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                     isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildPageViewItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect:  const ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5.0,
                    activeDotColor: Colors.lightBlueAccent,
                    expansionFactor: 3,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                       submit() ;
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 650,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_rounded),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPageViewItem(modelBoarding model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(model.image))),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontFamily: 'Jannah',
              fontSize: 30.0,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontFamily: 'Jannah',
              fontSize: 20.0,
            ),
          )
        ],
      );
}
