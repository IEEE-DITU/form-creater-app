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

var snackBarInternetError = SnackBar(
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Error !! ',
    message: 'Network Error',
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

var snackBarSavedSuccessfully = SnackBar(
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Success!! ',
    message: 'Form Updated!',
    contentType: ContentType.success,
  ),
);

var snackBarLinkCopied = const SnackBar(
  elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Color(0xFF333333),
    content: Text('Copied to clipboard'));

SnackBar customSnackBar(String title, String message, ContentType type) {
  return SnackBar(
    elevation: 0,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: type,
      ));
}