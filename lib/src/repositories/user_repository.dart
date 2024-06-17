import 'package:dio/dio.dart';
import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:entrance_test/src/widgets/snackbar_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

import '../constants/endpoint.dart';
import '../models/response/user_response_model.dart';
import '../utils/networking_util.dart';

class UserRepository {
  final Dio _client;
  final GetStorage _local;

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
        _local.write(
          LocalDataKey.token,
          res.data["data"]["token"],
        );
        SnackbarWidget.showSuccessSnackbar('Sukses Login');
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
    isButtonLoginDisable(false.obs);
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
      Get.offAllNamed(RouteName.login);
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

  Future<void> editUser({
    required String name,
    required String email,
    required String gender,
    required String dateOfBirh,
    required String height,
    required String weight,
    required String profilePicture,
  }) async {
    var formData = FormData.fromMap({
      "name": name,
      "email": email,
      "gender": gender,
      "date_of_birth": dateOfBirh,
      "height": height,
      "weight": weight,
      "profile_picture": profilePicture,
      "_method": "PUT"
    });
    final responseJson = await _client.post(
      Endpoint.editUser,
      options: NetworkingUtil.setupNetworkOptions(
          'Bearer ${_local.read(LocalDataKey.token)}'),
      data: formData,
    );

    if (responseJson.statusCode == 200) {
      Get.back();
      SnackbarWidget.showSuccessSnackbar('Success Edit');
    } else {
      SnackbarWidget.showFailedSnackbar('Failed');
    }
  }

  /*
    This Function is used as challenge tester
    DO NOT modify this function
   */
  Future<void> testUnauthenticated() async {
    try {
      final realToken = _local.read<String?>(LocalDataKey.token);
      // await _local.write(
      //     LocalDataKey.token, '619|kM5YBY5yM15KEuSmSMaEzlfv0lWs83r4cp4oty2T');
      // getUser();
      //401 not caught as exception
      await _local.write(LocalDataKey.token, realToken);

      final checkLogout = await _client.post(
        Endpoint.signOut,
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );
      if (checkLogout.statusCode == 401) {
        Get.offAllNamed(RouteName.login);
        await _local.remove(LocalDataKey.token);
      }

      final checkDetailUser = await _client.get(
        Endpoint.getUser,
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );
      if (checkDetailUser.statusCode == 401) {
        Get.offAllNamed(RouteName.login);
        await _local.remove(LocalDataKey.token);
      }
    } on DioException catch (_) {
      rethrow;
    }
  }
}
