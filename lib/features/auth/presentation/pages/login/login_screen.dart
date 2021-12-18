import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roaa_weather/core/animation/animation_route.dart';
import 'package:roaa_weather/core/widget/app_dialog.dart';
import 'package:roaa_weather/core/widget/app_text_form_field.dart';
import 'package:roaa_weather/core/shared_pref/shar_pref.dart';
import 'package:roaa_weather/features/auth/presentation/auth_bloc/authentication_state.dart';
import 'package:roaa_weather/features/auth/presentation/pages/register/register_screen.dart';
import 'package:roaa_weather/generated/l10n.dart';
import 'package:roaa_weather/features/weather/presentation/pages/weather_screen.dart';
import 'package:roaa_weather/features/auth/presentation/auth_bloc/authentication_cubit.dart';

import 'login_with_number.dart';

class LogInScreen extends StatefulWidget {
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  // String selectedLang = "en";

   GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthenticationState>(
        listener: (context, state) {
      var cubit = AuthCubit.get(context);

      if (state is AuthenticationErrorState) {
        appDialog(context, state.error);
      }

      if (state is AuthenticationSucceedState) {
        saveIdThenNavigate(context, state.uId, cubit);
      }
    }, builder: (context, state) {
      var cubit = AuthCubit.get(context);
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          elevation: 0,
          leading: Text(""),
          // title: DropdownButton(
          //   value: selectedLang,
          //   onChanged: (value) {
          //     // setState(() {
          //     //   selectedLang = value.toString();
          //     // });
          //     // Get.updateLocale(Locale(selectedLang));
          //   },
          //   items: const [
          //     DropdownMenuItem(
          //       child: Text("en"),
          //       value: "en",
          //     ),
          //     DropdownMenuItem(
          //       child: Text("ar"),
          //       value: "ar",
          //     ),
          //   ],
          // ),
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
                      sectionCheckRemember(cubit, context),
                      sectionButtonLogin(state, cubit, context),
                      sectionSignInWithFaceAndGoogle(cubit, context)
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
            S.of(context).login,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          S.of(context).email,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(
          height: 10,
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
          height: 30,
        ),
        Text(
          S.of(context).password,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(
          height: 10,
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
              S.of(context).Forget_Password,
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

  Widget sectionCheckRemember(cubit, BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: cubit.isRemember,
            onChanged: (v) {
              cubit.isRemembered(v);
            }),
        Text(
          S.of(context).Remember_Me,
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
              S.of(context).LOGIN,
              style: Theme.of(context).textTheme.headline1,
            ));
  }

  Widget sectionSignInWithFaceAndGoogle(cubit, BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          S.of(context).OR,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          S.of(context).Sign_in_with,
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
            ),
            const SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LoginWithPhoneNumberScreen()));
              },
              child: Container(
                height: 40,
                width: 40,
                color: Colors.red,
                child: Icon(
                  Icons.phone,
                  color: Colors.white,
                  size: 30,
                ),
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
          S.of(context).Dont_have_account,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        GestureDetector(
          onTap: () {
            navigateToSignUp(context);
          },
          child: Text(
            S.of(context).Sign_up,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }

  saveIdThenNavigate(BuildContext context, String id, cubit) {
    if (cubit.isRemember) {
      CacheHelper.putData(key: "uId", value: id);
    }
    Navigator.pushReplacement(context, SlidRight(page: WeatherScreen()));
  }

  navigateToSignUp(BuildContext context) {
    Navigator.pushReplacement(context, SlidRight(page: SignUpScreen()));
  }
}
