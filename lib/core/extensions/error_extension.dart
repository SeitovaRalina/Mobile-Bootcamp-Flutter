import 'package:flutter/material.dart';

import '../error/failures.dart';
import 'context_extension.dart';

extension FailureX on Failure {
  String toMessage(BuildContext context) {
    if (this is NetworkFailure) return context.l10n.errorNetwork;
    if (this is ServerFailure) return message ?? context.l10n.errorServer;
    if (this is CacheFailure) return context.l10n.errorCache;
    return context.l10n.errorUnknown;
  }
}
