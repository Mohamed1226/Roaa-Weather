import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roaa_weather/model/shar_pref.dart';
import 'package:roaa_weather/view/home_view.dart';
import 'package:roaa_weather/view/sign_screen/register_screen.dart';
import 'package:roaa_weather/view_model/login_cubit/login_cubit.dart';
import 'package:roaa_weather/view_model/login_cubit/login_state.dart';

import '../custom_widget.dart';


class LogInScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitLogIn, LoginState>(listener: (context, state) {
      if (state is SocialLoginErrorState) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(state.error),
              );
            });
      }

      if (state is SocialLoginSucceedState) {
        CacheHelper.putData(key: "uId", value: state.uId);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeView();
        }));
      }
    }, builder: (context, state) {
      var cubit = CubitLogIn.get(context);
      return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  const    SizedBox(
                    height: 60,
                  ),
                  customTextFormField(
                      controller: email,
                      obsure: false,
                      label: "Your Email",
                      onSaved: (v) {},
                      validate: (v) {
                        if (v.toString().isEmpty) {
                          return "email can not be empty";
                        } else if (!v.toString().contains("@")) {
                          return "Not Correct Email";
                        } else {}
                      },
                      prefix:const Icon(Icons.event_note),
                      type: TextInputType.emailAddress),
                  const SizedBox(
                    height: 40,
                  ),
                  customTextFormField(
                    controller: password,
                    obsure: cubit.isVisible,
                    label: "Your Password",
                    onSaved: (v) {},
                    validate: (v) {
                      if (v.toString().isEmpty) {
                        return "Password can not be empty";
                      } else if (v.toString().length < 6) {
                        return "Not Strong Password";
                      } else {}
                    },
                    prefix:const Icon(Icons.ac_unit),
                    suffix: IconButton(
                      icon: Icon(cubit.isVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        cubit.changeVisibility();
                      },
                    ),
                    type: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    width: double.infinity,
                    height: 50,
                    child: state is SocialLoginLoadingState
                        ?const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.logIn(
                                    email: email.text, password: password.text);
                              }
                            },
                            child:const Text("Log In")),
                  ),
                  const  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      const Text("You Don Not Have an email ?",style: TextStyle(fontSize: 20),),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child:const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.blue,fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
