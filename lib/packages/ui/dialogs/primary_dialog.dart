import 'package:flutter/material.dart';

class PrimaryDialog extends StatelessWidget {
  final Widget? body;
  final Widget? title;
  final List<Widget>? actions;
  final bool barrierDismissible;
  final Widget? customChild;
  final EdgeInsets? outerPadding;
  const PrimaryDialog({
    super.key,
    this.body,
    this.title,
    this.actions,
    this.barrierDismissible = true,
    this.customChild,
    this.outerPadding,
  });

  Future<bool?> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:
          outerPadding ?? const EdgeInsets.symmetric(horizontal: 55.0),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      child:
          customChild ??
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: title!,
                ),
              if (body != null)
                Padding(padding: const EdgeInsets.all(16.0), child: body!),
              if (actions != null)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                    right: 16,
                    left: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions!,
                  ),
                ),
            ],
          ),
    );
  }
}
