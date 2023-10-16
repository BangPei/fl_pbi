import 'package:fl_pbi/library/app_theme.dart';
import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/session_manager.dart';
import 'package:fl_pbi/screen/login/data/login_api.dart';
import 'package:fl_pbi/widget.dart/custom_appbar.dart';
import 'package:fl_pbi/widget.dart/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Color color = AppTheme.nearlyDarkRed.withOpacity(0.5);
  bool loading = false;
  String? accountName;
  String? imageurl;

  @override
  void initState() {
    loading = true;
    setState(() {
      Session.get("fullName")
          .then((value) => setState(() => accountName = value));
      Session.get("picture").then((value) => setState(() => imageurl = value));
      loading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: CustomAppbar(
            title: "",
            backgroundColor: color,
          ),
        ),
        body: loading
            ? const LoadingScreen()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: color,
                      child: Align(
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(50),
                                ),
                                image: (imageurl == null || imageurl == "")
                                    ? DecorationImage(
                                        image: AssetImage(Common.imageProfile),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: NetworkImage(imageurl!),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                accountName ?? "Account Name",
                                style: const TextStyle(
                                  color: AppTheme.nearlyWhite,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: InkWell(
                                onTap: () {
                                  context.pushNamed("profile-form").then((val) {
                                    Session.get("fullName").then((value) =>
                                        setState(() => accountName = value));
                                    Session.get("picture").then((value) =>
                                        setState(() => imageurl = value));
                                  });
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                        color: AppTheme.nearlyWhite,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    SizedBox(width: 3),
                                    FaIcon(
                                      FontAwesomeIcons.pencil,
                                      color: Colors.white,
                                      size: 15,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 13, top: 10),
                      child: Text(
                        "Pengaturan Akun",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 114, 113, 113)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed("change-password");
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Card(
                          child: ListTile(
                            leading: Icon(Icons.lock_open_outlined),
                            title: Text("Ganti Password"),
                            trailing: Icon(Icons.arrow_right),
                          ),
                        ),
                      ),
                    ),
                    // Visibility(
                    //   visible: true,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       context.pushNamed("users");
                    //     },
                    //     child: const Padding(
                    //       padding: EdgeInsets.only(top: 5.0),
                    //       child: Card(
                    //         child: ListTile(
                    //           leading: Icon(FontAwesomeIcons.user),
                    //           title: Text("Daftar Pengguna"),
                    //           trailing: Icon(Icons.arrow_right),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () async {
                        try {
                          await LoginApi.logout();
                          await Session.clear();
                          // ignore: use_build_context_synchronously
                          context.go('/auth');
                        } catch (e) {
                          // print(e);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.nearlyBlack,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ));
  }
}
