import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roaa_weather/data/shar_pref.dart';
import 'package:roaa_weather/presentation/screens/weather/weather_screen.dart';
import 'package:roaa_weather/presentation/screens/register/register_screen.dart';
import 'package:roaa_weather/presentation/shared/cubit/authentication_cubit.dart';
import 'package:roaa_weather/presentation/shared/cubit/authentication_state.dart';
import 'package:roaa_weather/presentation/widget/app_dialog.dart';
import 'package:roaa_weather/presentation/widget/app_text_form_field.dart';

class LogInScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthenticationState>(
        listener: (context, state) {
      if (state is AuthenticationErrorState) {
        appDialog(context, state.error);
      }

      if (state is AuthenticationSucceedState) {
        saveIdThenNavigate(context, state.uId);
      }
    }, builder: (context, state) {
      var cubit = AuthCubit.get(context);
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
          elevation: 0,
          leading: Text(""),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Column(
                    children: [
                      sectionTextFieldsLogin(context, cubit),
                      sectionCheckRemember(cubit,context),
                      sectionButtonLogin(state, cubit, context),
                      sectionSignInWithFaceAndGoogle(cubit,context)
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  sectionSignChosen(context),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget sectionTextFieldsLogin(BuildContext context, cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "Sign In",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          "Email",
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(
          height: 10,
        ),
        appTextFormField(
            controller: email,
            obsure: false,
            label: "Enter Your Name",
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
          height: 30,
        ),
        Text(
          "Password",
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(
          height: 10,
        ),
        appTextFormField(
          controller: password,
          obsure: cubit.isVisible,
          label: "Enter Your Password",
          onSaved: (v) {},
          validate: (v) {
            if (v.toString().isEmpty) {
              return "Password can not be empty";
            } else if (v.toString().length < 6) {
              return "Not Strong Password";
            } else {}
          },
          prefix: const Icon(Icons.ac_unit),
          suffix: IconButton(
            icon:
                Icon(cubit.isVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              cubit.changeVisibility();
            },
          ),
          type: TextInputType.number,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Spacer(),
            Text(
              "Forget Password",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget sectionCheckRemember(cubit,BuildContext context) {
    return Row(
      children: [
        Checkbox(value: cubit.isRemember, onChanged: (v) {
                    cubit.isRemembered(v);
        }),
        Text(
          "Remember Me",
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }

  Widget sectionButtonLogin(state, cubit, BuildContext context) {
    return state is AuthenticationLoadingState
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : MaterialButton(
            color: Theme.of(context).buttonColor,
            minWidth: MediaQuery.of(context).size.width - 50,
            height: 50,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                cubit.logIn(email: email.text, password: password.text);
              }
            },
            child: Text(
              "LOGIN",
              style: Theme.of(context).textTheme.headline1,
            ));
  }

  Widget sectionSignInWithFaceAndGoogle(cubit,BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          "-OR-",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          "Sign in with",
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {

                cubit.loginWithFacebook();
              },
              child: Image.asset(
                "assets/face.jpg",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                cubit.loginWithGoogle();
              },
              child: Image.asset(
                "assets/google.jpg",
                height: 40,
                width: 40,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget sectionSignChosen(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Dont Have an email?",
          style: Theme.of(context).textTheme.bodyText2,
        ),
        GestureDetector(
          onTap: () {
            navigateToSignUp(context);
          },
          child: Text(
            "Sign up",
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
        context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }
}
