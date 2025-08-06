import 'package:flutter/material.dart';
import 'package:frontend/src/services/group_service.dart';
import 'package:frontend/src/models/group.dart';

class GroupViewModel extends ChangeNotifier {
  final GroupService _groupService;
  Group? _currentGroup;
  bool _isLoading = false;
  String? _errorMessage;
  DateTime? _lastGroupFetched;
  final Duration _groupCacheDuration = Duration(minutes: 1);

  GroupViewModel(this._groupService);

  Group? get currentGroup => _currentGroup;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchMyGroup({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        _currentGroup != null &&
        _lastGroupFetched != null &&
        DateTime.now().difference(_lastGroupFetched!) < _groupCacheDuration) {
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentGroup = await _groupService.my();
      _lastGroupFetched = DateTime.now();
    } catch (e) {
      _errorMessage =
          "You may not have a group yet, please join or create one!";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createGroup(String? name) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _groupService.create(name);
      await fetchMyGroup(forceRefresh: true);
      return true;
    } catch (e) {
      _errorMessage = "Something went wrong when creating the new group.";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> markAsContributed() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      if (_currentGroup?.id == null) {
        _errorMessage = "No group found to mark contribution.";
        return false;
      }
      _currentGroup = await _groupService.markAsContributed(_currentGroup?.id);
      _lastGroupFetched = DateTime.now();
      return true;
    } catch (e) {
      _errorMessage = "You may have already contributed this week.";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> requestLoan({String? amount, String? state}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _groupService.requestLoan(amount: amount, state: state);
      return true;
    } catch (e) {
      _errorMessage =
          "You have already a loan that is pending or not yet repaid.";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearGroupData() {
    _currentGroup = null;
    _lastGroupFetched = null;
    notifyListeners();
  }
}
