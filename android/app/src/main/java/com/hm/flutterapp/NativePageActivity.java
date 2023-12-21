package com.hm.flutterapp;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

public class NativePageActivity extends Activity {


    public static void start(Context context) {
        Intent starter = new Intent(context, NativePageActivity.class);
        context.startActivity(starter);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_native_page);
    }
}