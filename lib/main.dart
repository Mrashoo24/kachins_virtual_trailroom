import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kachins/pages/home%20screen.dart';
import 'dart:convert';
// import 'package:kachins/pages/reviewscreen.dart';
import 'package:kachins/pages/splash%20screen.dart';

import 'package:page_transition/page_transition.dart';
import 'constants/constants.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
    print(cameras.length);
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
  runApp(MyApp());
}

class MyHomePage extends StatefulWidget {
  getApiData() async {
    var url = Uri.parse("https://kachins.herokuapp.com/api/process/35301/");
    http.Response response = await http.get(url);

    print(response.statusCode);
    final data = jsonDecode(response.body);
    print(data);
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  _MyHomePageState() {
    
  }
}

class _MyHomePage extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        home: AnimatedSplashScreen(
            duration: 2000,
            splash: 'assets/images/Logo.png',
            nextScreen: HomeScreen(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.rightToLeft,
            backgroundColor: Color(0xFF9E3C0E)));
    //title: 'App name',
    home:
    Builder(builder: (BuildContext context) {
      home:
      splashscreen();

      return Scaffold(
        backgroundColor: Color(0xFF9E3C0E),
        // appBar: AppBar(title: const Text('Kachins All Pages')),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Splash(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                  child: const Text(
                    'kachins',
                  ),
                ),
                //ElevatedButton(
                //onPressed: () {
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (context) => HomeScreen(),
                //));
                //},
                //child: const Text('Home Screen'),
                //),
                //ElevatedButton(
                //onPressed: () {
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (context) => HomeIntroVideoScreen(),
                //));
                //},
                //child: const Text('Home Intro Video Screen'),
                //),
                //ElevatedButton(
                //onPressed: () {
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (context) => QRScanner(),
                //));
                //},
                //child: const Text('QR Scanner'),
                //),
                //ElevatedButton(
                //onPressed: () {
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (context) => VerificationScreen(),
                //));
                //},
                //child: const Text('Verification Screen'),
                //),
                //ElevatedButton(
                //onPressed: () {
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (context) => IntroVideoScreen(),
                //));
                //},
                //child: const Text('Intro Video Screen'),
                //),
                //ElevatedButton(
                //onPressed: () {
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (context) => ProductDetail(),
                //));
                //},
                //child: const Text('Product Details'),
                //),
                //ElevatedButton(
                //onPressed: () {
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (context) => PlacementGuideVideoScreen(),
                //));
                //},
                //child: const Text('Placement Guide Video Screen'),
                //),
                //ElevatedButton(
                //onPressed: () {
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (context) => ProductInstructions(),
                //));
                //},
                //child: const Text('Product Instructions'),
                //),
                //ElevatedButton(
                //onPressed: () {
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (context) => Poses(),
                //));
                //},
                //child: const Text('Image Poses'),
                //),
                //ElevatedButton(
                //onPressed: () {
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (context) => CameraScreen(),
                //));
                //},
                //child: const Text('Custom Camera'),
                //),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //       builder: (context) => ReviewScreen(),
                //     ));
                //   },
                //   child: const Text('Pose Review Screen'),
                // ),
                //ElevatedButton(
                //onPressed: () {
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (context) => ReviewPicture(),
                //));
                //},
                //child: const Text('Final Review Picture'),
                //),
                //ElevatedButton(
                //onPressed: () {
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (context) => ThankyouScreen(),
                //));
                //},
                //child: const Text('Thank You Screen'),
                //),
                //ElevatedButton(
                //onPressed: () {
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (context) => SuccessScreen(),
                //));
                //},
                //child: const Text('Success Screen'),
                //),
                //ElevatedButton(
                //onPressed: () {
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (context) => TexttoSpeech(),
                //));
                //},
                //child: const Text('Text to Speech'),
                //),
                //ElevatedButton(
                //onPressed: () {
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (context) => VoiceNavigation(),
                //));
                //},
                //child: const Text('Speech To text'),
                //),
                //ElevatedButton(
                //onPressed: () async {
                //getRequest().getData();
                //},
                //child: const Text('GET req'),
                //),
              ],
            ),
          ),
        ),
      );
    });
  }

  splashscreen() {}
}
