import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
  CustomStepper({super.key, required this.accept, required this.donated});
  bool accept, donated;
  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  var _currentStep = 0;
  var accept;
  var donated;
  void initState() {
    super.initState();
    accept = widget.accept;
    donated = widget.donated;
    if (accept == true && donated == false) {
      _currentStep = 1;
    } else if (accept == true && donated == false) {
      _currentStep = 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Step> Steps = [
      Step(
        title: Text(
          'Request Pending',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 17),
        ),
        content: Container(),
        isActive: _currentStep >= 0,
        state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text(
          'Request Accepted',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 17),
        ),
        content: Container(),
        isActive: _currentStep >= 1,
        state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text(
          'Donor has reached the destination',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 17),
        ),
        subtitle: Text(""),
        content: Container(),
        isActive: _currentStep >= 2,
        state: _currentStep >= 2 ? StepState.complete : StepState.indexed,
      ),
    ];

    return Stepper(
      controlsBuilder: (
        context,
        details,
      ) {
        return SizedBox.shrink();
      },
      currentStep: _currentStep,
      steps: Steps,
      onStepTapped: (int value) {
        setState(() {
          _currentStep = value;

          print(_currentStep);
        });
      },
    );
  }
}
