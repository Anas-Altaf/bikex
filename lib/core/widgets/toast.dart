// showToast Function
import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast({required String message, required ToastificationType type}) {
  toastification.show(
    title: Text(
      message,
    ),
    autoCloseDuration: const Duration(seconds: 2),
    type:type,
    backgroundColor: AppTheme.backgroundDeepColor,
    foregroundColor: AppTheme.textColor,
    borderSide: const BorderSide(
      color: AppTheme.borderColor01,
      width: 0,
    ),
    boxShadow: null,
    closeOnClick: true,
    dragToClose: true,
    dismissDirection: .up,
  );
}
