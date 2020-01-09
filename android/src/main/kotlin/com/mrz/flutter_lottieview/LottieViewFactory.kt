package com.mrz.flutter_lottieview

import android.content.Context
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class LottieViewFactory(private val mPluginRegistrar: Registrar) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, args: Any): PlatformView {
        return LottieView(context, id, args, mPluginRegistrar)
    }

}
