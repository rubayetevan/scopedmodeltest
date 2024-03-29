import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scopedmodeltest/pages/employeeRatingPage.dart';
import 'package:scopedmodeltest/providers/employeeProvider.dart';

class EmployeeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Consumer<EmployeeProvider>(
            builder: (context, employeeProvider, child) {
              return employeeProvider.employeeList.isEmpty
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(employeeProvider
                              .employeeList[index].employeeName),
                          subtitle:
                              Text(employeeProvider.employeeList[index].employeeAge),
                          onTap: () {
                            employeeProvider.goToEmployeeDetails(
                                context, EmployeeRatingPage(),
                                id: employeeProvider.employeeList[index].id);
                          },
                        );
                      },
                      itemCount: employeeProvider.employeeList.length,
                    );
            },
          ),
        ),
      ),
    );
  }
}
