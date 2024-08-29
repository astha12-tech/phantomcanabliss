import 'package:flutter/material.dart';
import 'package:phantomscanbliss/api/api.dart';
import 'package:phantomscanbliss/indicator/indicator.dart';
import 'package:phantomscanbliss/model/get_customer_model.dart';
import 'package:phantomscanbliss/screens/update_profile_screen.dart';
import 'package:phantomscanbliss/screens/web_view_screen.dart';
import 'package:phantomscanbliss/shared_prefs/shared_prefs.dart';
import 'package:phantomscanbliss/text_component/text.dart';
import 'package:phantomscanbliss/urils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:launch_review/launch_review.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("P r o f i l e"),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFFFFFFFF),
                  border:
                      Border.all(color: colors.browncolor.withOpacity(0.25))),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg/profile-circle.svg",
                    color: colors.browncolor,
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text("${SpUtil.getString(SpConstUtil.userName)}"),
                      text("${SpUtil.getString(SpConstUtil.userEmail)}"),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () async {
                        GetCustomerModel? getCustomerModel;
                        await pl.show();
                        getCustomerModel = await api.getCustomerApi(pl);
                        await pl.hide();
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateProfileScreen(
                                      getCustomerModel: getCustomerModel!,
                                    )));
                        setState(() {});
                      },
                      child: SvgPicture.asset(
                        "assets/svg/edit.svg",
                        color: colors.browncolor,
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFFFFFFFF),
                  border:
                      Border.all(color: colors.browncolor.withOpacity(0.25))),
              child: Row(
                children: [
                  SvgPicture.asset(
                    height: 30,
                    width: 30,
                    "assets/svg/note2.svg",
                    color: colors.browncolor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  text("My Orders")
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFFFFFFFF),
                  border:
                      Border.all(color: colors.browncolor.withOpacity(0.25))),
              child: Row(
                children: [
                  SvgPicture.asset(
                    height: 30,
                    width: 30,
                    "assets/svg/heart-circle.svg",
                    color: colors.browncolor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  text("My Wishlist")
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  LaunchReview.launch(
                      androidAppId: "com.iyaffle.rangoli",
                      iOSAppId: "585027354");
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFFFFFFFF),
                      border: Border.all(
                          color: colors.browncolor.withOpacity(0.25))),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/star.svg",
                        height: 30,
                        width: 30,
                        color: colors.browncolor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      text("Rate The App"),
                    ],
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (coontext) => WebviewScreen(
                                name: "Privacy and Term",
                                url:
                                    "https://phantomscannabliss.com/terms-conditions/",
                              )));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFFFFFFFF),
                      border: Border.all(
                          color: colors.browncolor.withOpacity(0.25))),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        color: colors.browncolor,
                        "assets/svg/task-square.svg",
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      text("Privacy and Term"),
                    ],
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFFFFFFFF),
                      border: Border.all(
                          color: colors.browncolor.withOpacity(0.25))),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        color: colors.browncolor,
                        "assets/svg/information.svg",
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      text("About Us"),
                    ],
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  showDialog(
                    builder: (context) => AlertDialog(
                      title: const Text('Are you sure you want to logout?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
                    context: context,
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFFFFFFFF),
                      border: Border.all(
                          color: colors.browncolor.withOpacity(0.25))),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        color: colors.browncolor,
                        "assets/svg/logout.svg",
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      text(
                        "Logout",
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }
}
