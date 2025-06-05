import 'package:chat_firebase/data/models/user_model.dart';
import 'package:chat_firebase/firebase_messaging_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<UserModel> signUp(String email, String password);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _fireStore;
  final FirebaseMessagingService _fcmService;

  AuthRemoteDataSourceImpl({
    FirebaseAuth? auth,
    FirebaseFirestore? fireStore,
    FirebaseMessagingService? fcmService,
  }) : _auth = auth ?? FirebaseAuth.instance,
       _fireStore = fireStore ?? FirebaseFirestore.instance,
       _fcmService = fcmService ?? FirebaseMessagingService();

  @override
  Future<UserModel> signIn(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final fcmToken = await _fcmService.getToken();
    final userModel = _convertToModel(userCredential.user!, fcmToken);
    await _addUserToFirestore(userModel);
    return userModel;
  }

  @override
  Future<UserModel> signUp(String email, String password) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final fcmToken = await _fcmService.getToken();
    final userModel = _convertToModel(userCredential.user!, fcmToken);
    await _addUserToFirestore(userModel);
    return userModel;
  }

  @override
  Future<void> signOut() async => _auth.signOut();

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    final fcmToken = await _fcmService.getToken();
    return _convertToModel(user, fcmToken);
  }

  Future<void> _addUserToFirestore(UserModel user) {
    return _fireStore.collection('users').doc(user.id).set(user.toJson());
  }

  UserModel _convertToModel(User user, [String? fcmToken]) =>
      UserModel.fromJson({
        'uid': user.uid,
        'email': user.email,
        'fcm_token': fcmToken ?? '',
      });
}
