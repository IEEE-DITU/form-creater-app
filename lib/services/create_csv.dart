import 'dart:io';

import 'package:csv/csv.dart';
import 'package:ieee_forms/services/form_data.dart';
import 'package:permission_handler/permission_handler.dart';

class Export {
  Future<bool> generateCSV(FormData currentForm) async {
    bool success = false;

    if(await Permission.manageExternalStorage.request().isGranted) {
      List<List<String>> data = List.generate(currentForm.allResponses.length + 1,
              (index) => List.generate(currentForm.questions.length, (ind) => ''));
      for (int i = 0; i <= currentForm.allResponses.length; i++) {
        for (int j = 0; j < currentForm.questions.length; j++) {
          if (i == 0) {
            data[i][j] = currentForm.questions[j]['questionTitle'];
          } else {
            data[i][j] = currentForm.allResponses[i-1]
            [currentForm.questions[j]['questionId']]
                .toString();
          }
        }
      }

      String csvData = const ListToCsvConverter().convert(data);

      String filePath = createFilePath('csv');

      File csvFile = File(filePath);
      csvFile.writeAsString(csvData);
      success = true;
    }

    return success;
  }

  String createFilePath(String extension) {
    Directory tempDir = Directory('/storage/emulated/0/Download');
    String tempPath = tempDir.path;
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    String path = '$tempPath/$ts.$extension';

    return path;
  }
}
