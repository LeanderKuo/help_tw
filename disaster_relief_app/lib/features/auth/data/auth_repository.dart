import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../services/supabase_service.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(SupabaseService.client);
});

class AuthRepository {
  final SupabaseClient _client;

  AuthRepository(this._client);

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  User? get currentUser => _client.auth.currentUser;

  Future<AuthResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signUp(email: email, password: password);
  }

  Future<void> signInWithOtp({required String phone}) async {
    await _client.auth.signInWithOtp(phone: phone);
  }

  Future<void> verifyOtp({required String phone, required String token}) async {
    await _client.auth.verifyOTP(phone: phone, token: token, type: OtpType.sms);
  }

  Future<bool> signInWithGoogle() async {
    // Force redirect back to current origin on web; keep app deep-link on mobile.
    final redirect = kIsWeb
        ? '${Uri.base.scheme}://${Uri.base.host}${Uri.base.hasPort ? ':${Uri.base.port}' : ''}/'
        : 'tw.help.disasterrelief://login-callback';

    await _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: redirect,
    );
    return true;
  }

  Future<bool> signInWithLine() async {
    // Using generic OAuth provider if 'line' enum is missing,
    // or assuming it will be available.
    // If OAuthProvider.line is missing, we can try to use the string 'line'
    // via a cast or just rely on the fact that we might need to upgrade the package.
    // For now, we will try to use OAuthProvider.line.
    // If it fails to compile, the user needs to upgrade supabase_flutter.

    // return await _client.auth.signInWithOAuth(
    //   OAuthProvider.line,
    //   redirectTo: 'tw.help.disasterrelief://login-callback',
    // );
    throw UnimplementedError('LINE Auth temporarily disabled for build');
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
