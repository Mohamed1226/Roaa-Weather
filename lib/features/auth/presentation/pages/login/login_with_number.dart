import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roaa_weather/features/auth/presentation/auth_bloc/authentication_cubit.dart';
import 'package:roaa_weather/features/auth/presentation/auth_bloc/authentication_state.dart';
import 'package:roaa_weather/features/auth/presentation/pages/login/code_of_number.dart';
import 'package:roaa_weather/generated/l10n.dart';

class LoginWithPhoneNumberScreen extends StatelessWidget {
  late String phoneNumber;
  GlobalKey<FormState> phoneKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is PhoneNumberSubmitted) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => OtpScreen(
                    phoneNumber: phoneNumber,
                  )));
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
            body: Form(
              key: phoneKey,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).Please_Input_Your_Phone_Number,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                generateFlag() + '     +20',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextFormField(
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your phone number!';
                                } else if (value.length < 11) {
                                  return 'Too short for a phone number!';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                phoneNumber = value!;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    state is AuthenticationLoadingState
                        ? CircularProgressIndicator()
                        : Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {
                                if (phoneKey.currentState!.validate()) {
                                  phoneKey.currentState!.save();
                                  cubit.submitPhoneNumber(phoneNumber);
                                }
                              },
                              child: Text(
                                S.of(context).next,
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
            ));
      },
    );
  }

  String generateFlag() {
    String countryCode = 'eg';

    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flag;
  }
}
