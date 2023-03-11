import 'package:api_app/services/post_request_login.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  String? email;
  String? password;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: ProgressHUD(
          inAsyncCall: isApiCallProcess,
          key: UniqueKey(),
          opacity: 0.3,
          child: Form(
            key: globalKey,
            child: ui_login(),
          ),
        ),
      ),
    );
  }

  Widget ui_login() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5.2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.grey, Colors.white],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            child: Image.network(
              "https://images.unsplash.com/photo-1677177871850-5dc0f6dbfe76?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
              fit: BoxFit.contain,
              height: 120,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 30, top: 50),
            child: Text(
              "Login",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            ),
          ),
          FormHelper.inputFieldWidget(context, "username", "username",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return "Username cannot be Empty";
            }
            return null;
          }, (onSavedVal) {
            password = onSavedVal;
          },
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              prefixIcon: const Icon(Icons.person),
              showPrefixIcon: true,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(.7),
              borderRadius: 10),
          const SizedBox(
            height: 20,
          ),
          FormHelper.inputFieldWidget(
            context,
            "Password",
            "Password",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Password cannot be Empty";
              }
              return null;
            },
            (onSavedVal) {
              password = onSavedVal;
            },
            borderFocusColor: Colors.white,
            prefixIconColor: Colors.white,
            prefixIcon: const Icon(Icons.password),
            showPrefixIcon: true,
            borderColor: Colors.white,
            textColor: Colors.white,
            hintColor: Colors.white.withOpacity(.7),
            borderRadius: 10,
            obscureText: hidePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              color: Colors.white,
              icon:
                  Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          // Center(
          //   child: FormHelper.submitButton(
          //     "Login",
          //     btnColor: const Color.fromARGB(255, 19, 232, 125),
          //     () {
          //       if (validateAndSave()) {
          //         // API call krden save krne k liay
          //         setState(() {
          //           isApiCallProcess = true;
          //         });
          //         print("call se pehle");
          //         APIService.login(email!, password!).then((response) {
          //           setState(() {
          //             print("the response var is  $response");
          //             isApiCallProcess = false;
          //           });

          //           if (response) {
          //             FormHelper.showSimpleAlertDialog(
          //                 context, "Login App", "Login Successful", "Ok", () {
          //               Navigator.of(context).pop();
          //             });
          //           } else {
          //             FormHelper.showSimpleAlertDialog(context, "Login App",
          //                 "Invalid Username/Password", "Ok", () {
          //               Navigator.of(context).pop();
          //             });
          //           }
          //         });
          //       }
          //     },
          //   ),
          // )
          Center(
      child: InkWell(
        child: Ink(
          width: 500,
          height: 300,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.green),
          child: const Text(
            "Login",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        onTap: () {
// API Call
          if (validateAndSave()) {
            setState(() {
              isApiCallProcess = true;
            });

            APIService.login(email!, password!).then((response) {
              setState(() {
                isApiCallProcess = false;
              });

              if (response) {
                FormHelper.showSimpleAlertDialog(
                    context, "Login App", "Login Successful", "Ok", () {
                  Navigator.of(context).pop();
                });
              } else {
                FormHelper.showSimpleAlertDialog(
                    context, "Login App", "Invalid Username/Password", "Ok",
                    () {
                  Navigator.of(context).pop();
                });
              }
            });
          }
        },
      ),
    ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Widget func() {
    return Center(
      child: InkWell(
        child: Ink(
          width: 500,
          height: 300,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.green),
          child: const Text(
            "Login",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        onTap: () {
// API Call
          if (validateAndSave()) {
            setState(() {
              isApiCallProcess = true;
            });

            APIService.login(email!, password!).then((response) {
              setState(() {
                isApiCallProcess = false;
              });

              if (response) {
                FormHelper.showSimpleAlertDialog(
                    context, "Login App", "Login Successful", "Ok", () {
                  Navigator.of(context).pop();
                });
              } else {
                FormHelper.showSimpleAlertDialog(
                    context, "Login App", "Invalid Username/Password", "Ok",
                    () {
                  Navigator.of(context).pop();
                });
              }
            });
          }
        },
      ),
    );
  }
}
