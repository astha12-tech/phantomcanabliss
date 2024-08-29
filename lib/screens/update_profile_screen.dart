import 'package:flutter/material.dart';
import 'package:phantomscanbliss/api/api.dart';
import 'package:phantomscanbliss/indicator/indicator.dart';
import 'package:phantomscanbliss/model/get_customer_model.dart';
import 'package:phantomscanbliss/shared_prefs/shared_prefs.dart';
import 'package:phantomscanbliss/text_component/fontweight.dart';
import 'package:phantomscanbliss/text_component/text.dart';
import 'package:phantomscanbliss/urils/colors.dart';

class UpdateProfileScreen extends StatefulWidget {
  GetCustomerModel getCustomerModel;

  UpdateProfileScreen({super.key, required this.getCustomerModel});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController firstNameontroller = TextEditingController();
  TextEditingController lastNameontroller = TextEditingController();

  @override
  void initState() {
    userNameController.text = widget.getCustomerModel.username!;
    emailController.text = widget.getCustomerModel.email!;
    firstNameontroller.text = widget.getCustomerModel.firstName!;
    lastNameontroller.text = widget.getCustomerModel.lastName!;
    super.initState();
  }

  bool editMode = false;

  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Update Profile"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  commonTextfield("Email", (val) {
                    if (val!.isEmpty) {
                      return "please enter email.";
                    }
                    return null;
                  }, emailController, editMode),
                  commonTextfield("First Name", (val) {
                    if (val!.isEmpty) {
                      return "please enter firstname.";
                    }
                    return null;
                  }, firstNameontroller, editMode),
                  commonTextfield("Last Name", (val) {
                    if (val!.isEmpty) {
                      return "please enter lastname.";
                    }
                    return null;
                  }, lastNameontroller, editMode),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Container(
                    // height: 75,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1A3A87).withOpacity(
                                0.25), // Shadow color with 25% opacity
                            offset: const Offset(0, 0), // Shadow position
                            blurRadius: 5, // Blur radius
                            spreadRadius: 0, // Spread radius
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await pl.show();
                                setState(() {
                                  editMode = !editMode;
                                });
                                await pl.hide();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        color: colors.browncolor
                                            .withOpacity(0.25))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: text("Edit",
                                        fontSize: 16,
                                        fontWeight: fontWeight.bold,
                                        color: colors.browncolor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (editMode) {
                                    await pl.show();
                                    // await apis.updateCustomerApi(
                                    //     pl, emailController.text);
                                    await api.updateCustomerApi(
                                        pl,
                                        firstNameontroller.text,
                                        lastNameontroller.text,
                                        emailController.text);

                                    await SpUtil.putString(SpConstUtil.userName,
                                        userNameController.text);

                                    await SpUtil.putString(
                                        SpConstUtil.userEmail,
                                        emailController.text);
                                    editMode = false;
                                    setState(() {});

                                    await pl.hide();
                                  } else {
                                    debugPrint(
                                        "====== you'nt editiable ======");
                                  }
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: colors.browncolor),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: text("Update Account",
                                        color: colors.whitecolor,
                                        fontSize: 16,
                                        fontWeight: fontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ))),
          ],
        ),
      ),
    );
  }

  Widget commonTextfield(String hintText, String? Function(String?)? validator,
      TextEditingController? controller, bool? editMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
      child: TextFormField(
        validator: validator,
        enabled: editMode,
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
