import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roaa_weather/data/shar_pref.dart';
import 'package:roaa_weather/view_model/login_cubit/login_cubit.dart';
import 'package:roaa_weather/view_model/login_cubit/login_state.dart';

import '../custom_widget/custom_widget.dart';
import '../home_view.dart';


class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitLogIn, LoginState>(
      listener: (context, state) {
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
      },
      builder: (context, state) {
        var cubit = CubitLogIn.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Sign UP",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    customTextFormField(
                        controller: name,
                        obsure: false,
                        label: "Your Name",
                        onSaved: (v) {},
                        validate: (v) {
                          if (v.toString().isEmpty) {
                            return "Name can not be empty";
                          } else {}
                        },
                        prefix: Icon(Icons.drive_file_rename_outline),
                        type: TextInputType.text),
                    SizedBox(
                      height: 40,
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
                const    SizedBox(
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
                      prefix: Icon(Icons.ac_unit),
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
                   const  SizedBox(
                      height: 40,
                    ),
                    customTextFormField(
                      controller: phoneNumber,
                      obsure: false,
                      label: "Your Phone Number",
                      onSaved: (v) {},
                      validate: (v) {
                        if (v.toString().isEmpty) {
                          return "Phone Number can not be empty";
                        } else if (v.toString().length < 6) {
                          return "InCorrect Phone Number";
                        } else {}
                      },
                      prefix: Icon(Icons.phone),
                      type: TextInputType.number,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      width: double.infinity,
                      height: 50,
                      child: state is SocialLoginLoadingState
                          ?const  Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                      name: name.text,
                                      email: email.text,
                                      password: password.text,
                                      phone: phoneNumber.text);
                                }
                              },
                              child:const Text("Sign Up")),
                    ),
                 const    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                       const Text("You Have an email ?",style: TextStyle(fontSize: 20),),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child:const Text(
                            "Log In",
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
      },
    );
  }
}
