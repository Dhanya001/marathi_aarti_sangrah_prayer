import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infocontract/core/di/locator.dart';
import 'package:infocontract/core/services/network/network_connectivity_service.dart';
import 'package:infocontract/core/widgets/server_down_page.dart';

class GlobalErrorHandler {
  GlobalErrorHandler({
    GlobalKey<NavigatorState>? navKey,
    NetworkConnectivityService? connectivityService,
  })  : _navKey = navKey ?? navigatorKey,
        _connectivityService =
            connectivityService ?? locator<NetworkConnectivityService>();

  final GlobalKey<NavigatorState> _navKey;
  final NetworkConnectivityService _connectivityService;

  bool _isServerDownPageVisible = false;
  bool get isServerDownPageVisible => _isServerDownPageVisible;

  Future<bool> Function()? _activeRetryCallback;
  final Set<VoidCallback> _refreshCallbacks = <VoidCallback>{};

  /// Register a callback to refresh current screen data when network/server recovers
  void registerRefreshCallback(VoidCallback callback) {
    _refreshCallbacks.add(callback);
  }

  /// Unregister refresh callback when a screen/cubit is closed
  void unregisterRefreshCallback(VoidCallback callback) {
    _refreshCallbacks.remove(callback);
  }

  /// Triggers registered refresh callbacks across the app
  void triggerScreenRefresh() {
    for (final callback in List<VoidCallback>.from(_refreshCallbacks)) {
      try {
        callback();
      } catch (_) {}
    }
  }

  /// Determines whether a [DioException] indicates a server-down scenario
  bool isServerDownError(DioException error) {
    // 1. If device has no internet connection, it's local network offline, NOT server down
    if (!_connectivityService.isOnline) {
      return false;
    }

    // 2. Explicitly NEVER treat 400, 401, 403, 404 or other 4xx client errors as server down
    final statusCode = error.response?.statusCode;
    if (statusCode != null && statusCode >= 400 && statusCode < 500) {
      return false;
    }

    // 3. HTTP 502 Bad Gateway, 503 Service Unavailable, 504 Gateway Timeout
    if (statusCode == 502 || statusCode == 503 || statusCode == 504) {
      return true;
    }

    // 4. API connection timeouts
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return true;
    }

    // 5. Backend unreachable / connection refused / DNS failure
    if (error.type == DioExceptionType.connectionError) {
      return true;
    }

    return false;
  }

  /// Centralized API error handling
  void handleApiError(
    DioException error, {
    Future<bool> Function()? onRetry,
    bool allowServerDownPage = true,
  }) {
    if (!allowServerDownPage) return;

    if (isServerDownError(error)) {
      showServerDown(onRetry: onRetry);
    }
  }

  /// Displays the full-screen Server Down page if not already visible
  void showServerDown({Future<bool> Function()? onRetry}) {
    if (_isServerDownPageVisible) return;

    // Check device connectivity: if offline, the top network banner handles it
    if (!_connectivityService.isOnline) return;

    final navigatorState = _navKey.currentState;
    if (navigatorState == null) return;

    _isServerDownPageVisible = true;
    _activeRetryCallback = onRetry;

    navigatorState.push<void>(
      MaterialPageRoute(
        builder: (_) => const ServerDownPage(),
        settings: const RouteSettings(name: '/server-down'),
      ),
    ).then((_) {
      _isServerDownPageVisible = false;
      _activeRetryCallback = null;
    });
  }

  /// Retries the failed operation from ServerDownPage
  Future<bool> retry() async {
    if (_activeRetryCallback == null) {
      dismissServerDown();
      triggerScreenRefresh();
      return true;
    }

    try {
      final success = await _activeRetryCallback!();
      if (success) {
        dismissServerDown();
        triggerScreenRefresh();
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  /// Dismisses the Server Down page and returns to the previous screen
  void dismissServerDown() {
    if (!_isServerDownPageVisible) return;
    _isServerDownPageVisible = false;
    _activeRetryCallback = null;

    final navigatorState = _navKey.currentState;
    if (navigatorState != null && navigatorState.canPop()) {
      navigatorState.pop();
    }
  }

  static GlobalErrorHandler get instance => locator<GlobalErrorHandler>();
}
