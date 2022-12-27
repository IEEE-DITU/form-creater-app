import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

var snackBarLoginFailed = SnackBar(
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Wrong password !! ',
    message: 'Recheck your password and try again',
    contentType: ContentType.failure,
  ),
);

var snackBarInvalidCredentials = SnackBar(
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Error !! ',
    message: 'Invalid Credentials',
    contentType: ContentType.failure,
  ),
);

var snackBarUserNotFound = SnackBar(
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'User not Found !! ',
    message: 'Check your email or signup again',
    contentType: ContentType.failure,
  ),
);

var snackBarSignupUnsuccessful = SnackBar(
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Error!! ',
    message: 'Please try again later!',
    contentType: ContentType.failure,
  ),
);