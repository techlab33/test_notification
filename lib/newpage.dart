import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<dynamic> posts = [];
  int currentIndex = 0;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    initNotifications();
    downloadJson();
  }

  void initNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');

    final initializationSettings = InitializationSettings(android: android);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> downloadJson() async {
    final response = await http.get(Uri.parse("https://raw.githubusercontent.com/techlab33/nubtk/main/new.json"));
    if (response.statusCode == 200) {
      setState(() {
        posts = json.decode(response.body);
        startNotificationTimer();
      });
    } else {
      throw Exception("Something went wrong while fetching data.");
    }
  }

  void startNotificationTimer() {
    Timer.periodic(Duration(seconds: 10), (timer) {
      if (posts.isNotEmpty) {
        showNotification();
        setState(() {
          currentIndex = (currentIndex + 1) % posts.length;
        });
      }
    });
  }

  Future<void> showNotification() async {
    if (posts.isNotEmpty) {
      final notificationBody = posts[currentIndex]['name'] as String;
      final android = AndroidNotificationDetails(
        'scheduled_notification',
        'Scheduled Notifications',
        importance: Importance.high,
      );
      // final iOS = IOSNotificationDetails();
      final platform = NotificationDetails(android: android);

      await flutterLocalNotificationsPlugin.show(
        Random().nextInt(100),
        'ASSALAM',
        notificationBody,
        platform,
        payload: 'New Notification',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
        ),
      ),
    );
  }
}
