import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:roaa_weather/core/animation/animation_route.dart';
import 'package:roaa_weather/core/shared_pref/shar_pref.dart';
import 'package:roaa_weather/core/widget/app_dialog.dart';
import 'package:roaa_weather/features/auth/presentation/auth_bloc/authentication_cubit.dart';
import 'package:roaa_weather/features/auth/presentation/auth_bloc/authentication_state.dart';
import 'package:roaa_weather/features/weather/presentation/pages/weather_screen.dart';
import 'package:roaa_weather/generated/l10n.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({this.phoneNumber});

  final phoneNumber;
  var otpCode;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthenticationState>(
      listener: (context, state) {
        var cubit = AuthCubit.get(context);
        if (state is AuthenticationErrorState) {
          Navigator.pop(context);
          appDialog(context, state.error);
        }

        if (state is AuthenticationSucceedState) {
          saveIdThenNavigate(context, state.uId, cubit);
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          backgroundColor: Theme.of(context).primaryColor,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                      text: S.of(context).verify_phone,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.4),
                      children: <TextSpan>[
                        TextSpan(
                          text: "$phoneNumber",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                buildInCodeFields(context),
                const SizedBox(
                  height: 20,
                ),
                state is AuthenticationLoadingState
                    ? CircularProgressIndicator()
                    : Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            cubit.submitOTP(otpCode);
                          },
                          child: Text(
                            S.of(context).verify,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(110, 50),
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildInCodeFields(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Theme.of(context).primaryColor,
      child: PinCodeTextField(
        length: 6,
        obscureText: false,
        cursorColor: Colors.black,
        autoFocus: true,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
          inactiveColor: Colors.blue,
          inactiveFillColor: Colors.white,
          selectedColor: Colors.blue,
          selectedFillColor: Colors.white,
          activeColor: Colors.blue,
          activeFillColor: Colors.blue,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
        ),
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Theme.of(context).primaryColor,
        enableActiveFill: true,
        keyboardType: TextInputType.number,
        onCompleted: (code) {
          print("Completed");
          otpCode = code;
        },
        onChanged: (value) {
          print(value);
        },
        appContext: context,
      ),
    );
  }

  saveIdThenNavigate(BuildContext context, String id, cubit) {
    if (cubit.isRemember) {
      print("hi");
      print ("id $id");
      CacheHelper.putData(key: "uId", value: id);
    }
    Navigator.pushReplacement(context, SlidRight(page: WeatherScreen()));
  }
}
