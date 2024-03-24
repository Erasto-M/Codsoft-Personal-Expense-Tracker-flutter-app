import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:personal_expense_tracker_codsoft/firebase_options.dart';
import 'package:personal_expense_tracker_codsoft/Authentication/Backend/auth.dart';

//Firebase initialization Provider
final initializeFirebaseProvider = FutureProvider(<FirebaseApp>(ref) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return Firebase.app();
});

// Authentication Class provider
final firebaseAuthProvider = Provider<AuthUser>((ref) {
  return AuthUser();
});

// Provider for checking the user authentication state
final userAuthStateProvider = StreamProvider((ref) {
  return ref.read(firebaseAuthProvider).authStateChanges;
});
