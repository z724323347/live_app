package com.example.liveapp;

import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.example.liveapp.boost.PageRouter;

import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {

  public static WeakReference<MainActivity> sRef;

  private TextView mOpenNative;
  private TextView mOpenFlutter;
  private TextView mOpenFlutterFragment;

  @Override
  protected void onCreate(@Nullable Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    sRef = new WeakReference<>(this);

    setContentView(R.layout.main_layout);

    mOpenNative = findViewById(R.id.open_native);
    mOpenFlutter = findViewById(R.id.open_flutter);
    mOpenFlutterFragment = findViewById(R.id.open_flutter_fragment);

    mOpenNative.setOnClickListener(this);
    mOpenFlutter.setOnClickListener(this);
    mOpenFlutterFragment.setOnClickListener(this);
  }

  @Override
  protected void onDestroy() {
    super.onDestroy();
    sRef.clear();
    sRef = null;
  }

  @Override
  public void onClick(View v) {
    Map params = new HashMap();
    params.put("test1","v_test1");
    params.put("test2","v_test2");
    //Add some params if needed.
    if (v == mOpenNative) {
      PageRouter.openPageByUrl(this, PageRouter.NATIVE_PAGE_URL , params);
    } else if (v == mOpenFlutter) {
      PageRouter.openPageByUrl(this, PageRouter.FLUTTER_PAGE_URL,params);
    } else if (v == mOpenFlutterFragment) {
      PageRouter.openPageByUrl(this, PageRouter.FLUTTER_FRAGMENT_PAGE_URL,params);
    }
  }
}

//public class MainActivity extends FlutterActivity {
//  @Override
//  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
//    GeneratedPluginRegistrant.registerWith(flutterEngine);
//  }
//}
