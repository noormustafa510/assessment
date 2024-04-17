import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task1/controller/main_controller.dart';

import '../utils/dimensions.dart';

class GifGenerator extends StatelessWidget {
  int number;

   GifGenerator({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (mainController){
      return Expanded(
        child: GestureDetector(
          onTap: (){
            mainController.gifSelector(number);
          },
          child: Stack(
            children: [

              Image.asset('assets/gifs/${number}.gif'),

              if(mainController.selectedGifNumber == number)    Center(child: Icon(Icons.check_circle, color: Colors.green, size: Dimensions.height45*2,)),
            ],
          ),
        ),
      );
    });
  }
}
