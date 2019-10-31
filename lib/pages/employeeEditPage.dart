import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scopedmodeltest/models/employeeModel.dart';
import 'package:scopedmodeltest/providers/employeeProvider.dart';
import 'package:scopedmodeltest/utilities/enums.dart';
import 'package:scopedmodeltest/utilities/routes.dart';
import 'package:scopedmodeltest/utilities/utils.dart';

class EmployeeEditPage extends StatelessWidget {
  final action;

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _salaryController = TextEditingController();

  EmployeeEditPage({this.action = ActionTypes.add});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer<EmployeeProvider>(
          builder: (context, employeeProvider, child) {
        return FloatingActionButton(
          child: Icon(
            Icons.save,
            color: Colors.white,
          ),
          backgroundColor: Colors.green,
          onPressed: () {
            employeeProvider.addOrUpdateEmployee(action, _nameController.text,
                _ageController.text, _salaryController.text);
            routes.goBack(context);
          },
        );
      }),
      appBar: AppBar(
        actions: <Widget>[
          action == ActionTypes.add
              ? SizedBox()
              : Consumer<EmployeeProvider>(
                  builder: (context, employeeProvider, child) {
                    return IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        employeeProvider.deleteEmployee();
                        routes.goBack(context);
                      },
                    );
                  },
                ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(child: Consumer<EmployeeProvider>(
            builder: (context, employeeProvider, child) {
              if (action == ActionTypes.edit) {
                if (_nameController.text.isEmpty) {
                  _nameController.text =
                      employeeProvider.selectedEmployee.employeeName;
                  _nameController.selection = TextSelection.collapsed(
                      offset: _nameController.text.length);
                }

                if (_ageController.text.isEmpty) {
                  _ageController.text =
                      employeeProvider.selectedEmployee.employeeAge;
                  _ageController.selection = TextSelection.collapsed(
                      offset: _ageController.text.length);
                }

                if (_salaryController.text.isEmpty) {
                  _salaryController.text =
                      employeeProvider.selectedEmployee.employeeSalary;
                  _salaryController.selection = TextSelection.collapsed(
                      offset: _salaryController.text.length);
                }
              }

              return Form(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 24,
                    ),
                    Material(
                      color: Colors.white,
                      child: InkWell(
                        splashColor: Colors.black38,
                        onTap: () {
                          employeeProvider.imageSelectFromGallery();
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Icon(
                            Icons.person,
                            size: 100,
                          ),
                        ),
                      ),
                    ),
                    _textField('Name', _nameController,employeeProvider.validateName),
                    _textField('Age', _ageController,employeeProvider.validateAge),
                    _textField('Salary', _salaryController,employeeProvider.validateSalary),
                  ],
                ),
              );
            },
          )),
        ),
      ),
    );
  }

  TextFormField _textField(String labelText, TextEditingController controller,Function validator) {
    return TextFormField(
      validator: (value){
        logger.d("sfsf "+value);
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        labelStyle:
            TextStyle(fontSize: 16.0, color: Colors.black.withOpacity(.60)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(4.0)),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.orange,
            width: 10.0,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        labelText: labelText,
        fillColor: Color(0xffDEDEDE),
        hintStyle: TextStyle(color: Colors.black.withOpacity(.60)),
      ),
    );
  }
}
