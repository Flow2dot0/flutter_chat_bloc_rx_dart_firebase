import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_bloc_rxdart/blocs/base.dart';
import 'package:flutter_chat_bloc_rxdart/blocs/bloc_router.dart';
import 'package:flutter_chat_bloc_rxdart/constants.dart';
import 'package:flutter_chat_bloc_rxdart/models/user.dart';
import 'package:flutter_chat_bloc_rxdart/services/firebase.dart';
import 'package:rxdart/rxdart.dart';

class BlocContacts extends BlocBase {
  String id;
  Firebase _firebase;

  BehaviorSubject<User> _subject = BehaviorSubject<User>();
  Stream<User> get stream => _subject.stream;
  Sink<User> get sink => _subject.sink;

  Future<dynamic> goChat(interlocutor, context) =>
      BlocRouter().chat(id: id, interlocutor: interlocutor, context: context);

  BlocContacts({@required this.id}) {
    _firebase = Firebase();
    getUserFromDB();
  }

  Query get queryBaseUser => _firebase.baseUser;

  getUserFromDB() {
    _firebase.getUserData(id).listen((User user) {
      sink.add(user);
    });
  }

  @override
  void dispose() {
    fDisposingBlocOf('Bloc Contacts');
  }
}
