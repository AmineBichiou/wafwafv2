import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startpfe/dashboard.dart';
import 'package:startpfe/firstpage.dart';
import 'package:startpfe/login_signup/LoginOwner.dart';
import 'secondpage.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp( MyApp(token: prefs.getString('token'),));

}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);
  final token;
  const MyApp({@required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Waf Waf House';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        body:(JwtDecoder.isExpired(token)==false)?Dashboard(token: token): FirstPage(),/* FirstPage()*/
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:startpfe/Provider/OTPProvider.dart';
import 'package:startpfe/screens/OTPScreen.dart';
import 'package:startpfe/screens/VerificationSuccessScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => OTPProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(392.72727272727275, 759.2727272727273),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: /*VerificationSuccessScreen(),*/ OTPScreen(),
    );
  }
}*/
