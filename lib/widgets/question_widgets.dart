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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    prefix: Text(
                      '${widget.index + 1}.  '
                    ),
                    border: InputBorder.none
                  ),
                  initialValue: FormData.currentForm.questions[widget.index]['questionTitle'],
                  onChanged: (val) {
                    FormData.currentForm.questions[widget.index]['questionTitle'] = val;
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(child: TextFormField(              )),

            ],
          )
        ],
      ),
    );
  }
}