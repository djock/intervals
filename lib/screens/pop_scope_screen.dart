import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:focus/utilities/localizations.dart';

import '../utilities/logger.dart';

class PopScopeScreen extends StatelessWidget {
  final Widget child;

  const PopScopeScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final result = await showOkCancelAlertDialog(
            context: context,
            okLabel: AppLocalizations.close,
            cancelLabel: AppLocalizations.cancel,
            title: AppLocalizations.closeAppTitle,
            message: AppLocalizations.closeAppMessage,
            defaultType: OkCancelAlertDefaultType.cancel,
            isDestructiveAction: true,
          );
          logger.info('Close app result: $result');

          if (result == OkCancelResult.ok) {
            return true;
          } else {
            return false;
          }
        },
        child: child);
  }
}
