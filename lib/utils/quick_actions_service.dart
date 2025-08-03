import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:my_app/router/route_config.dart';
import 'package:my_app/database/share_preferences_helper.dart';

class QuickActionsService {
  static const QuickActions _quickActions = QuickActions();
  static const String _actionDiscover = 'action_discover';

  // Flag to track if quick action was triggered
  static const String _quickActionFlag = 'quick_action_discover';

  static Future<void> initializeQuickActions(BuildContext context) async {
    try {
      debugPrint('Initializing quick actions...');
      await _quickActions.setShortcutItems([
        const ShortcutItem(
          type: _actionDiscover,
          localizedTitle: 'Keşfet',
          icon: 'discover_icon', // This will be the icon name in Android/iOS
        ),
      ]);
      debugPrint('Quick actions shortcuts set successfully');

      _quickActions.initialize((shortcutType) {
        _handleQuickAction(shortcutType, context);
      });
      debugPrint('Quick actions initialized successfully');
    } catch (e) {
      debugPrint('Quick actions initialization error: $e');
    }
  }

  static void _handleQuickAction(String shortcutType, BuildContext context) {
    debugPrint('Quick action triggered: $shortcutType');
    switch (shortcutType) {
      case _actionDiscover:
        debugPrint('Handling discover quick action');
        _navigateToDiscover(context);
        break;
      default:
        debugPrint('Unknown quick action: $shortcutType');
    }
  }

  static void _navigateToDiscover(BuildContext context) {
    // Set flag to indicate quick action was triggered
    SharedPreferencesHelper.setQuickActionFlag(_quickActionFlag);

    // Navigate to discover page using global navigator key
    try {
      final navigatorKey = AppRouter.navigationKey;
      if (navigatorKey.currentContext != null) {
        navigatorKey.currentContext!.go(AppRouter.discover);
        debugPrint(
          'Navigating to discover page via quick action using global navigator',
        );
      } else {
        debugPrint('Global navigator context is null');
      }
    } catch (e) {
      debugPrint('Error navigating to discover: $e');
    }
  }

  static Future<void> clearQuickActions() async {
    try {
      await _quickActions.clearShortcutItems();
    } catch (e) {
      debugPrint('Error clearing quick actions: $e');
    }
  }

  // Check if quick action was triggered
  static Future<bool> wasQuickActionTriggered() async {
    final flag = await SharedPreferencesHelper.getQuickActionFlag();
    return flag == _quickActionFlag;
  }

  // Clear quick action flag
  static Future<void> clearQuickActionFlag() async {
    await SharedPreferencesHelper.clearQuickActionFlag();
  }
}
