import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

enum NetworkStatus {
  online,
  offline,
  restored, // Temporary 2-second "Back Online" state
}

class NetworkConnectivityService {
  NetworkConnectivityService({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  Timer? _restoredTimer;

  final ValueNotifier<NetworkStatus> statusNotifier =
      ValueNotifier<NetworkStatus>(NetworkStatus.online);

  final StreamController<void> _networkRestoredController =
      StreamController<void>.broadcast();

  Stream<void> get onNetworkRestored => _networkRestoredController.stream;

  NetworkStatus get currentStatus => statusNotifier.value;

  bool get isOnline => currentStatus != NetworkStatus.offline;

  Future<void> init() async {
    // Check initial connectivity
    try {
      final initialResults = await _connectivity.checkConnectivity();
      final hasConnection = await _evaluateConnectivity(initialResults);
      statusNotifier.value =
          hasConnection ? NetworkStatus.online : NetworkStatus.offline;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking initial network connectivity: $e');
      }
      statusNotifier.value = NetworkStatus.online;
    }

    // Listen for Wi-Fi, mobile, and ethernet interface changes
    _subscription = _connectivity.onConnectivityChanged.listen(_handleConnectivityChanged);
  }

  Future<void> _handleConnectivityChanged(List<ConnectivityResult> results) async {
    final hasConnection = await _evaluateConnectivity(results);

    if (!hasConnection) {
      _restoredTimer?.cancel();
      if (statusNotifier.value != NetworkStatus.offline) {
        statusNotifier.value = NetworkStatus.offline;
      }
    } else {
      // Transitioning from offline to online
      if (statusNotifier.value == NetworkStatus.offline) {
        statusNotifier.value = NetworkStatus.restored;
        _networkRestoredController.add(null);

        // Hide "Back Online" banner automatically after 2 seconds
        _restoredTimer?.cancel();
        _restoredTimer = Timer(const Duration(seconds: 2), () {
          if (statusNotifier.value == NetworkStatus.restored) {
            statusNotifier.value = NetworkStatus.online;
          }
        });
      }
    }
  }

  Future<bool> _evaluateConnectivity(List<ConnectivityResult> results) async {
    // If empty or only contains 'none', device has no network interfaces
    if (results.isEmpty ||
        (results.length == 1 && results.first == ConnectivityResult.none)) {
      return false;
    }

    // If interface is available (wifi, mobile, ethernet, vpn, etc.), verify internet reachability
    return await _hasInternetAccess();
  }

  Future<bool> _hasInternetAccess() async {
    try {
      // Fast DNS lookup to verify active internet reachability
      final lookup = await InternetAddress.lookup('google.com')
          .timeout(const Duration(milliseconds: 2500));
      return lookup.isNotEmpty && lookup[0].rawAddress.isNotEmpty;
    } catch (_) {
      // If DNS lookup fails or times out, consider offline
      return false;
    }
  }

  /// Manually trigger a connectivity check (e.g. for testing or retry)
  Future<bool> checkConnectivity() async {
    try {
      final results = await _connectivity.checkConnectivity();
      final hasConnection = await _evaluateConnectivity(results);
      if (hasConnection && statusNotifier.value == NetworkStatus.offline) {
        statusNotifier.value = NetworkStatus.restored;
        _restoredTimer?.cancel();
        _restoredTimer = Timer(const Duration(seconds: 2), () {
          if (statusNotifier.value == NetworkStatus.restored) {
            statusNotifier.value = NetworkStatus.online;
          }
        });
      } else if (!hasConnection) {
        statusNotifier.value = NetworkStatus.offline;
      }
      return hasConnection;
    } catch (_) {
      return isOnline;
    }
  }

  void dispose() {
    _subscription?.cancel();
    _restoredTimer?.cancel();
    _networkRestoredController.close();
    statusNotifier.dispose();
  }
}
