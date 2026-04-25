enum AppMode { play, design }

class DesignModeManager {
  AppMode _mode = AppMode.play;

  AppMode get mode => _mode;
  bool get isDesignMode => _mode == AppMode.design;
  bool get isPlayMode => _mode == AppMode.play;

  void toggle() {
    _mode = _mode == AppMode.play ? AppMode.design : AppMode.play;
  }

  void setMode(AppMode newMode) {
    _mode = newMode;
  }

  void resetToPlay() {
    _mode = AppMode.play;
  }
}
