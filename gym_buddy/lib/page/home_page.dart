import 'package:flutter/material.dart';
import 'package:gym_buddy/api/firebase_api.dart';
import 'package:gym_buddy/main.dart';
import 'package:gym_buddy/model/training.dart';
import 'package:gym_buddy/provider/trainings.dart';
import 'package:gym_buddy/widget/done_training_widget.dart';
import 'package:gym_buddy/widget/training_list.dart';
import 'package:provider/provider.dart';

import '../widget/add_training_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TrainingListWidget(),
      DoneTraining(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'Trainings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done, size: 24),
            label: 'Done',
          ),
        ],
      ),
      body: StreamBuilder<List<Training>>(
        stream: FirebaseApi.readTraining(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return buildText('Something went wrong');
              } else {
                final trainings = snapshot.data;

                final provider = Provider.of<TrainingsProvider>(context);
                provider.setTrainings(trainings!);

                return tabs[selectedIndex];
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => showDialog(
          builder: (BuildContext context) {
            return const AddTrainingDialogWidget();
          },
          context: context,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
