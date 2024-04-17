import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task1/controller/firebase_controller.dart';

class MainController extends   GetxController  with WidgetsBindingObserver{

FirebaseController firebaseController;
MainController({required this.firebaseController});
  bool _isTimeStarted = false;
  int _selectedGifNumber = 0;
  bool _isFirstRow = true;
bool _isFinalPage = true;




  bool get isClicked => _isTimeStarted;
  int get selectedGifNumber => _selectedGifNumber;
  bool get isFirstRow => _isFirstRow;
  bool get isFinalPage => _isFinalPage;



  onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    
  }

  onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.detached){

     await Future.delayed(Duration(seconds: 3));
   await firebaseController.liveUserUpdater(false);

    }


  }

  gifSelector(int gifNumber) async {
    if(selectedGifNumber==0){
      _selectedGifNumber = gifNumber;


    await  firebaseController.voteUpdater(true, gifNumber);

    }
    else if(selectedGifNumber == gifNumber){
      _selectedGifNumber = 0;
     await firebaseController.voteUpdater(false, gifNumber);

    }

    else{
      Get.snackbar("Restriction", 'Please first uncheck', backgroundColor: Colors.red, colorText: Colors.white ) ;
    }
    update();
  }


   checkTimeStartedValue() async{}

  rowUpdater(){
    _isFirstRow = ! _isFirstRow;
    update();
  }

  initiateTime(){
    firebaseController.initiateTime();
  }

  finalPageSetter(val){
    _isFinalPage = val;
    update();
  }

 set setGifNumber(int index){
    _selectedGifNumber = index;
    update();

  }



}