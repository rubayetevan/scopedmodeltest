import 'package:flutter/material.dart';
import 'package:scopedmodeltest/models/bottomNavModel.dart';
import 'package:scopedmodeltest/pages/employeeEdit.dart';
import 'package:scopedmodeltest/pages/employeeList.dart';
import 'package:scopedmodeltest/pages/employeeSearch.dart';

class BottomNavProvider extends ChangeNotifier {
  final List<Widget> _pages = [
    EmployeeListPage(),
    EmployeeSearchPage(),
    EmployeeEditPage(),
  ];

  final List<String> _pageNames = ['Employees', 'Search', 'Edit'];

  final _bottomNavModel = BottomNavModel();

  void changePage(int index) {
    _bottomNavModel.currentIndex = index;
    notifyListeners();
  }

  Widget getCurrentPage() {
    return _pages[_bottomNavModel.currentIndex];
  }

  int getCurrentIndex() {
    return _bottomNavModel.currentIndex;
  }

  String getCurrentPageName(){
    return _pageNames[_bottomNavModel.currentIndex];
  }
}
