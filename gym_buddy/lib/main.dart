import 'package:flutter/material.dart';
import 'package:gym_buddy/provider/trainings.dart';
import 'package:provider/provider.dart';

import 'page/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static String title = 'Gym Buddy';
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => TrainingsProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.amber,
          ),
          home: const HomePage(),
        ),
      );
}
