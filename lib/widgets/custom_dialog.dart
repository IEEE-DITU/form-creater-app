import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:ieee_forms/services/colors.dart';
import 'package:ieee_forms/services/form_data.dart';
import 'package:ieee_forms/widgets/snack_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

Future<void> customDialog(BuildContext context, String title, Widget content,
    AsyncCallback function) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: CustomColors.disabledColor),
                )),
            TextButton(
                onPressed: () {
                  function();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: CustomColors.primaryColor),
                )),
          ],
        );
      });
}

Future<void> qrDialog(BuildContext context) {
  GlobalKey globalKey = GlobalKey();
  String formUrl =
      'https://form-website-seven.vercel.app/form/${FormData.currentForm.formId}';
  final qrValidate = QrValidator.validate(
      data: formUrl,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L);

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Share Form'),
          content: (qrValidate.status == QrValidationStatus.valid)
              ? RepaintBoundary(
                  key: globalKey,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    height: 220,
                    width: 220,
                    child: Align(
                      alignment: Alignment.center,
                      child: QrImage(
                        foregroundColor: Colors.black,
                        data: formUrl,
                        size: 200,
                        version: QrVersions.auto,
                      ),
                    ),
                  ),
                )
              : const Text('Error generating QR code!! Please try again later'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: CustomColors.disabledColor),
                )),
            (qrValidate.status == QrValidationStatus.valid)
                ? TextButton(
                    onPressed: () async {
                      Directory tempDir = await getTemporaryDirectory();
                      String tempPath = tempDir.path;
                      final ts =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      String path = '$tempPath/$ts.png';

                      RenderRepaintBoundary boundary = globalKey.currentContext
                          ?.findRenderObject() as RenderRepaintBoundary;
                      var image = await boundary.toImage();

                      final picData = await image.toByteData(
                          format: ui.ImageByteFormat.png);
                      await writeToFile(picData!, path);

                      final success = await GallerySaver.saveImage(path);

                      //ignore:use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                          defaultSnackBar((success!)
                              ? 'File saved successfully'
                              : 'Error!! Please try again later'));
                      //ignore:use_build_context_synchronously
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Download QR code',
                      style: TextStyle(color: CustomColors.primaryColor),
                    ))
                : const SizedBox(),
            TextButton(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: formUrl));
                  //ignore:use_build_context_synchronously
                  ScaffoldMessenger.of(context)
                      .showSnackBar(snackBarLinkCopied);
                  //ignore:use_build_context_synchronously
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Copy Form link',
                  style: TextStyle(color: CustomColors.primaryColor),
                )),
          ],
        );
      });
}

Future<void> writeToFile(ByteData data, String path) async {
  final buffer = data.buffer;
  await File(path)
      .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}
