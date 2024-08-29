import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:phantomscanbliss/api/api.dart';
import 'package:phantomscanbliss/indicator/indicator.dart';
import 'package:phantomscanbliss/screens/sign_up_screen.dart';
import 'package:phantomscanbliss/urils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
            commonTextfield("Username / Email", (val) {
              if (val!.isEmpty) {
                return "please enter username / email.";
              }
              return null;
            }, userNameController),
            commonTextfield("Password", (val) {
              if (val!.isEmpty) {
                return "please enter password.";
              }
              return null;
            }, passwordController),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  await pl.show();
                  await api.loginApi(pl, userNameController.text,
                      passwordController.text, context);
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
                    "Login",
                    style: TextStyle(
                        color: colors.whitecolor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                text: "Don't have account? ",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                    text: " Sign up",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: colors.browncolor,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
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
        controller: controller,
        validator: validator,
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
