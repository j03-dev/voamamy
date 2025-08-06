import 'package:flutter/foundation.dart';
import 'package:frontend/src/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;
  bool _isLoading = false;
  String? _errorMessage;

  AuthViewModel(this._authService);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String? phoneNumber, String? password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _authService.login(phoneNumber, password);
      return true;
    } catch (e) {
      _errorMessage =
          "The phone number or passsord is incorrect, or your phone number is not in the right format.";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register(
    String? phoneNumber,
    String? fullName,
    String? password,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _authService.register(phoneNumber, fullName, password);
      return true;
    } catch (e) {
      _errorMessage = "Make sure all of your information is correct.";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _authService.logout();
    } catch (_) {
      _errorMessage = "Failed to log out.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
