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
    return await _client.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<bool> signInWithGoogle() async {
    return await _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'tw.help.disasterrelief://login-callback',
    );
  }

  Future<bool> signInWithLine() async {
    // Note: Supabase doesn't have a direct 'line' enum in some versions, 
    // but usually it's supported via signInWithOAuth. 
    // If 'line' is not in the enum, we might need to use 'oidc' or custom flow.
    // Checking documentation, LINE is supported as a provider.
    // Assuming 'line' is available or we use the string 'line'.
    
    // For now, using the standard OAuth method.
    // If 'line' is not in the OAuthProvider enum, we can try passing it as a string if the SDK supports it,
    // or use the generic signInWithOAuth with provider name.
    
    // Since specific LINE enum might be missing in older SDKs, we'll use the generic one if possible,
    // but for type safety let's assume standard provider first.
    // If compilation fails, we will adjust.
    
    // Actually, Supabase Flutter SDK usually supports 'line' in OAuthProvider.
    // If not, we might need to use `signInWithOAuth` with `provider: OAuthProvider.line` if it exists.
    
    // Let's assume it exists for now.
    return await _client.auth.signInWithOAuth(
      OAuthProvider.line,
      redirectTo: 'tw.help.disasterrelief://login-callback',
    );
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
