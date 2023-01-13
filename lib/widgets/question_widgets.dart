import 'package:flutter/material.dart';
import 'package:ieee_forms/services/form_data.dart';

class TextTypeQuestion extends StatefulWidget {
  const TextTypeQuestion({required this.index, super.key});

  final int index;

  @override
  State<TextTypeQuestion> createState() => _TextTypeQuestionState();
}

class _TextTypeQuestionState extends State<TextTypeQuestion> {
  @override
  Widget build(BuildContext context) {
    debugPrint("Building");
    debugPrint(FormData.currentForm.questions[widget.index].toString());
    return SizedBox(
      width: 175,
      child: TextFormField(
        decoration: const InputDecoration(
            prefix: Text('Word Limit: '),
            suffix: Text('Words'),
            border: InputBorder.none),
        keyboardType: TextInputType.number,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == '' || int.parse(value!) == 0) {
            return 'Word Limit cannot be Empty';
          }
          return null;
        },
        initialValue: FormData.currentForm.questions[widget.index]['maxChoice']
            .toString(),
        onChanged: (value) {
          if (value != '') {
            FormData.currentForm.questions[widget.index]['maxChoice'] =
                int.parse(value);
          }
        },
      ),
    );
  }
}

class ChoiceTypeQuestion extends StatefulWidget {
  const ChoiceTypeQuestion({Key? key, required this.index, required this.type})
      : super(key: key);

  final int index;
  final String type;

  @override
  State<ChoiceTypeQuestion> createState() => _ChoiceTypeQuestionState();
}

class _ChoiceTypeQuestionState extends State<ChoiceTypeQuestion> {
  @override
  Widget build(BuildContext context) {
    final currentQuestionOptions =
        FormData.currentForm.questions[widget.index]['options'];
    return SizedBox(
      height: currentQuestionOptions.length * 70.0 + 60,
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
          itemCount: currentQuestionOptions.length,
          itemBuilder: (context, ind) {
          FocusNode focus = FocusNode();
          focus.addListener(() {
            if(focus.hasFocus == false && currentQuestionOptions[ind] == '') {
              setState(() {
                currentQuestionOptions.removeAt(ind);
              });
            }
          });
            return Column(
              children: [
                TextFormField(
                    key: GlobalKey(),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefix: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 8.0),
                          child: Icon(
                            (widget.type == 'single')
                                ? Icons.circle_outlined
                                : Icons.check_box_outlined,
                            size: 16,
                          ),
                        ),
                        errorStyle: const TextStyle(color: Colors.red)),
                    onChanged: (value) {
                      currentQuestionOptions[ind] = value;
                      debugPrint(focus.hasFocus.toString());
                    },
                    focusNode: focus,
                    onEditingComplete: () {
                      if(currentQuestionOptions[ind] == '') {
                        setState(() {
                          currentQuestionOptions.removeAt(ind);
                        });
                      }
                    },
                    initialValue: currentQuestionOptions[ind]),
                (ind == currentQuestionOptions.length - 1)
                    ? Container(
                        margin: const EdgeInsets.only(
                            top: 10, bottom: 20, left: 16, right: 150),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                minimumSize: const Size.fromHeight(30)),
                            child: const Text('Add new Option'),
                            onPressed: () {
                              setState(() {
                                currentQuestionOptions.add('New Option');
                              });
                            }))
                    : const SizedBox(),
              ],
            );
          }),
    );
  }
}
