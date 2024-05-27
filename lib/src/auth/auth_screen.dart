import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pinput/pinput.dart';
import 'package:plusclouds/api.dart';
import 'package:plusclouds/constants.dart';
import 'package:plusclouds/src/home/home_screen.dart';
import 'package:plusclouds/src/utils/custom_widgets/failed_dialog.dart';
import 'package:plusclouds/src/utils/extension/context_extension.dart';
import 'package:plusclouds/src/utils/preferences/app_storage.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  bool _isVerifying = false;
  bool _isSendingRequest = false;
  String pin = '';
  int _resendCounter = 0;
  String loginMechanismString = "";
  late Timer _resendTimer;
  String? email;

  _loginElevatedButtonPressed() async {
    setState(() {
      _isSendingRequest = true;
    });
    try {
      final getLoginsResponse = await API.auth().oAuthGetLogins(_emailController.text.trim());
      final loginMechanism = jsonDecode(getLoginsResponse)["logins"];
      if (mounted && loginMechanism != null) {
        setState(() {
          _isSendingRequest = false;
        });
        if (loginMechanism.length > 1) {
          await showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    mSizedBox,
                    const Text("Choose a login method", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    mSizedBox,
                    if (loginMechanism.contains("OneTimeEmail"))
                      Column(
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                setState(() {
                                  _isSendingRequest = true;
                                });
                                try {
                                  await _resendVerificationCode(_emailController.text, AppStorage().csrf);
                                  setState(() {
                                    _isSendingRequest = false;
                                  });
                                } catch (e) {
                                  setState(() {
                                    _isSendingRequest = false;
                                  });
                                  rethrow;
                                }

                                setState(() {
                                  email = _emailController.text;
                                  _emailController.clear();
                                  loginMechanismString = "OneTimeEmail";
                                  _isVerifying = true;
                                });
                              },
                              child: const Text("One time email")),
                          mSizedBox,
                        ],
                      ),
                    if (loginMechanism.contains("Password"))
                      Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  email = _emailController.text;
                                  _emailController.clear();
                                  loginMechanismString = "Password";
                                  _isVerifying = true;
                                });
                              },
                              child: const Text("Password")),
                          mSizedBox,
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        } else {
          setState(() {
            _isSendingRequest = true;
          });
          try {
            await _resendVerificationCode(_emailController.text, AppStorage().csrf);
            setState(() {
              _isSendingRequest = false;
            });
          } catch (e) {
            setState(() {
              _isSendingRequest = false;
            });
            rethrow;
          }

          setState(() {
            email = _emailController.text;
            _emailController.clear();
            loginMechanismString = loginMechanism[0];
            _isVerifying = true;
          });
        }
        return;
      }
      final loginError = jsonDecode(getLoginsResponse[0])["error"];
      if (loginError != null && mounted && loginError == "UserNotFound") {
        final getRegisterResponse = await API.auth().oAuthRegisterUser(_emailController.text.trim());
        final registerMechanism = jsonDecode(getRegisterResponse)["logins"];
        setState(() {
          _isSendingRequest = false;
        });
        if (registerMechanism.length > 1 && mounted) {
          await showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    mSizedBox,
                    const Text("Choose a login method", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    mSizedBox,
                    if (loginMechanism.contains("OneTimeEmail"))
                      Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  email = _emailController.text;
                                  _emailController.clear();
                                  loginMechanismString = "OneTimeEmail";
                                  _isVerifying = true;
                                });
                              },
                              child: const Text("One time email")),
                          mSizedBox,
                        ],
                      ),
                    if (loginMechanism.contains("Password"))
                      Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  email = _emailController.text;
                                  _emailController.clear();
                                  loginMechanismString = "Password";
                                  _isVerifying = true;
                                });
                              },
                              child: const Text("Password")),
                          mSizedBox,
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        } else {
          setState(() {
            email = _emailController.text;
            _emailController.clear();
            loginMechanismString = loginMechanism[0];
            _isVerifying = true;
          });
        }
        return;
      }
      throw "Wrong Credentials";
    } catch (error) {
      if (mounted) {
        setState(() {
          _isSendingRequest = false;
        });
        debugPrint("$debugError Rethrowing _loginElevatedButtonPressed() Error ... ${error.toString()}");
      }
    }
  }

  _verifyOneTimeEmailPin() async {
    setState(() {
      _isSendingRequest = true;
    });
    try {
      //TODO: disable for debugging
      //final response = await API.auth().oAuthPasswordToken(email ?? "", _pinController.text, "OneTimeEmail");
      //if (response != null && mounted) {
      setState(() {
        _isSendingRequest = false;
        _isVerifying = false;
      });
      AppStorage().accessToken = "8423ab7b-cc17-4efc-9266-6891fc8a82ff";
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      return;
      // }
      // throw "Wrong Credentials";
    } catch (error) {
      if (mounted && error.runtimeType == DioException) {
        debugPrint("$debugError Rethrowing _verifyOneTimeEmailPin() Error ... ${error.toString()}");
        setState(() {
          _isSendingRequest = false;
        });
        showAPIFailedDialog(context, "Oops", (error as DioException).response!.data.toString());
      } else if (mounted) {
        debugPrint("$debugError Rethrowing _verifyOneTimeEmailPin() Error ... ${error.toString()}");
        setState(() {
          _isSendingRequest = false;
        });
        showAPIFailedDialog(context, "Oops", error.toString());
      }
    }
  }

  _resendVerificationCode(String email, String csrf) async {
    try {
      await API.auth().oAuthResendVerification(email, csrf);
    } catch (error) {
      if (mounted) {
        debugPrint("$debugError Rethrowing _resendVerificationCode Error ... ${error.toString()}");
        setState(() {
          _isSendingRequest = false;
        });
        showAPIFailedDialog(context, "Oops", error.toString());
      }
      return;
    }

    setState(() {
      _resendCounter = 100;
    });
    _startResendTimer();
  }

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _resendTimer.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    const oneSecond = Duration(seconds: 1);
    _resendTimer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_resendCounter > 0) {
          _resendCounter--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(48, 182, 86, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromARGB(255, 28, 171, 95)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 160,
                child: Image.asset(
                  'assets/splash.png',
                  fit: BoxFit.cover,
                ),
              ).animate().shake(duration: const Duration(milliseconds: 4000)),
              lSizedBox,
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 500),
                crossFadeState: _isVerifying ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                firstChild: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    mSizedBox,
                    const Text(
                      "WELCOME",
                      style: TextStyle(fontSize: 20, color: appPrimaryColor, fontWeight: FontWeight.bold),
                    )
                        .animate(delay: const Duration(milliseconds: 2500))
                        .fade(duration: const Duration(milliseconds: 2500), begin: 0, end: 1)
                        .slideY(duration: const Duration(milliseconds: 3000), begin: -2, end: 0.0),
                    const Text(
                      "to",
                      style: TextStyle(fontSize: 25, color: appPrimaryColor),
                    )
                        .animate(delay: const Duration(milliseconds: 2000))
                        .fade(duration: const Duration(milliseconds: 2500), begin: 0, end: 1)
                        .slideY(duration: const Duration(milliseconds: 3000), begin: -3, end: 0.0),
                    const Text(
                      "PLUSCLOUDS",
                      style: TextStyle(fontSize: 30, color: appPrimaryColor, fontWeight: FontWeight.bold),
                    )
                        .animate(delay: const Duration(milliseconds: 1500))
                        .fade(duration: const Duration(milliseconds: 2500), begin: 0, end: 1)
                        .slideY(duration: const Duration(milliseconds: 3000), begin: -4, end: 0.0),
                    mSizedBox,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    )
                        .animate(delay: const Duration(milliseconds: 1000))
                        .fade(duration: const Duration(milliseconds: 2500), begin: 0, end: 1)
                        .slideY(duration: const Duration(milliseconds: 3000), begin: -5, end: 0.0),
                    lSizedBox,
                    ElevatedButton(
                      onPressed: () {
                        if (_emailController.text.isEmpty) {
                          return;
                        } else {
                          _loginElevatedButtonPressed();
                        }
                      },
                      child: const Text('Continue', textAlign: TextAlign.start),
                    )
                        .animate(delay: const Duration(milliseconds: 500))
                        .fade(duration: const Duration(milliseconds: 2500), begin: 0, end: 1)
                        .slideY(duration: const Duration(milliseconds: 3000), begin: -6, end: 0.0)
                        .then()
                        .animate(target: _isSendingRequest ? 0.0 : 1.0)
                        .flip(),
                    lSizedBox,
                  ],
                ),
                secondChild: loginMechanismString == "OneTimeEmail"
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          lSizedBox,
                          const Text(
                            "WELCOME",
                            textAlign: TextAlign.center,
                          ),
                          mSizedBox,
                          Text(
                            "Enter the 6-digit code sent to your email: $email",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          lSizedBox,
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40),
                              child: Pinput(
                                controller: _pinController,
                                defaultPinTheme: defaultPinTheme,
                                focusedPinTheme: focusedPinTheme,
                                submittedPinTheme: submittedPinTheme,
                                length: 6,
                                showCursor: true,
                                onChanged: (value) {
                                  setState(() {
                                    pin = value;
                                  });
                                  if (value.length == 6) {
                                    _verifyOneTimeEmailPin();
                                  }
                                },
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40.0),
                            child: AnimatedCrossFade(
                              duration: const Duration(milliseconds: 500),
                              crossFadeState: _resendCounter == 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                              firstChild: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () async {
                                        try {
                                          await _resendVerificationCode(email ?? "", AppStorage().csrf);
                                        } catch (error) {
                                          if (mounted) {
                                            setState(() {
                                              _isSendingRequest = false;
                                            });
                                            debugPrint("$debugError Rethrowing Resend Verification Code Error ... ${error.toString()}");
                                          }
                                        }
                                      },
                                      child: const Text("Resend Verification Code")),
                                ],
                              ),
                              secondChild: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                                    child: Text(
                                      '${context.l10n.screenVerificationRemainingTimeText} $_resendCounter',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          sSizedBox,
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _isVerifying = false;
                                  _pinController.clear();
                                });
                              },
                              child: const Text("Back to Login")),
                          sSizedBox,
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          lSizedBox,
                          const Text(
                            "WELCOME",
                            textAlign: TextAlign.center,
                          ),
                          lSizedBox,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: "Password",
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          ),
                          lSizedBox,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    _isSendingRequest = true;
                                  });
                                  try {
                                    final response = await API.auth().oAuthPasswordToken(email ?? "", _passwordController.text, "Password");
                                    if (response != null && mounted) {
                                      setState(() {
                                        _isSendingRequest = false;
                                        _isVerifying = false;
                                      });
                                      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                                      return;
                                    }
                                  } catch (e) {
                                    debugPrint("$debugError Rethrowing _loginElevatedButtonPressed() for Password Error ... ${e.toString()}");
                                    setState(() {
                                      _isSendingRequest = false;
                                    });
                                    if (mounted) {
                                      showAPIFailedDialog(context, "Oops", e.toString());
                                    }
                                  }
                                },
                                child: const Text('Continue', textAlign: TextAlign.start)),
                          ),
                          lSizedBox,
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _isVerifying = false;
                                });
                              },
                              child: const Text("Back to Login")),
                          sSizedBox,
                        ],
                      ),
              )
            ],
          ),
        );
      }),
    );
  }
}
