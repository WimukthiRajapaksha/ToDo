import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/providers/authService.dart';
import 'package:to_do_list/screens/addNew.dart';
import 'package:to_do_list/screens/home.dart';
import 'package:to_do_list/screens/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("...........main");
    return ChangeNotifierProvider(
      create: (ctx) => AuthService(),
      child: Consumer<AuthService>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            // scaffoldBackgroundColor: Color(0xff021c45),
          ),
          // initialRoute: Home.routeName,
          home: (auth.uid != null)
              // ? Scaffold(
              //     body: Container(
              //       color: Colors.red,
              //     ),
              //   )
              // : Scaffold(
              //     body: Container(
              //       color: Colors.green,
              //     ),
              //   ),

              ? Home()
              : FutureBuilder(
                  future: auth.signInAnony(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return (snapshot.connectionState == ConnectionState.waiting)
                        ? Splash()
                        : Home();
                  },
                ),

          routes: {
            Home.routeName: (context) => Home(),
            AddNew.routeName: (context) => AddNew()
          },
        ),
      ),

      // Consumer<AuthService>(
      //   builder: (ctx, auth, _)
      //     => auth.signInAnony().then((value) =>
      // MaterialApp(
      //           title: 'Flutter Demo',
      //           theme: ThemeData(
      //             primarySwatch: Colors.blue,
      //             // scaffoldBackgroundColor: Color(0xff021c45),
      //           ),
      //           initialRoute: Home.routeName,
      //           routes: {
      //             Home.routeName: (context) => Home(),
      //             AddNew.routeName: (context) => AddNew()
      //           },
      //         )
      // );
      //     // return MaterialApp(
      //     //   title: 'Flutter Demo',
      //     //   theme: ThemeData(
      //     //     primarySwatch: Colors.blue,
      //     //     // scaffoldBackgroundColor: Color(0xff021c45),
      //     //   ),
      //     //   initialRoute: Home.routeName,
      //     //   routes: {
      //     //     Home.routeName: (context) => Home(),
      //     //     AddNew.routeName: (context) => AddNew()
      //     //   },
      //     // );
      //   ,
      // ),
    );
  }
}
