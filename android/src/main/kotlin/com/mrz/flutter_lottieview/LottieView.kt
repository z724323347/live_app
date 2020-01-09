package com.mrz.flutter_lottieview

import android.animation.Animator
import android.animation.Animator.AnimatorListener
import android.annotation.SuppressLint
import android.content.Context
import android.util.Log
import android.view.View
import com.airbnb.lottie.LottieAnimationView
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.platform.PlatformView


class LottieView internal constructor(private val mContext: Context, private val mId: Int, private val mArgs: Any, private val mRegistrar: Registrar) : PlatformView, MethodCallHandler {
    private var animationView: LottieAnimationView = LottieAnimationView(mContext)
    private var maxFrame = 0f
    private var channel: MethodChannel? = null
    private var onPlayEvent: EventSink? = null

    @SuppressLint("WrongConstant")
    fun createLottieView(args: java.util.Map<java.lang.String, Any>) {
        channel = MethodChannel(mRegistrar.messenger(), "native.view_plugin/flutter_lottie_" + args["id"])
        channel!!.setMethodCallHandler(this)

        val onPlaybackCompleteEventChannel = EventChannel(mRegistrar.messenger(), "native.view_plugin/flutter_lottie_event_" + args["id"])
        onPlaybackCompleteEventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(o: Any, eventSink: EventSink) {
                onPlayEvent = eventSink
            }

            override fun onCancel(o: Any) {}
        })
        /// play url
        if (args["url"] != null) {
            animationView.setAnimationFromUrl(args["url"].toString())
        }
        /// play filePath
        if (args["filePath"] != null) {
            val assetPath = mRegistrar.lookupKeyForAsset(args["filePath"].toString())
            animationView.setAnimation(assetPath)
        }

        val loop = if (args["loop"] != null) java.lang.Boolean.parseBoolean(args["loop"].toString()) else false
        val reverse = if (args["reverse"] != null) java.lang.Boolean.parseBoolean(args["reverse"].toString()) else false
        val autoPlay = if (args["autoPlay"] != null) java.lang.Boolean.parseBoolean(args["autoPlay"].toString()) else false
        animationView.repeatCount = if (loop) -1 else 0
        maxFrame = animationView.maxFrame
        if (reverse) {
            animationView.repeatMode = 2
        } else {
            animationView.repeatMode = 1
        }
        if (autoPlay) {
            animationView.playAnimation()
        }
        animationView.addAnimatorListener(object : AnimatorListener {
            override fun onAnimationStart(animation: Animator) {}
            override fun onAnimationEnd(animation: Animator) {
                if (onPlayEvent != null) {
                    onPlayEvent!!.success(true)
                }
            }

            override fun onAnimationCancel(animation: Animator) {
                if (onPlayEvent != null) {
                    onPlayEvent!!.success(false)
                }
            }

            override fun onAnimationRepeat(animation: Animator) {}
        })
    }

    override fun getView(): View {
        return animationView
    }

    override fun dispose() {
        animationView.cancelAnimation()
    }

    @SuppressLint("WrongConstant")
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {

        when (call?.method) {
            "play" -> {
                animationView.setMinAndMaxFrame(0, maxFrame.toInt())
                animationView.setMinAndMaxProgress(0f, 1f)
                animationView.playAnimation()
            }

            "resume" -> animationView.resumeAnimation()

            "stop" -> {
                animationView.cancelAnimation()
                animationView.progress = 0.0f
                val mode = animationView.repeatMode
                animationView.repeatMode = 1
                animationView.repeatMode = mode
            }

            "pause" -> animationView.pauseAnimation()

            "reverse" -> {
                val args = call.arguments as Map<String, Any>
                val reverse = if (args["reverse"] != null) java.lang.Boolean.parseBoolean(args["reverse"].toString()) else false
                if (reverse) {
                    animationView.repeatMode = 2
                } else {
                    animationView.repeatMode = 1
                }
            }

            "isPlaying" -> result.success(animationView.isAnimating)

            "setSpeed" -> {
                val args = call.arguments as Map<String, Any>
                animationView.speed = args["speed"].toString().toFloat()
            }

            "setLoop" -> {
                val args = call.arguments as Map<String, Any>
                val loop = if (args["loop"] != null) java.lang.Boolean.parseBoolean(args["loop"].toString()) else false
                animationView.repeatCount = if (loop) -1 else 0
            }

            "setProgress" -> {
                // TODO Make sure its consistant with iOS
                val args = call.arguments as Map<String, Any>
                animationView.pauseAnimation()
                animationView.progress = args["progress"].toString().toFloat()
            }

            "setPlayWithProgress" -> {
                val args = call.arguments as Map<String, Any>
                if (args.containsKey("fromProgress") && args["fromProgress"] != null) {
                    val fromProgress = (args["fromProgress"] as Double?)!!.toFloat()
                    animationView.setMinProgress(fromProgress)
                }
                if (args["toProgress"] != null) {
                    val toProgress = (args["toProgress"] as Double?)!!.toFloat()
                    animationView.setMaxProgress(toProgress)
                }
                animationView.playAnimation()
            }

            "setPlayWithFrames" -> {
                val args = call.arguments as Map<String, Any>
                if (args["fromFrame"] != null) {
                    val fromFrame = args["fromFrame"] as Int
                    animationView.setMinFrame(fromFrame)
                }
                if (args["toFrame"] != null) {
                    val toFrame = args["toFrame"] as Int
                    animationView.setMaxFrame(toFrame)
                }
                animationView.playAnimation()
            }
            "setProgressWithFrame" -> {
                val args = call.arguments as Map<String, Any>
                animationView.frame = args["frame"].toString().toInt()
            }

            // flutter 端暂未使用  -----------------------------------------------------------
            "getDuration" -> result.success(animationView.duration.toDouble())
            "getProgress" -> result.success(animationView.progress.toDouble())
            "getSpeed" -> result.success(animationView.speed.toDouble())
            "getLoop" -> result.success(animationView.repeatCount == -1)
            "getReverse" -> result.success(animationView.repeatMode == 2)

            else -> result.notImplemented()
        }
    }

    init {
        val params = mArgs as java.util.Map<java.lang.String, Any>
//        Log.e("TAG","mArgs  ----- $mArgs")
        createLottieView(params)
    }
}
