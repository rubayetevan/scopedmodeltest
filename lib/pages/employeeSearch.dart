import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scopedmodeltest/providers/employeeProvider.dart';
import 'package:scopedmodeltest/utilities/utils.dart';

class EmployeeSearchPage extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Consumer<EmployeeProvider>(
            builder: (context, employeeProvider, child) {
              if (_controller.text.isEmpty) {
                _controller.text = employeeProvider.searchedKeyword;
                _controller.selection =
                    TextSelection.collapsed(offset: _controller.text.length);
              }

              return employeeProvider.searchedList == null
                  ? Container(
                      margin: EdgeInsets.all(16),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(16),
                          child: TextField(
                            controller: _controller,
                            onChanged: (value) {
                              employeeProvider.searchEmployee(keyword: value);
                            },
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black.withOpacity(.60)),
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
                              prefixIcon: Icon(Icons.search),
                              labelText: 'Name',
                              fillColor: Color(0xffDEDEDE),
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(.60)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(employeeProvider
                                    .searchedList[index].employeeName),
                                subtitle: Text(employeeProvider
                                    .searchedList[index].employeeAge),
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
