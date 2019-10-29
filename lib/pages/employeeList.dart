import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scopedmodeltest/providers/employeeProvider.dart';

class EmployeeListPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context);
    employeeProvider.getEmployeeList();
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.amber,
          child: Consumer<EmployeeProvider>(
            builder: (context, employeeProvider, child) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(employeeProvider.employeeList[index].employeeName),
                    subtitle: Text(employeeProvider.employeeList[index].id),
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
