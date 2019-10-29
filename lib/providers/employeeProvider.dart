import 'package:flutter/cupertino.dart';
import 'package:scopedmodeltest/models/employeeModel.dart';
import 'package:scopedmodeltest/repository/repository.dart';

class EmployeeProvider extends ChangeNotifier{

  List<EmployeeModel> _employeeList=[];


  Future<void> loadEmployeeList()async{
    _employeeList= await repository.getAllEmployees() ;
    notifyListeners();
  }

  List<EmployeeModel> employeeList (){
    loadEmployeeList();
    return _employeeList;
  }



}