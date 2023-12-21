package com.hm.flutterapp;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

    private static String CHANNEL = "com.example/my_channel";

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                            // 检查是否是正确的方法调用
                            if (call.method.equals("openNativeScreen")) {
                                openNativeScreen();
                                result.success("Native screen opened");
                            } else {
                                result.notImplemented();
                            }
                        }
                );


    }

    // 定义一个方法来打开原生界面
    private void openNativeScreen() {
        // 这里可以添加打开原生界面的代码
        NativePageActivity.start(this);
    }

}
