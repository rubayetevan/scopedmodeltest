import 'package:dio/dio.dart';
import 'package:scopedmodeltest/models/employeeModel.dart';
import 'package:scopedmodeltest/utilities/utils.dart';
import 'networkConfigaration.dart';

class API {
  final _dio = Dio(NetworkConfiguration.baseOptions);
  final _getOptions = Options(method: "GET");
  final _postOptions = Options(method: "POST");

  Future<List<EmployeeModel>> getEmployees() async {
    if (Utils.isConnectedToInternet) {
      var response = await _dio.request(
        NetworkConfiguration.EMPLOYEE_URL,
        options: _getOptions,
      );
      logger.d(response.data);

      return employeeModelFromJson(response.data);
    } else {}
  }
}

final api = API();
