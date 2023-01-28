import 'package:flutter/material.dart';
import 'package:ieee_forms/services/form_data.dart';
import 'package:readmore/readmore.dart';

import 'image_screen.dart';

class SummaryResponse extends StatefulWidget {
  const SummaryResponse({Key? key, required this.currentForm})
      : super(key: key);
  final FormData currentForm;
  @override
  State<SummaryResponse> createState() => _SummaryResponseState();
}

class _SummaryResponseState extends State<SummaryResponse> {
  @override
  Widget build(BuildContext context) {
    final responses = widget.currentForm.allResponses;
    return ListView.builder(
        itemCount: widget.currentForm.questions.length,
        itemBuilder: (context, index) {
          final currentQuestion = widget.currentForm.questions[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  alignment: Alignment.centerRight,
                  child:
                      Text('${currentQuestion['questionType']} type question'),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                      '${index + 1}).  ${currentQuestion['questionTitle']}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                (currentQuestion['questionType'] == 'text')
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: ListView.builder(
                          shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: responses.length,
                            itemBuilder: (ctx, ind) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 4),
                                child: ReadMoreText(
                                  '${ind + 1} ${responses[ind][currentQuestion['questionId']]}',
                                  trimLines: 2,
                                  trimMode: TrimMode.Line,
                                  trimExpandedText: 'Show less',
                                  trimCollapsedText: 'Show more',
                                ),
                              );
                            }),
                      )
                    : (currentQuestion['questionType'] == 'singleChoice')
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            child: ListView.builder(
                              shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: responses.length,
                                itemBuilder: (ctx, ind) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 4),
                                    child: ReadMoreText(
                                      '${ind + 1} ${responses[ind][currentQuestion['questionId']]}',
                                      trimLines: 2,
                                      trimMode: TrimMode.Line,
                                      trimExpandedText: 'Show less',
                                      trimCollapsedText: 'Show more',
                                    ),
                                  );
                                }),
                          )
                        : (currentQuestion['questionType'] == 'multipleChoice')
                            ? Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),

                                child: ListView.builder(
                                  shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: responses.length,
                                    itemBuilder: (ctx, ind) {
                                      String res = '';
                                      for (int i = 0;
                                          i <
                                              responses[ind][currentQuestion[
                                                      'questionId']]
                                                  .length;
                                          i++) {
                                        res +=
                                            '${responses[ind][currentQuestion['questionId']][i]}, ';
                                      }
                                      res = res.substring(0, res.length - 2);
                                      return Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 4),
                                        child: ReadMoreText(
                                          '${ind + 1} $res',
                                          trimLines: 2,
                                          trimMode: TrimMode.Line,
                                          trimExpandedText: 'Show less',
                                          trimCollapsedText: 'Show more',
                                        ),
                                      );
                                    }),
                              )
                            : Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: responses.length,
                                    itemBuilder: (ctx, ind) {
                                      debugPrint(responses[ind]
                                              [currentQuestion['questionId']]
                                          .toString());
                                      return Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 6),
                                        child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ImageScreen(
                                                            imageUrl: responses[
                                                                    ind][
                                                                currentQuestion[
                                                                    'questionId']],
                                                            responseIndex:
                                                                'Response ${ind + 1}',
                                                          )));
                                            },
                                            child: Text(
                                              'Response ${ind + 1}',
                                              style: const TextStyle(
                                                  color: Colors.indigo),
                                            )),
                                      );
                                    }),
                              )
              ],
            ),
          );
        });
  }
}
