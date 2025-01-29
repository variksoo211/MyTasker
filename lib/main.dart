import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_screen.dart';
import 'providers/task_provider.dart';
import 'models/task_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter()); // Register Hive adapter
  await Hive.openBox<Task>('tasks'); // Open a Hive box to store tasks

=======
import 'package:mytasker/screens/home_screen.dart';
import 'package:mytasker/providers/task_provider.dart';

void main() {
>>>>>>> 56cc2617df886f99a5b098a880e3ce3649b1a942
  runApp(MyTaskerApp());
}

class MyTaskerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyTasker',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
