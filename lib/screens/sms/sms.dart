import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:startpfe/Provider/sms/OTPProvider.dart';
import 'package:startpfe/screens/sms/OTPScreen.dart';
import 'package:startpfe/screens/sms/VerificationSuccessScreen.dart';

class SmsStart extends StatelessWidget {
  const SmsStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Wrap SmsStart with ChangeNotifierProvider
    return ChangeNotifierProvider(
      create: (context) => OTPProvider(),
      child: ScreenUtilInit(
        designSize: const Size(392.72727272727275, 759.2727272727273),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'First Method',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            home: child,
          );
        },
        child: OTPScreen(), 
      ),
    );
  }
}
