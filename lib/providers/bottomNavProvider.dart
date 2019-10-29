import 'package:flutter/material.dart';
import 'package:scopedmodeltest/models/bottomNavModel.dart';
import 'package:scopedmodeltest/pages/employeeEdit.dart';
import 'package:scopedmodeltest/pages/employeeList.dart';
import 'package:scopedmodeltest/pages/employeeSearch.dart';
import 'package:scopedmodeltest/repository/repository.dart';
import 'package:scopedmodeltest/utilities/utils.dart';

class BottomNavProvider extends ChangeNotifier {
  final List<Widget> _pages = [
    EmployeeListPage(),
    EmployeeSearchPage(),
    EmployeeEditPage(),
  ];

  final List<String> _pageNames = ['Employees', 'Search', 'Edit'];

  final _bottomNavModel = BottomNavModel();

  void changePage(int index) async {
    _bottomNavModel.currentIndex = index;
    notifyListeners();
    final employees = await repository.getAllEmployees();
    logger.d("employee found: ${employees.length}");
  }

  Widget getCurrentPage() {
    return _pages[_bottomNavModel.currentIndex];
  }

  int getCurrentIndex() {
    return _bottomNavModel.currentIndex;
  }

  String getCurrentPageName() {
    return _pageNames[_bottomNavModel.currentIndex];
  }
}
