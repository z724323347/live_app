package com.mrz.flutter_lottieview

import io.flutter.plugin.common.PluginRegistry.Registrar

class FlutterLottieviewPlugin {
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      registrar.platformViewRegistry().registerViewFactory(
              "native.view_plugin/flutter_lottie",
              LottieViewFactory(registrar)
      );
    }
  }
}
