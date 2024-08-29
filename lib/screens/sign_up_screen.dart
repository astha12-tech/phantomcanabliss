import 'package:flutter/material.dart';
import 'package:phantomscanbliss/api/api.dart';
import 'package:phantomscanbliss/indicator/indicator.dart';
import 'package:phantomscanbliss/urils/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController firstNameontroller = TextEditingController();
  TextEditingController lastNameontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/png/app_icon.png",
              height: 170,
              width: 170,
            ),
            commonTextfield("Email", (val) {
              if (val!.isEmpty) {
                return "please enter email.";
              }
              return null;
            }, emailController),
            commonTextfield("UserName", (val) {
              if (val!.isEmpty) {
                return "please enter username.";
              }
              return null;
            }, userNameController),
            commonTextfield("First Name", (val) {
              if (val!.isEmpty) {
                return "please enter firstname.";
              }
              return null;
            }, firstNameontroller),
            commonTextfield("Last Name", (val) {
              if (val!.isEmpty) {
                return "please enter lastname.";
              }
              return null;
            }, lastNameontroller),
            commonTextfield("Password", (val) {
              if (val!.isEmpty) {
                return "please enter password.";
              }
              return null;
            }, passwordController),
            commonTextfield("Confirm Password", (val) {
              if (val!.isEmpty) {
                return "please enter confirm password.";
              }
              return null;
            }, confirmpasswordController),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  await pl.show();
                  await api.registerApi(
                      pl,
                      userNameController.text,
                      emailController.text,
                      passwordController.text,
                      confirmpasswordController.text,
                      firstNameontroller.text,
                      lastNameontroller.text,
                      context);
                  await pl.hide();
                }
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                  horizontal: 35,
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: colors.browncolor),
                child: Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: colors.whitecolor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget commonTextfield(String hintText, String? Function(String?)? validator,
      TextEditingController? controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.only(left: 10),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colors.browncolor)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colors.browncolor))),
      ),
    );
  }
}
