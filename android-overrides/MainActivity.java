package com.calpro.app;

import android.graphics.Color;
import android.os.Build;
import android.os.Bundle;
import androidx.core.view.WindowCompat;
import com.getcapacitor.BridgeActivity;

/**
 * CalPro+ MainActivity — edge-to-edge.
 *
 * Copied over the Capacitor-generated MainActivity during the CI build
 * (see .github/workflows/build-android-debug.yml). Draws the WebView behind
 * the transparent status + navigation bars so the app uses the full screen,
 * while the status bar clock/battery stay visible. The web layout already
 * pads for the bars via CSS env(safe-area-inset-*), so nothing is occluded.
 */
public class MainActivity extends BridgeActivity {
  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    WindowCompat.setDecorFitsSystemWindows(getWindow(), false);
    // Status bar transparent so app content (clock area) shows through at the top.
    getWindow().setStatusBarColor(Color.TRANSPARENT);
    // Navigation bar solid black to match the app background — a transparent nav
    // bar let the device wallpaper bleed through at the bottom on edge-to-edge.
    getWindow().setNavigationBarColor(Color.BLACK);
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
      getWindow().setNavigationBarContrastEnforced(false);
    }
  }
}
