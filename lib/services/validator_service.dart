import 'dart:async';

import 'package:rxdart/rxdart.dart';

class ValidatorService {
  BehaviorSubject emailController = BehaviorSubject<String>();
  BehaviorSubject passwordConroller = BehaviorSubject<String>();

  Function(String text) get emailChanged => emailController.sink.add;
  Function(String text) get passwrodChanged => passwordConroller.sink.add;

  Stream<String> get emailStream =>
      emailController.stream.transform(_validateEmail);
  Stream<String> get passwordStream =>
      passwordConroller.stream.transform(_validatePassword);

  final _validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      final emailRegex =
          RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

      if (emailRegex.hasMatch(email)) {
        sink.add(email);
      } else {
        sink.addError('Enter a valid email');
      }
    },
  );

  final _validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if ((password.length > 6)) {
        sink.add(password);
      } else {
        sink.addError('password should be greater than 6');
      }
    },
  );
}
