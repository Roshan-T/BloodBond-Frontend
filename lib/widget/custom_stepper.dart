import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
  const CustomStepper({super.key});

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    List<Step> Steps = [
      Step(
        title: Text(
          'Request Accepted',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 17),
        ),
        subtitle: Text("Schedule : 22 June, 2.30 PM"),
        content: Container(),
        isActive: _currentStep >= 0,
        state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text(
          'Donor has reached the destination',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 17),
        ),
        subtitle: Text(""),
        content: Container(),
        isActive: _currentStep >= 1,
        state: _currentStep >= 1 ? StepState.complete : StepState.indexed,
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
    ;
  }
}
