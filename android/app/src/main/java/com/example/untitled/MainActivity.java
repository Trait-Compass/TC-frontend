package com.example.untitled;

import android.os.Bundle;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "kakao/map";

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("showKakaoMap")) {
                        // 카카오맵을 초기화하고 표시하는 코드를 작성하세요
                        result.success("Kakao Map displayed");
                    } else {
                        result.notImplemented();
                    }
                }
            );
    }
}
