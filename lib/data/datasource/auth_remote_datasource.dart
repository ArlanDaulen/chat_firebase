import 'package:chat_firebase/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String email, password);
  Future<UserModel> signUp(String email, password);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  @override
  Future<UserModel> signIn(String email, password) async {
    final user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    _addUserToFirestore(user);

    return _convertToModel(user.user!);
  }

  @override
  Future<void> signOut() async => await _auth.signOut();

  @override
  Future<UserModel> signUp(String email, password) async {
    final user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    user.credential!.token;

    _addUserToFirestore(user);

    return _convertToModel(user.user!);
  }

  void _addUserToFirestore(UserCredential user) {
    _fireStore.collection('users').doc(user.user!.uid).set({
      'email': user.user!.email,
      'uid': user.user!.uid,
    });
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    if (_auth.currentUser == null) return null;

    return _convertToModel(_auth.currentUser!);
  }
}

UserModel _convertToModel(User user) =>
    UserModel.fromJson({'uid': user.uid, 'email': user.email});
