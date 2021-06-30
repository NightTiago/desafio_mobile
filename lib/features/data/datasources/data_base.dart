import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_mobile/features/data/models/user_model.dart';
import 'package:desafio_mobile/features/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
final CollectionReference _mainCollection =
    _firestore.collection('User');


class DataBase {

  static Future<void> addItem({required UserModel user}) async {

    DocumentReference documentReference = _mainCollection.doc(user.id).collection('last_locations').doc(user.email);

    Map<String, dynamic> data = user.toJson();

    await documentReference
      .set(data)
      .whenComplete(() => print("Latitude e longitude foram adicionadas"))
      .catchError((e) => FirebaseCrashlytics.instance.log(e.toString()));
  }

}
