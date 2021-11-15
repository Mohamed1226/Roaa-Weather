import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roaa_weather/data/shar_pref.dart';
import 'package:roaa_weather/presentation/screens/login/login_screen.dart';
import 'package:roaa_weather/presentation/shared/cubit/authentication_cubit.dart';
import 'package:roaa_weather/presentation/shared/cubit/authentication_state.dart';
import 'package:roaa_weather/presentation/widget/app_dialog.dart';
import 'package:roaa_weather/presentation/widget/app_text_form_field.dart';

import '../weather/weather_screen.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final TextEditingController name = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationErrorState) {
          appDialog(context, state.error.toString());
        }
        if (state is AuthenticationSucceedState) {
          CacheHelper.putData(key: "uId", value: state.uId);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return WeatherScreen();
          }));
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Sign UP",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Name",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    appTextFormField(
                        controller: name,
                        obsure: false,
                        label: "Your Name",
                        onSaved: (v) {},
                        validate: (v) {
                          if (v.toString().isEmpty) {
                            return "Name can not be empty";
                          } else {}
                        },
                        prefix: const Icon(Icons.drive_file_rename_outline),
                        type: TextInputType.text),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Phone NM",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    appTextFormField(
                        controller: phoneNumber,
                        obsure: false,
                        label: "Your Phone Number",
                        onSaved: (v) {},
                        validate: (v) {
                          if (v.toString().isEmpty) {
                            return "Phone Number can not be empty";
                          } else {}
                        },
                        prefix: const Icon(Icons.phone),
                        type: TextInputType.number),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Email",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    appTextFormField(
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
                        prefix: const Icon(Icons.event_note),
                        type: TextInputType.emailAddress),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Password",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    appTextFormField(
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
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Confirm Password",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    appTextFormField(
                      controller: confirmPassword,
                      obsure: cubit.isVisible,
                      label: "Confirm Your Password",
                      suffix: IconButton(
                        icon: Icon(cubit.isVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          cubit.changeVisibility();
                        },
                      ),
                      onSaved: (v) {},
                      validate: (v) {
                        if (v.toString().isEmpty) {
                          return "Password can not be empty";
                        } else if (v.toString().length < 6) {
                          return "Weakly Password";
                        } else if (v.toString() != password.toString()) {
                          return "passwords not matches";
                        } else {}
                      },
                      prefix: const Icon(Icons.ac_unit),
                      type: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    sectionButtonLogin(state, cubit, context),
                    const SizedBox(
                      height: 15,
                    ),
                    sectionSignChosen(context),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget sectionButtonLogin(state, cubit, BuildContext context) {
    return state is AuthenticationLoadingState
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Center(
            child: MaterialButton(
                color: Theme.of(context).buttonColor,
                minWidth: MediaQuery.of(context).size.width - 50,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_formKey.currentState!.validate()) {
                      cubit.userRegister(
                          name: name.text,
                          email: email.text,
                          password: password.text,
                          phone: phoneNumber.text);
                    }
                  }
                },
                child: Text(
                  "REGISTER",
                  style: Theme.of(context).textTheme.headline1,
                )),
          );
  }

  Widget sectionSignChosen(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Have an Account?",
          style: Theme.of(context).textTheme.bodyText2,
        ),
        GestureDetector(
          onTap: () {
            navigateToSignUp(context);
          },
          child: Text(
            "Sign in",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }

  saveIdThenNavigate(BuildContext context, String id) {
    CacheHelper.putData(key: "uId", value: id);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return WeatherScreen();
    }));
  }

  navigateToSignUp(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LogInScreen()));
  }
}
