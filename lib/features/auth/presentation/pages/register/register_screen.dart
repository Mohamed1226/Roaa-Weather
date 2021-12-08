import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roaa_weather/core/animation/animation_route.dart';
import 'package:roaa_weather/core/widget/app_dialog.dart';
import 'package:roaa_weather/core/widget/app_text_form_field.dart';
import 'package:roaa_weather/core/shared_pref/shar_pref.dart';
import 'package:roaa_weather/features/auth/presentation/auth_bloc/authentication_state.dart';
import 'package:roaa_weather/features/auth/presentation/pages/login/login_screen.dart';
import 'package:roaa_weather/generated/l10n.dart';
import 'package:roaa_weather/features/weather/presentation/pages/weather_screen.dart';
import 'package:roaa_weather/features/auth/presentation/auth_bloc/authentication_cubit.dart';

class SignUpScreen extends StatelessWidget {
  static final _formKey = GlobalKey<FormState>();
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
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
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
                        S.of(context).Sign_up,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      S.of(context).name,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    appTextFormField(
                        controller: name,
                        obsure: false,
                        label: S.of(context).enter_your_name,
                        onSaved: (v) {},
                        validate: (v) {
                          if (v.toString().isEmpty) {
                            return S.of(context).name_can_not_be_empty;
                          } else {}
                        },
                        prefix: const Icon(Icons.drive_file_rename_outline),
                        type: TextInputType.text),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      S.of(context).phone,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    appTextFormField(
                        controller: phoneNumber,
                        obsure: false,
                        label: S.of(context).enter_your_phone,
                        onSaved: (v) {},
                        validate: (v) {
                          if (v.toString().isEmpty) {
                            return S.of(context).phone_can_not_be_empty;
                          } else {}
                        },
                        prefix: const Icon(Icons.phone),
                        type: TextInputType.number),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      S.of(context).email,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    appTextFormField(
                        controller: email,
                        obsure: false,
                        label: S.of(context).enter_your_email,
                        onSaved: (v) {},
                        validate: (v) {
                          if (v.toString().isEmpty) {
                            return S.of(context).email_can_not_be_empty;
                          } else if (!v.toString().contains("@")) {
                            return S.of(context).Not_Correct_Email;
                          } else {}
                        },
                        prefix: const Icon(Icons.event_note),
                        type: TextInputType.emailAddress),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      S.of(context).password,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    appTextFormField(
                      controller: password,
                      obsure: cubit.isVisible,
                      label: S.of(context).Enter_Your_Password,
                      onSaved: (v) {},
                      validate: (v) {
                        if (v.toString().isEmpty) {
                          return S.of(context).Password_can_not_be_empty;
                        } else if (v.toString().length < 6) {
                          return S.of(context).Not_Strong_Password;
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
                      S.of(context).Confirm_Password,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    appTextFormField(
                      controller: confirmPassword,
                      obsure: cubit.isVisible,
                      label: S.of(context).Confirm_Your_Password,
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
                          return S.of(context).Password_can_not_be_empty;
                        } else if (v.toString().length < 6) {
                          return S.of(context).Not_Strong_Password;
                        } else if (confirmPassword.text != password.text) {
                          return S.of(context).passwords_not_matches;
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
                  S.of(context).REGISTER,
                  style: Theme.of(context).textTheme.headline1,
                )),
          );
  }

  Widget sectionSignChosen(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).have_account,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        GestureDetector(
          onTap: () {
            navigateToSignUp(context);
          },
          child: Text(
            S.of(context).LOGIN,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }

  saveIdThenNavigate(BuildContext context, String id) {
    CacheHelper.putData(key: "uId", value: id);

    Navigator.pushReplacement(context, SlidRight(page: WeatherScreen()));
  }

  navigateToSignUp(BuildContext context) {
    Navigator.pushReplacement(context, SlidRight(page: LogInScreen()));
  }
}
