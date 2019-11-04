import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scopedmodeltest/models/employeeModel.dart';
import 'package:scopedmodeltest/repository/database/database.dart';
import 'package:scopedmodeltest/repository/repository.dart';
import 'package:scopedmodeltest/utilities/enums.dart';
import 'package:scopedmodeltest/utilities/routes.dart';
import 'package:scopedmodeltest/utilities/utils.dart';

class EmployeeProvider extends ChangeNotifier {
  List<EmployeeModel> _employeeList = [];
  List<EmployeeModel> _searchedList = [];
  String _searchedKeyword = '';
  EmployeeModel _selectedEmployee = null;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  EmployeeProvider() {
    _loadEmployeeList();
  }

  Future<void> _loadEmployeeList() async {
    employeeList = await repository.getAllEmployees();
    searchEmployee(keyword: searchedKeyword);
    notifyListeners();
  }

  List<EmployeeModel> get employeeList => _employeeList;

  set employeeList(List<EmployeeModel> value) {
    _employeeList = value;
  }

  void searchEmployee({String keyword = ''}) {
    _searchedList = _employeeList
        .where((employee) => employee.employeeName.startsWith(keyword))
        .toList();
    searchedKeyword = keyword;
    notifyListeners();
  }

  List<EmployeeModel> get searchedList => _searchedList;

  set searchedList(List<EmployeeModel> value) {
    _searchedList = value;
  }

  String get searchedKeyword => _searchedKeyword;

  set searchedKeyword(String value) {
    _searchedKeyword = value;
  }

  void goToEmployeeDetails(BuildContext context, page,
      {String id = '-1'}) async {
    routes.pushPage(context, page);
    selectedEmployee = await repository.getEmployeeByID(id);
  }

  EmployeeModel get selectedEmployee => _selectedEmployee;

  set selectedEmployee(EmployeeModel value) {
    _selectedEmployee = value;
  }

  GlobalKey<FormState> get formKey => _formKey;

  void changeEmployeeRating(double rating, String id) async {
    await internalDatabase.updateEmployeeRating(rating, id);
    selectedEmployee = await repository.getEmployeeByID(id);
    await _loadEmployeeList();
  }

  void addOrUpdateEmployee(BuildContext context,
      actionType, String name, String age, String salary) async {


    if (formKey.currentState.validate()) {





      if (actionType == ActionTypes.add) {
        EmployeeModel employeeModel = EmployeeModel(
            id: Random.secure().nextInt(9999).toString(),
            employeeName: name,
            employeeAge: age,
            employeeSalary: salary,
            rating: 0,
            profileImage: '');

        await internalDatabase.insertEmployee(employeeModel);
      } else if (actionType == ActionTypes.edit) {
        await internalDatabase.updateEmployee(selectedEmployee.id, name, salary,
            age, selectedEmployee.profileImage);
      }
      await _loadEmployeeList();
      routes.goBack(context);





    }
  }

  void deleteEmployee(BuildContext context) async {
    internalDatabase.deleteEmployee(selectedEmployee.id);
    await _loadEmployeeList();
    routes.goBack(context);
  }

  String validateName(String value) {
    logger.d("sfsf " + value);
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  String validateAge(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  String validateSalary(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void imageSelectFromGallery() async {
    final galleryImage = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    logger.d("Selected gallery image path = ${galleryImage.path}");

    File croppedFile = await ImageCropper.cropImage(
        sourcePath: galleryImage.path,
        aspectRatio: CropAspectRatio(ratioX: 10, ratioY: 9),
        /*aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],*/
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
  }
}
