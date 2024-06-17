package com.dat.datn

import android.os.Build
import android.os.Bundle
import android.util.Log
import android.window.SplashScreenView
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.opencv.android.OpenCVLoader

class MainActivity : FlutterActivity() {
    private var openCVMethodChannel: MethodChannel? = null

    companion object {
        private const val OPEN_CV = "opencv"
        private const val TAG = "MainActivity"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        // Aligns the Flutter view vertically with the window.
        WindowCompat.setDecorFitsSystemWindows(window, false)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            splashScreen.setOnExitAnimationListener { splashScreenView: SplashScreenView -> splashScreenView.remove() }
        }

        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        if (OpenCVLoader.initLocal()) {
            Log.e(TAG, "Init local success")
        } else {
            Log.e(TAG, "Init local false")
        }
        openCVMethodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, OPEN_CV
        )

        openCVMethodChannel?.setMethodCallHandler(OpenCVMethodCallHandler())





    }

    override fun onDestroy() {
        super.onDestroy()


        openCVMethodChannel?.setMethodCallHandler(null)
        openCVMethodChannel = null

    }
}
