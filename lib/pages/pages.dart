import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Page1 extends StatefulWidget {
  final Function? onSuccess;

  const Page1({Key? key, this.onSuccess}) : super(key: key);

  @override
  Page1State createState() {
    return Page1State();
  }
}

class Page1State extends State<Page1> {
  bool readOnly = false;
  bool autoValidate = true;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            FormBuilder(
              key: _formKey,
              // enabled: false,
              autovalidateMode: AutovalidateMode.disabled,
              initialValue: const {
                'movie_rating': 5,
                'best_language': 'Dart',
                'age': '13',
                'gender': 'Male'
              },
              skipDisabled: true,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 15),
                  FormBuilderSwitch(
                    title: const Text('I Accept the terms and conditions'),
                    name: 'accept_terms_switch',
                    initialValue: false,
                    onChanged: _onChanged,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.equal(true),
                    ]),
                  ),
                  FormBuilderCheckboxGroup<String>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'The language of my people',
                    ),
                    name: 'languages',
                    options: const [
                      FormBuilderFieldOption(value: 'Dart'),
                      FormBuilderFieldOption(value: 'Kotlin'),
                      FormBuilderFieldOption(value: 'Java'),
                      FormBuilderFieldOption(value: 'Swift'),
                      FormBuilderFieldOption(value: 'Objective-C'),
                    ],
                    onChanged: _onChanged,
                    separator: const VerticalDivider(
                      width: 10,
                      thickness: 5,
                      color: Colors.red,
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.minLength(1),
                      FormBuilderValidators.maxLength(3),
                    ]),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        debugPrint(_formKey.currentState?.value.toString());
                        if (widget.onSuccess != null) {
                          widget.onSuccess!();
                        }
                      } else {
                        debugPrint(_formKey.currentState?.value.toString());
                        debugPrint('validation failed');
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _formKey.currentState?.reset();
                    },
                    // color: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SamplePage extends StatelessWidget {
  final int index;
  final Function? onSuccess;

  const SamplePage({Key? key, required this.index, this.onSuccess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text("Page $index"),
        ),
        TextButton(
          onPressed: () {
            if (onSuccess != null) {
              onSuccess!();
            }
          },
          child: const Text("Submit"),
        )
      ],
    );
  }
}
