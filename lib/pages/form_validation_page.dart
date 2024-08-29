import 'package:custom_chart/services/validator_service.dart';
import 'package:flutter/material.dart';

class FormFields extends StatefulWidget {
  const FormFields({super.key});

  @override
  State<FormFields> createState() => _FormFieldsState();
}

class _FormFieldsState extends State<FormFields> {
  final _formStream = ValidatorService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<String>(
              stream: _formStream.emailStream,
              builder: (context, snapshot) {
                return TextField(
                  onChanged: (value) => _formStream.emailChanged(value),
                  decoration: InputDecoration(
                      hintText: "Email", errorText: snapshot.error?.toString()),
                );
              }),
          StreamBuilder<String>(
              stream: _formStream.passwordStream,
              builder: (context, snapshot) {
                return TextField(
                  onChanged: (value) => _formStream.passwrodChanged(value),
                  decoration: InputDecoration(
                      hintText: "Password",
                      errorText: snapshot.error?.toString()),
                );
              }),
        ],
      ),
    );
  }
}
