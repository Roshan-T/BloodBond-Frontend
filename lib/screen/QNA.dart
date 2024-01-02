import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QNA extends StatefulWidget {
  const QNA({super.key});

  @override
  State<QNA> createState() => _QNAState();
}

class _QNAState extends State<QNA> {
  bool? agreementChecked;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Questionarries",
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          backgroundColor: Constants.kWhiteColor,
          elevation: 0,
        ),
        body: Column(
          children: [
           const SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 16, 10),
              child: Text(
                "Fill up the following questionarries and become the donor",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontSize: 16),
              ),
            ),

            //   SizedBox(height: 20,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.separated(
                  itemCount: ListQuestion.length,
                  itemBuilder: (context, index) {
                    return QuestionTile(
                      quest: ListQuestion[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                ),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: agreementChecked,
                  tristate: true,
                  onChanged: (value) {
                    setState(() {
                      agreementChecked = value ?? false;
                    });
                  },
                ),
                Text(
                  'I agree to the terms and conditions',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontSize: 16),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            SizedBox(
              width: Get.width * 0.9,
              height: 60,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Continue",
                  style:
                      Get.textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
              ),
            ),
          const  SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionTile extends StatefulWidget {
  final Questions quest;

  const QuestionTile({super.key, required this.quest});

  @override
  State<QuestionTile> createState() => _QuestionTileState();
}

class _QuestionTileState extends State<QuestionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.black),
        borderRadius:const  BorderRadius.all(Radius.circular(15)),
      ),
      child: ListTile(
        title: Text(widget.quest.question),
        subtitle: Row(children: [
          Radio<bool>(
            value: true,
            groupValue: widget.quest.result,
            onChanged: (value) {
              setState(() {
                widget.quest.result = value;
              });
            },
          ),
          Text(
            'Yes',
            style:
                Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 18),
          ),
       const   SizedBox(width: 16),
          Radio<bool>(
            value: false,
            groupValue: widget.quest.result,
            onChanged: (value) {
              setState(() {
                widget.quest.result = value;
              });
            },
          ),
          Text(
            'No',
            style:
                Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 18),
          ),
    const      SizedBox(width: 16),
        ]),
      ),
    );
  }
}
