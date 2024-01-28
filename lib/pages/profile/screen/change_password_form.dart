// ignore_for_file: avoid_print
import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/login/data/login_api.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  bool obscureText = true;
  bool newObscureText = false;
  IconData iconData = Icons.visibility_off;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: "Ganti Kata Sandi",
      buttonTitle: "Simpan",
      onSubmit: () async {
        try {
          Map<String, dynamic> data = {
            "oldPassword": oldPasswordController.text,
            "newPassword": newPasswordController.text,
          };
          await LoginApi.changePassword(data);
          await LoginApi.logout();
          await Session.clear();
          // ignore: use_build_context_synchronously
          context.go('/auth');
        } catch (e) {
          print(e);
        }
      },
      children: [
        CustomFormField(
          title: "Kata Sandi Saat Ini",
          textForm: TextFormField(
            controller: oldPasswordController,
            validator: ValidForm.emptyValue,
            onChanged: (val) {},
            obscureText: obscureText,
            decoration: TextFormDecoration.box(
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                    iconData =
                        obscureText ? Icons.visibility_off : Icons.visibility;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(
                    iconData,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
          ),
        ),
        CustomFormField(
          title: "Kata Sandi Baru",
          textForm: TextFormField(
            controller: newPasswordController,
            validator: ValidForm.emptyValue,
            onChanged: (val) {},
            obscureText: !newObscureText,
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Konfirmasi Kata Sandi",
          textForm: TextFormField(
            controller: confirmPasswordController,
            validator: (value) {
              return ValidForm.matchValue(
                  value, newPasswordController.text, "Password");
            },
            onChanged: (val) {},
            obscureText: !newObscureText,
            decoration: TextFormDecoration.box(),
          ),
        ),
        CheckboxListTile(
          title: const Text("Tampilkan Kata Sandi"),
          controlAffinity: ListTileControlAffinity.leading,
          value: newObscureText,
          onChanged: (bool? val) {
            setState(() {
              newObscureText = val!;
            });
          },
        )
      ],
    );
  }
}
