import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scopedmodeltest/providers/employeeProvider.dart';
import 'package:scopedmodeltest/utilities/utils.dart';

class EmployeeSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.green,
          child: Consumer<EmployeeProvider>(
            builder: (context, employeeProvider, child) {
              return employeeProvider.searchedList == null
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      children: <Widget>[
                        Container(
                          child: TextField(
                            onChanged: (value) {
                              logger.d(value);
                              employeeProvider.searchEmployee(keyword: value);
                            },
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(employeeProvider
                                    .searchedList[index].employeeName),
                                subtitle: Text(
                                    employeeProvider.searchedList[index].id),
                                leading: Icon(Icons.perm_contact_calendar),
                              );
                            },
                            itemCount: employeeProvider.searchedList.length,
                          ),
                        )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
