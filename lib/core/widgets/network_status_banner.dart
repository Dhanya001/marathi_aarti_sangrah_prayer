import 'package:flutter/material.dart';
import 'package:infocontract/core/di/locator.dart';
import 'package:infocontract/core/services/network/network_connectivity_service.dart';

class NetworkStatusBanner extends StatelessWidget {
  const NetworkStatusBanner({
    super.key,
    required this.child,
    this.connectivityService,
  });

  final Widget child;
  final NetworkConnectivityService? connectivityService;

  @override
  Widget build(BuildContext context) {
    final service = connectivityService ?? locator<NetworkConnectivityService>();

    return Stack(
      children: [
        child,
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: ValueListenableBuilder<NetworkStatus>(
            valueListenable: service.statusNotifier,
            builder: (context, status, _) {
              final isVisible = status != NetworkStatus.online;
              final isRestored = status == NetworkStatus.restored;

              return AnimatedSlide(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                offset: isVisible ? Offset.zero : const Offset(0, -1.2),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 250),
                  opacity: isVisible ? 1.0 : 0.0,
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 4,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isRestored
                                ? const Color(0xFF2E7D32)
                                : const Color(0xFFC62828),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x33000000),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isRestored
                                    ? Icons.wifi_rounded
                                    : Icons.wifi_off_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: isRestored
                                    ? const Text(
                                        'Back Online',
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'No Internet Connection',
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            'Please check your network.',
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFFF0F0F0),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
