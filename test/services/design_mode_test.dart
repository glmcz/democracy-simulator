import 'package:flutter_test/flutter_test.dart';
import 'package:democracy_simulator/services/design_mode.dart';

void main() {
  group('DesignModeManager', () {
    late DesignModeManager manager;

    setUp(() {
      manager = DesignModeManager();
    });

    test('starts in play mode', () {
      expect(manager.isPlayMode, true);
      expect(manager.isDesignMode, false);
      expect(manager.mode, AppMode.play);
    });

    test('toggle switches between modes', () {
      expect(manager.mode, AppMode.play);

      manager.toggle();
      expect(manager.mode, AppMode.design);
      expect(manager.isDesignMode, true);
      expect(manager.isPlayMode, false);

      manager.toggle();
      expect(manager.mode, AppMode.play);
      expect(manager.isPlayMode, true);
      expect(manager.isDesignMode, false);
    });

    test('setMode sets explicit mode', () {
      manager.setMode(AppMode.design);
      expect(manager.mode, AppMode.design);

      manager.setMode(AppMode.play);
      expect(manager.mode, AppMode.play);
    });

    test('resetToPlay returns to play mode', () {
      manager.setMode(AppMode.design);
      expect(manager.mode, AppMode.design);

      manager.resetToPlay();
      expect(manager.mode, AppMode.play);
    });

    test('multiple toggles work correctly', () {
      final modes = [];
      for (int i = 0; i < 5; i++) {
        modes.add(manager.mode);
        manager.toggle();
      }

      expect(modes, [
        AppMode.play,
        AppMode.design,
        AppMode.play,
        AppMode.design,
        AppMode.play,
      ]);
    });
  });
}
