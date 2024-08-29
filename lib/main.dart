import 'package:flutter/material.dart';
import 'package:phantomscanbliss/screens/splash_screen.dart';
import 'package:phantomscanbliss/shared_prefs/shared_prefs.dart';
import 'package:phantomscanbliss/urils/colors.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SpUtil.getInstance();
  // await SpUtil.clear();
  runApp(DevicePreview(builder: (context) => const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void getCollectionData() async {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("urls");

    collectionReference.snapshots().listen((querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        var baseUrl = data["baseurl"];

        debugPrint("***====== baseUrl ======*** $baseUrl\n");

        SpUtil.putString(SpConstUtil.baseurl, baseUrl);
        SpUtil.getString(SpConstUtil.baseurl);
      }
    });
  }

  void getCollectionData2() async {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("keys");

    collectionReference.snapshots().listen((querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        var consumerKey = data["consumer_key"];
        var consumerSecret = data["consumer_secret"];

        debugPrint("***====== consumerKey ======*** $consumerKey\n");
        debugPrint("***====== consumerSecret ======*** $consumerSecret\n");

        SpUtil.putString(SpConstUtil.consumerKey, consumerKey);
        SpUtil.putString(SpConstUtil.consumerSecret, consumerSecret);
      }
    });
  }

  @override
  void initState() {
    getCollectionData();
    getCollectionData2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: colors.browncolor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
