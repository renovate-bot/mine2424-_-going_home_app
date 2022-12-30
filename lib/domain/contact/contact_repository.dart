import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:going_home_app/domain/contact/models/contact.dart';
import 'package:going_home_app/domain/user/models/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final contactRepositoryProvider =
    Provider<ContactRepository>((ref) => ContactRepository());

class ContactRepository {
  static final _db = FirebaseFirestore.instance;

  Future<User> searchContactUser(String uid) async {
    try {
      final doc = await _db.collection(User.colPath).doc(uid).get();
      if (!doc.exists) {
        return const User();
      }

      return User.fromJson(doc.data()!);
    } catch (e) {
      print(e);
      throw Exception('Failed to search contact user.');
    }
  }

  Future<void> addContactUser(User user) async {
    try {
      await _db.doc(User.docPath(user.uid)).set(user.toJson());
    } catch (e) {
      print(e);
      throw Exception('Failed to add contact user.');
    }
  }

  Future<void> removeContactUser(String contactId) async {
    try {
      await _db.doc(Contact.docPath(contactId)).delete();
      // TODO: userのcontactIdsからも削除する
      // TODO: 相手側のユーザーのcontactIdsからも削除する
    } catch (e) {
      print(e);
      throw Exception('Failed to remove contact user.');
    }
  }

  Future<void> updateContact(Contact contact) async {
    try {
      final doc = _db.doc(Contact.docPath(contact.contactId));
      if (!(await doc.get()).exists) {
        throw Exception('Contact does not exist.');
      }

      await doc.set(contact.toJson());
    } catch (e) {
      print(e);
      throw Exception('Failed to update contact word.');
    }
  }

  Future<void> startContactTrace(Contact contact) async {
    try {
      // トレースを開始する

      // TODO: isMatchedをfalseにする
      // TODO: 相手側のユーザーのisMatchedをfalseにする
      // TODO: 終了後、位置情報オフにして、isMatchedをtrueにする

      // これ以下は別の責務
      // TODO: 位置情報オンにする
      // TODO: 最後に位置情報の記録をDBに保存する

      // トレースを終了する

    } catch (e) {
      print(e);
      throw Exception('Failed to start contact.');
    }
  }
}
