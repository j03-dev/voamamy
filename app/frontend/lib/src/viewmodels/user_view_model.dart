import 'package:flutter/foundation.dart';
import 'package:frontend/src/models/user.dart';
import 'package:frontend/src/services/user_service.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _userService;
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;
  DateTime? _lastUserFetched;
  final Duration _userCacheDuraiton = Duration(minutes: 5);

  UserViewModel(this._userService);

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCurrentUser({bool foreRefresh = false}) async {
    if (!foreRefresh &&
        _currentUser != null &&
        _lastUserFetched != null &&
        DateTime.now().difference(_lastUserFetched!) < _userCacheDuraiton) {
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await _userService.me();
      _lastUserFetched = DateTime.now();
    } catch (_) {
      _errorMessage = "Failed to laod user data.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateCurrentUser(
    String? userId,
    String? fullName,
    String? phoneNumber,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _currentUser = await _userService.update(userId, fullName, phoneNumber);
      _lastUserFetched = DateTime.now();
      return true;
    } catch (_) {
      _errorMessage = "Failed to update the user profile.";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearUserData() {
    _currentUser = null;
    _lastUserFetched = null;
    notifyListeners();
  }
}
