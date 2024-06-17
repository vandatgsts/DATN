package com.dat.datn

import io.flutter.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import org.opencv.core.Core

class OpenCVMethodCallHandler : MethodCallHandler {
    companion object {
        private const val TAG = "OpenCVMethodCallHandler"
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("OpenCV " + Core.VERSION)
            }

            "adaptive_threshold" -> {
                val byteData: ByteArray? = call.argument("byteData")
                val blockSize: Int? = call.argument("blockSize")
                val c: Double? = call.argument("CValue")

                Log.d(TAG, "byteData $byteData")
                Log.d(TAG, "blockSize $blockSize")
                Log.d(TAG, "C Value $c")

                val adaptiveThreshold: ByteArray = OpenCVCore.adaptiveThreshold(
                    byteData,
                    blockSize ?: 13,
                    c ?: 5.0,
                )

                result.success(
                    adaptiveThreshold
//                    AppUtils.convertWhiteToTransparent(adaptiveThreshold)
                )
            }

            "process_image" -> {
                val byteData: ByteArray? = call.argument("byteData")
                val threshold1: Double? = call.argument("threshold1")
                val threshold2: Double? = call.argument("threshold2")
                val kernelSize: Double? = call.argument("kernelSize")
                val noise: Double? = call.argument("noise")
                val edgeLevel: Int? = call.argument("edgeLevel")

                val removeBackground: ByteArray = OpenCVCore.processImage(
                    byteData = byteData ?: ByteArray(0),
                    threshold1 = threshold1 ?: 50.0,
                    threshold2 = threshold2 ?: 130.0,
                    kernelSize = kernelSize ?: 3.0,
                    edgeLevel = edgeLevel ?: 4,
                    noise = noise ?: 4.0
                )

                result.success(
                    removeBackground
                )
            }

            else -> result.notImplemented()
        }
    }
}