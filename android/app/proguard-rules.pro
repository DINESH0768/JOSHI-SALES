# Flutter Keep Rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.provider.** { *; }

# ML Kit Keep Rules
-keep class com.google.mlkit.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.mlkit.**

# Drift / SQLite Keep Rules
-keep class net.sqlcipher.** { *; }
-keep class org.sqlite.** { *; }

# Firebase Keep Rules
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Audio & Speech Keep Rules
-keep class xyz.luan.audioplayers.** { *; }
-keep class com.solutoin.flutter_tts.** { *; }
-dontwarn xyz.luan.audioplayers.**
-dontwarn com.solutoin.flutter_tts.**

# Camera & Screen Brightness Keep Rules
-keep class io.flutter.plugins.camera.** { *; }
-keep class com.github.linusu.screen_brightness.** { *; }
