package com.hm.flutterapp

import android.app.AlertDialog
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/**
 * Created by p_dmweidu on 2025/11/8
 * Desc: Flutter 与 Android 原生交互示例1
 */
class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example/my_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "openNativeDialog" -> {
                    // 在主线程显示 dialog，并在按钮回调中返回结果给 Dart
                    runOnUiThread {
                        AlertDialog.Builder(this)
                            .setTitle("原生 Dialog")
                            .setMessage("这是来自 Android 原生的 Dialog")
                            .setPositiveButton("确定") { dialog, _ ->
                                dialog.dismiss()
                                result.success("DialogConfirmed")
                            }
                            .setNegativeButton("取消") { dialog, _ ->
                                dialog.dismiss()
                                result.success("DialogCancelled")
                            }
                            .setOnCancelListener {
                                result.success("DialogDismissed")
                            }
                            .show()
                    }
                }
                "openNativeScreen" -> {
                    // 打开项目已有的 NativePageActivity
                    try {
                        NativePageActivity.start(this)
                        result.success("Native screen opened")
                    } catch (e: Exception) {
                        result.error("ERROR", "Failed to open native screen: ${e.message}", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
}

