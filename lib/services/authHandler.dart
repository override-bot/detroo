import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class Auth{
   Future<User> signUp(email, password) async {
      assert(password != null);
      final UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      final User user = userCredential.user;
      await user.reload();
      return user;
   }
Future<User> signIn(email, password) async {
  assert(password != null);
  final UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
  final User user = userCredential.user;
  return user;
}
Future signOut() async{
  await auth.signOut();
}
}