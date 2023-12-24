import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled3/medules/ShopAppsScreen/Login_Shop/shopLogIn.dart';
import 'package:untitled3/shared/network/local/cash_Helper.dart';

import '../../shared/components/componantes.dart';
import '../../shared/styles/colors.dart';

class BoardingModel{
   final String? image;
   final String? title;
   final String? body;
  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
});
}

bool? isLast=false;

class onBoardingScreen extends StatefulWidget {

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  var boardController=PageController();

List<BoardingModel>? boarding=[
  BoardingModel(
      image: 'assets/images/onBording1.jpg',
      title: 'On Board 1 Title',
      body: 'On Board 1 body'
  ),
  BoardingModel(
      image: 'assets/images/onBording2.jpg',
      title: 'On Board 2 Title',
      body: 'On Board 2 body'
  ),
  BoardingModel(
      image: 'assets/images/onBording1.jpg',
      title: 'On Board 3 Title',
      body: 'On Board 3 body'
  ),

];

void onSubmit(){
  CachHelper.saveData(key: 'onBoarding', value: true).then((value) {
   if(value==true)
     {
       navigateAndFinsh(
           context,
           shopLoginScreen()
       );
     }
  });

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
         defoultTextButton(

               onPressed: (){
                onSubmit();
               }
               , text: 'skip'
         ),
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index==boarding!.length-1){
                    setState(() {
                     print('last');
                      isLast=true;
                    });
                  }else{
                    setState(() {
                      print('not Last');
                      isLast=false;
                    });

                  }
                },
                physics: BouncingScrollPhysics(),
                controller:boardController,
                  itemBuilder:(context, index)=>buildOnBoardingItems(boarding?[index]),
                itemCount: boarding?.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5,
                    activeDotColor: defaultColor,

                  ),
                    controller: boardController,
                    count: boarding!.length),
                Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if(isLast==true){
                       onSubmit();
                      }else{
                        boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastEaseInToSlowEaseOut);
                      }

                    },
                     child:Icon(Icons.arrow_forward_ios) ,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingItems(BoardingModel? model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
          child: Image(image: AssetImage('${model?.image}'))),
      Text(
        '${model?.title}',
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(height: 20,),
      Text(
        '${model?.body}',
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(height: 20,)

    ],
  );
}


