import 'dart:io';

import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:entrance_test/src/utils/date_util.dart';
import 'package:entrance_test/src/utils/networking_util.dart';
import 'package:entrance_test/src/utils/string_ext.dart';
import 'package:entrance_test/src/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  final UserRepository _userRepository;

  EditProfileController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final etFullName = TextEditingController();
  final etPhoneNumber = TextEditingController();
  final etEmail = TextEditingController();
  final etHeight = TextEditingController();
  final etWeight = TextEditingController();
  final etBirthDate = TextEditingController();

  final _countryCode = "".obs;

  String get countryCode => _countryCode.value;

  final _gender = ''.obs;

  String get gender => _gender.value;

  final _profilePictureUrlOrPath = ''.obs;

  String get profilePictureUrlOrPath => _profilePictureUrlOrPath.value;

  final _isLoadPictureFromPath = false.obs;

  bool get isLoadPictureFromPath => _isLoadPictureFromPath.value;

  final _isGenderFemale = false.obs;

  bool get isGenderFemale => _isGenderFemale.value;

  DateTime birthDate = DateTime.now();

  RxBool isChangeImage = false.obs;

  File? pickedImageFile;
  var pickedImageString = "";

  @override
  void onInit() {
    super.onInit();
    loadUserFromServer();
  }

  void loadUserFromServer() async {
    try {
      final response = await _userRepository.getUser();
      if (response.status == 0) {
        final localUser = response.data;
        etFullName.text = localUser.name;
        etPhoneNumber.text = localUser.phone;
        etEmail.text = localUser.email ?? '';
        etHeight.text = localUser.height?.toString() ?? '';
        etWeight.text = localUser.weight?.toString() ?? '';

        _countryCode.value = localUser.countryCode;

        _profilePictureUrlOrPath.value = localUser.profilePicture ?? '';
        _isLoadPictureFromPath.value = false;

        _gender.value = localUser.gender ?? '';
        if (gender.isNullOrEmpty || gender == 'laki_laki') {
          onChangeGender(false);
        } else {
          onChangeGender(true);
        }

        etBirthDate.text = '';
        if (localUser.dateOfBirth.isNullOrEmpty == false) {
          birthDate =
              DateUtil.getDateFromShortServerFormat(localUser.dateOfBirth!);
          etBirthDate.text = DateUtil.getBirthDate(birthDate);
        }
      } else {
        SnackbarWidget.showFailedSnackbar(response.message);
      }
    } catch (error) {
      error.printError();
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    pickedImageString = pickedImage!.path;
    pickedImageFile = File(pickedImage.path);
    update();
  }

  void Function() get pickImage => _pickImage;

  void _changeImage() async {
    //TODO: Implement change profile image
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    pickedImageFile = File(pickedImage!.path);
    update();
    isChangeImage = true.obs;
  }

  void Function() get changeImage => _changeImage;

  void onChangeGender(bool isFemale) {
    if (isFemale) {
      _gender.value = 'perempuan';
    } else {
      _gender.value = 'laki_laki';
    }
    _isGenderFemale.value = isFemale;
  }

  void onChangeBirthDate(DateTime dateTime) {
    birthDate = dateTime;
    etBirthDate.text = DateUtil.getBirthDate(birthDate);
  }

  bool validateData() {
    bool validate = true;
    if (etFullName.text == "") {
      SnackbarWidget.showFailedSnackbar('Name cannot be empty');
      validate = false;
      return false;
    }
    if (etEmail.text == "") {
      SnackbarWidget.showFailedSnackbar('Email cannot be empty');
      validate = false;
      return false;
    }
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(etEmail.text);

    if (!emailValid) {
      SnackbarWidget.showFailedSnackbar('Wrong Format Email');
      validate = false;
      return false;
    }

    if (etHeight.text != "") {
      if (int.parse(etHeight.text) < 0) {
        SnackbarWidget.showFailedSnackbar('Height cannot below than 0');
        validate = false;
        return false;
      }
    } else {
      SnackbarWidget.showFailedSnackbar('Height cannot be Empty');
      validate = false;
      return false;
    }

    if (etWeight.text != "") {
      if (int.parse(etWeight.text) < 0) {
        SnackbarWidget.showFailedSnackbar('Weight cannot below than 0');
        validate = false;
        return false;
      }
    } else {
      SnackbarWidget.showFailedSnackbar('Weight cannot be Empty');
      validate = false;
      return false;
    }

    return validate;
  }

  void saveData() async {
    await _userRepository.editUser(
      name: etFullName.text,
      email: etEmail.text,
      gender: _gender.value,
      dateOfBirh: DateUtil.getBirthDate2(birthDate),
      height: etHeight.text,
      weight: etWeight.text,
      profilePicture: '',
    );
  }
}
