import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scopedmodeltest/providers/employeeProvider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class EmployeeRatingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(16),
            child: Consumer<EmployeeProvider>(
              builder: (context, employeeProvider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      size: 64,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Name: ${employeeProvider.selectedEmployee.employeeName}'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Id: ${employeeProvider.selectedEmployee.id}'),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Salary: ${employeeProvider.selectedEmployee.employeeSalary}'),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Age: ${employeeProvider.selectedEmployee.employeeAge}'),
                    SizedBox(
                      height: 10,
                    ),
                    SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (rating) {
                        employeeProvider.changeEmployeeRating(
                            rating, employeeProvider.selectedEmployee.id);
                      },
                      starCount: 5,
                      rating: employeeProvider.selectedEmployee.rating,
                      size: 32,
                      color: Colors.orange,
                      borderColor: Colors.black38,
                      spacing: 0.0,
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
