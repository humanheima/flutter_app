package com.hm.flutterapp;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "samples.flutter.io/battery";

    private static final String PLATFORM_VIEW_CHANNEL = "samples.flutter.io/platform_view";
    private static final String METHOD_SWITCH_VIEW = "switchView";
    private static final int COUNT_REQUEST = 1;

    private MethodChannel.Result result;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                if (methodCall.method.equals("getBatteryLevel")) {
                    int batteryLevel = getBatteryLevel();

                    if (batteryLevel != -1) {
                        result.success(batteryLevel);
                    } else {
                        result.error("UNAVAILABLE", "Battery level not available.", null);
                    }
                } else {
                    result.notImplemented();
                }
            }
        });

        new MethodChannel(getFlutterView(), PLATFORM_VIEW_CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        MainActivity.this.result = result;
                        int count = methodCall.arguments();
                        if (methodCall.method.equals(METHOD_SWITCH_VIEW)) {
                            onLaunchFullScreen(count);
                        } else {
                            result.notImplemented();
                        }
                    }
                }
        );
    }

    private void onLaunchFullScreen(int count) {
        Intent intent = new Intent(this, CountActivity.class);
        intent.putExtra(CountActivity.EXTRA_COUNTER, count);
        startActivityForResult(intent, COUNT_REQUEST);
    }

    private int getBatteryLevel() {
        int batteryLevel = -1;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        } else {
            Intent intent = new ContextWrapper(getApplicationContext()).
                    registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                    intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }

        return batteryLevel;
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == COUNT_REQUEST) {
            if (resultCode == RESULT_OK) {
                result.success(data.getIntExtra(CountActivity.EXTRA_COUNTER, 0));
            } else {
                result.error("ACTIVITY_FAILURE", "Failed while launching activity", null);
            }
        }

    }
}
