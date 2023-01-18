class FormData {
  String formTitle;
  final String formId;
  final String createdAt;
  final bool acceptingResponses;
  late List questions;
  final List collaborators;
  final String description;
  final String submitDescription;

  static late FormData currentForm;

  FormData({
    required this.formTitle,
    required this.formId,
    required this.createdAt,
    required this.acceptingResponses,
    required this.questions,
    required this.collaborators,
    required this.description,
    required this.submitDescription,
  });
}
