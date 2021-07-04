package com.hm.flutterapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.google.android.material.floatingactionbutton.FloatingActionButton;

public class CountActivity extends AppCompatActivity {


    public static final String EXTRA_COUNTER = "counter";
    private int counter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_count);
        counter = getIntent().getIntExtra(EXTRA_COUNTER, 0);
        updateText();

        FloatingActionButton fab = findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                counter++;
                updateText();
            }
        });

        Button switchViewButton = findViewById(R.id.button);
        switchViewButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                returnToFlutterView();
            }
        });
    }

    private void updateText() {
        TextView textView = findViewById(R.id.button_tap);
        String value = "Button tapped " + counter + (counter == 1 ? " time" : " times");
        textView.setText(value);
    }

    private void returnToFlutterView() {
        Intent returnIntent = new Intent();
        returnIntent.putExtra(EXTRA_COUNTER, counter);
        setResult(Activity.RESULT_OK, returnIntent);
        finish();
    }

    public void onBackPressed() {
        returnToFlutterView();
    }
}
