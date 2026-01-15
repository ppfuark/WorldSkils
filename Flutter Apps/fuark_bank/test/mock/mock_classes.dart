import 'package:fuark_bank/services/auth/auth_service.dart';
import 'package:fuark_bank/services/secure_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuthService extends Mock implements AuthService {}

class MockSecureStorage extends Mock implements SecureStorage {}
