import 'package:scopedmodeltest/models/employeeModel.dart';
import 'package:scopedmodeltest/repository/network/api.dart';

import 'database/database.dart';

class Repository {
  Future<List<EmployeeModel>> getAllEmployees() async {
    final dbData = await internalDatabase.allEmployee();
    if (dbData == null || dbData.isEmpty) {
      final employeeListFromAPI = await api.getEmployees();
      await internalDatabase.insertEmployees(employeeListFromAPI);
    }
    return await internalDatabase.allEmployee();
  }



  Future<EmployeeModel> getEmployeeByID(String id){
    return internalDatabase.getEmployeeByID(id);
  }
}

final repository = Repository();
