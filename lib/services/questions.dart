import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class FormQuestions {

    final defaultTextTypeQuestion = {
        "isRequired": false,
        "maxChoice": 50,
        "minChoice": 1,
        "options": ["Option 1"],
        "questionId": uuid.v4(),
        "questionTitle": "Enter Title...",
        "questionType": "text"
    };
}