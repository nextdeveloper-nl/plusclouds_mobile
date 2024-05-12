import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plusclouds/src/utils/animations/fade_animation.dart';

const placeHolderNetworkProfile = "https://www.corporatephotographerslondon.com/wp-content/uploads/2021/07/LinkedIn_profile_photo_sample_1-300x300.jpg";

const double sizedBoxHeight = 20;
const double appPadding = 16;
const SizedBox sSizedBox = SizedBox(height: 20);
const SizedBox mSizedBox = SizedBox(height: 30);
const SizedBox lSizedBox = SizedBox(height: 40);
const clientId = "d5ac4b2d-797d-4a49-86c2-361b9484b621";
const clientSecret = "1KSSZoVrZRmZ3u5TvoaZOV8AwnG2djyjtqlQVAO2";
const grantType = "otp_email";
const iamTeamAccountId = "461d4eb1-1c18-11ee-b8af-c2ea10853885";
const debugError = "❌";
const debugSuccess = "✅";
const debugRequestSent = "🛜";
const debugResponse = "🧾";
const debugPreferencesWrite = "🖌️";
const debugPreferencesRead = "👓";

///APP SPECIFIC CONSTANTS
const containerRadius = 30.0;
final waitingAnimation = Positioned(
    top: 0,
    bottom: 0,
    left: 0,
    right: 0,
    child: FadeAnimation(duration: const Duration(milliseconds: 2000), child: Lottie.asset('assets/lottie-golf-hit.json')));

final loadingAnimation = Lottie.asset('assets/lottie-golf-hit.json');

final apiSuccessAnimation = Lottie.asset('assets/success.json');

final apiFailAnimation = Lottie.asset('assets/failed.json');

const drawerMainMenuTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey);
