import 'package:flutter/material.dart';
import 'package:ieee_forms/forms/image_screen.dart';
import 'package:ieee_forms/services/colors.dart';
import 'package:ieee_forms/services/form_data.dart';

class IndividualResponseScreen extends StatefulWidget {
  const IndividualResponseScreen({Key? key, required this.currentForm})
      : super(key: key);
  final FormData currentForm;

  @override
  State<IndividualResponseScreen> createState() =>
      _IndividualResponseScreenState();
}

class _IndividualResponseScreenState extends State<IndividualResponseScreen> {
  int currentlyActive = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.currentForm.allResponses.length,
        itemBuilder: (context, index) {
          return Container(
            key: GlobalKey(),
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: CustomColors.primaryColor,
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '    Response ${index + 1}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            currentlyActive =
                                (currentlyActive == index) ? -1 : index;
                          });
                        },
                        icon: (currentlyActive == index)
                            ? const Icon(Icons.keyboard_arrow_up_outlined)
                            : const Icon(Icons.keyboard_arrow_down_outlined))
                  ],
                ),
                (currentlyActive == index)
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.currentForm.questions.length,
                        itemBuilder: (context, ind) {
                          var currentQuestion =
                              widget.currentForm.questions[ind];
                          var currentResponseIndex =
                              widget.currentForm.allResponses[index];
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${ind + 1}  ${currentQuestion['questionTitle']}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 4),
                                  child: (currentQuestion['questionType'] ==
                                          'attachment')
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => ImageScreen(
                                                        imageUrl:
                                                            currentResponseIndex[
                                                                currentQuestion[
                                                                    'questionId']])));
                                          },
                                          child: const Text('View Attachment'),
                                        )
                                      : Text(currentResponseIndex[
                                              currentQuestion['questionId']]
                                          .toString()),
                                )
                              ],
                            ),
                          );
                        })
                    : const SizedBox(
                        height: 0,
                      )
              ],
            ),
          );
        });
  }
}
