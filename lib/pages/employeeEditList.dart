import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scopedmodeltest/providers/employeeProvider.dart';
import 'package:scopedmodeltest/utilities/enums.dart';
import 'package:scopedmodeltest/utilities/routes.dart';

import 'employeeEditPage.dart';

class EmployeeEditList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.green,
        onPressed: (){
          routes.pushPage(context, EmployeeEditPage());
        },
      ),
      body: SafeArea(
        child: Container(
          child: Consumer<EmployeeProvider>(
            builder: (context, employeeProvider, child) {
              return employeeProvider.employeeList.isEmpty?Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ):ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(employeeProvider.employeeList[index].employeeName),
                    subtitle: Text(employeeProvider.employeeList[index].employeeAge),
                    onTap: () {
                      employeeProvider.goToEmployeeDetails(
                          context,EmployeeEditPage(action: ActionTypes.edit),id: employeeProvider.employeeList[index].id,);
                    },
                  );
                },
                itemCount:employeeProvider.employeeList.length,
              );
            },

          ),
        ),
      ),
    );
  }

}