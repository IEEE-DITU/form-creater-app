import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class FormQuestions {

    static final defaultTextTypeQuestion = {
        "isRequired": false,
        "maxChoice": 1,
        "minChoice": 1,
        "questionId": uuid.v4(),
        "questionTitle": "Enter Title...",
        "questionType": "text"
    };

    static final defaultRadioTypeQuestion = {
        "isRequired": false,
        "maxChoice": 1,
        "minChoice": 1,
        "options": ["Option 1"],
        "questionId": uuid.v4(),
        "questionTitle": "Enter Title...",
        "questionType": "singleChoice"
    };

    static final defaultCheckboxTypeQuestion = {
        "isRequired": false,
        "maxChoice": 1,
        "minChoice": 1,
        "options": ["Option 1"],
        "questionId": uuid.v4(),
        "questionTitle": "Enter Title...",
        "questionType": "multipleChoice"
    };
}