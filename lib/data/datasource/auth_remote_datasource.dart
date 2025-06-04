import 'package:chat_firebase/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<UserModel> signUp(String email, String password);
  Future<void> signOut();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final _auth = FirebaseAuth.instance;

  @override
  Future<UserModel> signIn(String email, String password) async {
    final user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _convertToModel(user);
  }

  @override
  Future<void> signOut() async => await _auth.signOut();

  @override
  Future<UserModel> signUp(String email, String password) async {
    final user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _convertToModel(user);
  }
}

UserModel _convertToModel(UserCredential user) =>
    UserModel.fromJson({'uid': user.user?.uid, 'email': user.user?.email});
