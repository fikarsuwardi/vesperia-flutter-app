import 'package:dio/dio.dart';
import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:entrance_test/src/widgets/snackbar_widget.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import '../constants/endpoint.dart';
import '../models/response/user_response_model.dart';
import '../utils/networking_util.dart';

class UserRepository {
  final Dio _client;
  final GetStorage _local;
  final _dio = Dio();

  UserRepository({required Dio client, required GetStorage local})
      : _client = client,
        _local = local;

  Future<void> login(
    String phoneNumber,
    String password,
    Function(RxBool) isButtonLoginDisable,
  ) async {
    try {
      final res = await _client.post(Endpoint.signIn, data: {
        'phone_number': phoneNumber,
        'password': password,
        'country_code': "62",
      });
      if (res.statusCode == 200) {
        SnackbarWidget.showSuccessSnackbar('Sukses Login');
        _local.write(
          LocalDataKey.token,
          res.data["data"]["token"],
        );
        Get.offAllNamed(RouteName.dashboard);
        isButtonLoginDisable(false.obs);
      } else {
        SnackbarWidget.showFailedSnackbar('Failed to login');
        isButtonLoginDisable(false.obs);
      }
    } catch (e) {
      SnackbarWidget.showFailedSnackbar(
          'Please give correct email and password');
      isButtonLoginDisable(false.obs);
    }
  }

  Future<void> logout() async {
    //Artificial delay to simulate logging out process
    // await Future.delayed(const Duration(seconds: 2));
    try {
      await _client.post(
        Endpoint.signOut,
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );
      await _local.remove(LocalDataKey.token);
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<UserResponseModel> getUser() async {
    try {
      final responseJson = await _client.get(
        Endpoint.getUser,
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );
      final model = UserResponseModel.fromJson(responseJson.data);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  /*
    This Function is used as challenge tester
    DO NOT modify this function
   */
  Future<void> testUnauthenticated() async {
    try {
      final realToken = _local.read<String?>(LocalDataKey.token);
      await _local.write(
          LocalDataKey.token, '619|kM5YBY5yM15KEuSmSMaEzlfv0lWs83r4cp4oty2T');
      getUser();
      //401 not caught as exception
      await _local.write(LocalDataKey.token, realToken);
    } on DioException catch (_) {
      rethrow;
    }
  }
}
