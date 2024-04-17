import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task1/controller/firebase_controller.dart';
import 'package:task1/controller/main_controller.dart';
import 'package:task1/utils/dimensions.dart';
import 'package:task1/widgets/final_gif_widget.dart';
import 'package:task1/widgets/gif_generator.dart';
import 'package:task1/widgets/my_normal_text.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        child: GetBuilder<MainController>(builder: (mainController){
          return  mainController.isFinalPage? Column(
            children: [
              SizedBox(height: Dimensions.height45,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Dimensions.width30*2, vertical: Dimensions.height10),
                child: ElevatedButton(onPressed: (){
                  mainController.initiateTime();
                }, child: Center(child: MyNormalText(text: 'Start Time' , size: Dimensions.font26,))),
              ),
              
             if(Get.find<FirebaseController>().totalVotes>0)
               GetBuilder<FirebaseController>(builder: (fireController){return Column(
                children: [
                 Row(
                   children: [
                     FinalGifWidget(score: fireController.scoreMap['v1']??0, index: 1,),
                     FinalGifWidget(score: fireController.scoreMap['v2']??0, index: 2,)
                   ],
                 ),
                 Row(
                   children: [
                     FinalGifWidget(score: fireController.scoreMap['v3']??0, index: 3,),
                     FinalGifWidget(score: fireController.scoreMap['v4']??0, index: 4,)
                   ],
                 ),
                ],
              ) ;})
              
            ],
          ):Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyNormalText(text: "Live User:  ", size: Dimensions.font26, color: Colors.green,),
                 GetBuilder<FirebaseController>(builder: (fireController){
                   return  MyNormalText(text: fireController.activeUsers.toString(), size: Dimensions.font26,);
                 })
                ],
              ),




           mainController.isFirstRow?
           Center(
                child: Row(
                    children: [
                  GifGenerator(number: 1),
                  GifGenerator(number: 2),

                    ]

                ),

              ):
           Center(
                child: Row(
                    children: [
                  GifGenerator(number: 3),
                  GifGenerator(number: 4),

                    ]

                ),

              ),
              IconButton(onPressed: (){
                mainController.rowUpdater();
              }, icon: mainController.isFirstRow?Icon(Icons.arrow_forward ,size: Dimensions.height45*2, ):Icon(Icons.arrow_back ,size: Dimensions.height45*2, )

              ),


            ],
          );
        }),
      ),
    );
  }
}
