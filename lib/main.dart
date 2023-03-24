import 'dart:js';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volaabdoshalaby/cubit/charachter_cubit.dart';
import 'package:volaabdoshalaby/view/screens/home.dart';
import 'package:volaabdoshalaby/view/screens/onBoarding.dart';

import 'constant/constant.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefInst =await SharedPreferences.getInstance();
  prefInst.get("isIntroRead")?? prefInst.setBool("isIntroRead",false);


  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider<CharachterCubit>(
                create: (context)=> CharachterCubit(charactersRepository),
            ),
          ],
          child:  MaterialApp(
            debugShowCheckedModeBanner: false,

            initialRoute: '/',
            routes: {
              '/': (context) => AnimatedSplashScreen(
                  splashIconSize: 251,
                  splash: 'assets/images/splash.png',
                  nextScreen: prefInst.getBool('isIntroRead') == true
                      ?   const MyApp()
                      :   Onbording(),
                  splashTransition: SplashTransition.fadeTransition,

                  backgroundColor:   Colors.white
              ),

            },
          ))



  );
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _AppState();
}

class _AppState extends State<MyApp> {
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color.fromARGB(255, 27, 32, 35),
        body:const Home()
    );
  }
}


