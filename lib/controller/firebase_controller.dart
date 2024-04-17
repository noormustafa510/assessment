import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:task1/controller/main_controller.dart';

class FirebaseController extends GetxController {
  int activeUsers = 0;
  late FirebaseFirestore db;
  late var liveUserRef;
  late var votesRef;
  late var timeRef;
  int timerS = 0;
  Map<String, int> scoreMap = {};
  int totalVotes = 0;

  dbInitialization() async {
    db = FirebaseFirestore.instance;
    liveUserRef = db.collection("live").doc("users");
    votesRef = db.collection("votes").doc("vid");
    timeRef = db.collection("votes").doc("timer");

    await liveUserUpdater(true);

    await getDateTime();

    liveUserRef.snapshots().listen(
      (event) {
        if (event.data != null) {
          activeUsers = event.data()['live-users'] ?? 0;
          update();
        }
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }

  liveUserUpdater(bool increment) {
    if (increment) {
      liveUserRef.update(
        {"live-users": FieldValue.increment(1)},
      );
    } else {
      liveUserRef.update(
        {"live-users": FieldValue.increment(-1)},
      );
    }
  }

  voteUpdater(bool increment, int id) {
    if (increment) {
      votesRef.update(
        {"v${id}": FieldValue.increment(1)},
      );
    } else {
      votesRef.update(
        {"v${id}": FieldValue.increment(-1)},
      );
    }
  }

  getDateTime() {
    timeRef.snapshots().listen(
      (event) {
        if (event.data != null) {
          String rData = event.data()['val'] ?? DateTime.now();
          DateTime dateTime = DateTime.parse(rData);

          timerS = dateTime.difference(DateTime.now()).inSeconds + 10;
          Get.find<MainController>().setGifNumber = 0;
          startTimer();

          update();
        }
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }

  initiateTime() async {
    DateTime currentTime = DateTime.now();
    currentTime.add(Duration(seconds: 10));
    timeRef.set({'val': currentTime.toString()});

    await votesRef.set({
      'v1': 0,
      'v2': 0,
      'v3': 0,
      'v4': 0,
    });
  }

  Future<void> startTimer() async {
    if (timerS < 0) {
      timerS = 0;
    }
    if (timerS > 0) {
      Get.find<MainController>().finalPageSetter(false);
    }

    Timer(Duration(seconds: timerS), () async {
      await getResults();
    });
  }

  getResults() {
    totalVotes = 0;
    votesRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        data.forEach((key, value) {
          scoreMap[key] = value as int;
        });
        scoreMap.forEach((key, value) {
          totalVotes += value;
        });

        Get.find<MainController>().finalPageSetter(true);
        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }
}
