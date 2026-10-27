import 'package:flutter/material.dart';
import 'package:infocontract/core/services/network/global_error_handler.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';

class ServerDownPage extends StatefulWidget {
  const ServerDownPage({super.key});

  @override
  State<ServerDownPage> createState() => _ServerDownPageState();
}

class _ServerDownPageState extends State<ServerDownPage> {
  bool _isRetrying = false;
  String? _retryErrorMessage;

  Future<void> _handleRetry() async {
    if (_isRetrying) return;

    setState(() {
      _isRetrying = true;
      _retryErrorMessage = null;
    });

    final success = await GlobalErrorHandler.instance.retry();

    if (!mounted) return;

    if (!success) {
      setState(() {
        _isRetrying = false;
        _retryErrorMessage = 'Could not reach server. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          GlobalErrorHandler.instance.dismissServerDown();
        }
      },
      child: Scaffold(
        backgroundColor: AartiColors.background,
        appBar: AppBar(
          backgroundColor: AartiColors.background,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.close_rounded,
              color: AartiColors.textPrimary,
            ),
            onPressed: () {
              Navigator.of(context).maybePop();
            },
          ),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Error Illustration / Icon
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AartiColors.iconBackground,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: AartiColors.shadow,
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.cloud_off_rounded,
                        size: 58,
                        color: AartiColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Title
                  const Text(
                    'Server Temporarily Unavailable',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AartiColors.textPrimary,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Message
                  const Text(
                    "We're having trouble connecting to our server. Please try again.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: AartiColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),

                  if (_retryErrorMessage != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDE8E8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _retryErrorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFD32F2F),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Try Again Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _isRetrying ? null : _handleRetry,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AartiColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shadowColor: AartiColors.shadow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: _isRetrying
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Try Again',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Go Back option
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).maybePop();
                    },
                    child: const Text(
                      'Go Back',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AartiColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
