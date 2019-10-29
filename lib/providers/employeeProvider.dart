import 'package:flutter/cupertino.dart';
import 'package:scopedmodeltest/models/employeeModel.dart';
import 'package:scopedmodeltest/repository/repository.dart';

class EmployeeProvider extends ChangeNotifier{

  List<EmployeeModel> employeeList=[];


  void getEmployeeList()async{
    employeeList = await repository.getAllEmployees();
    notifyListeners();
  }


}