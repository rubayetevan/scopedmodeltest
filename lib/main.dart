import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scopedmodeltest/pages/homePage.dart';
import 'package:scopedmodeltest/providers/bottomNavProvider.dart';
import 'package:scopedmodeltest/providers/employeeProvider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => BottomNavProvider(),
        ),ChangeNotifierProvider(
          builder: (context) => EmployeeProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: HomePage(),
      ),
    );
  }
}
