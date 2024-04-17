import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task1/controller/firebase_controller.dart';

import '../utils/dimensions.dart';
import 'my_normal_text.dart';

class FinalGifWidget extends StatelessWidget {
  int score;
  int index;
   FinalGifWidget({super.key, required this.score, required this.index});

  @override
  Widget build(BuildContext context) {
    double percentage = 100/Get.find<FirebaseController>().totalVotes*score;
    return Expanded(
      child: Column(
        children: [
          Row(children: [
            Expanded(child: Image.asset('assets/gifs/${index}.gif'))
          ],),
          Center(child: MyNormalText(text: percentage.round().toString(),size: Dimensions.font26*1.5,),)
        ],
      ),
    );
  }
}
