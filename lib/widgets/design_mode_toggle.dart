import 'package:flutter/material.dart';
import 'package:democracy_simulator/generated_l10n/app_localizations.dart';
import 'package:democracy_simulator/services/design_mode.dart';

class DesignModeToggle extends StatefulWidget {
  final DesignModeManager manager;
  final VoidCallback? onModeChanged;

  const DesignModeToggle({
    super.key,
    required this.manager,
    this.onModeChanged,
  });

  @override
  State<DesignModeToggle> createState() => _DesignModeToggleState();
}

class _DesignModeToggleState extends State<DesignModeToggle> {
  late AppMode _currentMode;

  @override
  void initState() {
    super.initState();
    _currentMode = widget.manager.mode;
  }

  void _toggleMode() {
    setState(() {
      widget.manager.toggle();
      _currentMode = widget.manager.mode;
    });
    widget.onModeChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ElevatedButton.icon(
      onPressed: _toggleMode,
      icon: Icon(
        _currentMode == AppMode.play ? Icons.gamepad : Icons.edit,
      ),
      label: Text(
        _currentMode == AppMode.play ? l10n.playMode : l10n.designMode,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: _currentMode == AppMode.play ? Colors.green : Colors.orange,
        foregroundColor: Colors.white,
      ),
    );
  }
}
