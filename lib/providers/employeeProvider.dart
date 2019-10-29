import 'package:flutter/cupertino.dart';
import 'package:scopedmodeltest/models/employeeModel.dart';
import 'package:scopedmodeltest/repository/repository.dart';
import 'package:scopedmodeltest/utilities/utils.dart';

class EmployeeProvider extends ChangeNotifier{

  List<EmployeeModel> _employeeList=[];

  List<EmployeeModel> _searchedList=[];

  EmployeeProvider(){
    _loadEmployeeList();
  }


  void _loadEmployeeList()async{
    employeeList= await repository.getAllEmployees() ;
    notifyListeners();
  }

  List<EmployeeModel> get employeeList => _employeeList;

  set employeeList(List<EmployeeModel> value) {
    _employeeList = value;
  }

  void searchEmployee({String keyword=''}){
    _searchedList= _employeeList.where((employee) => employee.employeeName.startsWith(keyword)).toList();

    logger.d('keyword =${_searchedList[0].employeeName}');
    notifyListeners();
  }


  List<EmployeeModel> get searchedList => _searchedList;

  set searchedList(List<EmployeeModel> value) {
    _searchedList = value;
  }









}