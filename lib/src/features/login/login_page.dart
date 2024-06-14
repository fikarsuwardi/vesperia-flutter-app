import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../constants/color.dart';
import '../../constants/icon.dart';
import '../../widgets/button_icon.dart';
import 'component/login_controller.dart';
import 'package:country_code_picker/country_code_picker.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: const Text(
            "Sign In",
            style: TextStyle(
              fontSize: 16,
              color: gray900,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Hi, Welcome Back",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Sign in to your account.',
                  style: TextStyle(
                    fontSize: 16,
                    color: gray500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: 'Phone Number',
                                style: TextStyle(color: gray900),
                              ),
                              TextSpan(
                                text: ' *',
                                style: TextStyle(color: red500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: gray900),
                    cursorColor: primary,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:
                            const BorderSide(color: gray200, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:
                            const BorderSide(color: gray200, width: 1.5),
                      ),
                      fillColor: white,
                      filled: true,
                      hintText: 'Phone Number',
                      prefixIcon: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // SizedBox(width: 6),
                          // Text(
                          //   '+62',
                          //   style: TextStyle(
                          //       fontSize: 14,
                          //       fontWeight: FontWeight.w600,
                          //       color: gray900),
                          // ),
                          // SizedBox(width: 12),
                          // SizedBox(
                          //   width: 1.5,
                          //   height: 48,
                          //   child: DecoratedBox(
                          //     decoration: BoxDecoration(color: gray100),
                          //   ),
                          // ),
                          CountryCodePicker(
                            onChanged: print,
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: 'ID',
                            // favorite: ['+39', 'FR'],
                            // optional. Shows only country name and flag
                            showCountryOnly: false,
                            // optional. Shows only country name and flag when popup is closed.
                            showOnlyCountryWhenClosed: false,
                            // optional. aligns the flag and the Text left
                            alignLeft: false,
                          ),
                        ],
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                    ],
                    controller: controller.etPhone,
                  ),
                  Obx(() {
                    return controller.isPhoneNumberValid.value == false
                        ? const Text(
                            "Phone number length less than 8 or more than 16",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          )
                        : const SizedBox();
                  }),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: 'Password',
                                style: TextStyle(color: gray900),
                              ),
                              TextSpan(
                                text: ' *',
                                style: TextStyle(color: red500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Obx(() {
                    return TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: gray900),
                      obscureText: controller.isPasswordHidden.value,
                      cursorColor: primary,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                          left: 12,
                          right: -14,
                          top: 20,
                          bottom: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: gray200, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: gray200, width: 1.5),
                        ),
                        fillColor: white,
                        filled: true,
                        hintText: 'Password',
                        suffixIcon: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: ImageIcon(
                              AssetImage(controller.isPasswordHidden.value
                                  ? ic_show_password
                                  : ic_hide_password),
                            ),
                          ),
                          onTap: () {
                            controller.isPasswordHidden.value =
                                !controller.isPasswordHidden.value;
                          },
                        ),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: ImageIcon(
                            AssetImage(ic_password),
                          ), // icon is 48px widget.
                        ),
                      ),
                      controller: controller.etPassword,
                    );
                  }),
                  Obx(() {
                    return controller.isPasswordValid.value == false
                        ? const Text(
                            "Password length less than 8",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          )
                        : const SizedBox();
                  }),
                ],
              ),
              const SizedBox(height: 24),
              loginButton(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginButton() => SizedBox(
        height: 52,
        width: double.infinity,
        child: SizedBox(
          height: 52,
          width: double.infinity,
          child: Obx(() {
            return ButtonIcon(
              buttonColor:
                  controller.isButtonLoginDisable.value ? Colors.grey : primary,
              textColor: white,
              textLabel: "Sign In",
              onClick: () {
                if (controller.validator()) {
                  controller.doLogin();
                }
              },
            );
          }),
        ),
      );
}
