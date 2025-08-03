package com.sinflix.app

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

import com.microsoft.clarity.Clarity
import com.microsoft.clarity.ClarityConfig
class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val config = ClarityConfig(
            projectId = "sorjsvxn1f",
        )
        Clarity.initialize(applicationContext, config)
    }
}
