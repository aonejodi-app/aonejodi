package com.aonejodi.app

import io.flutter.embedding.android.FlutterActivity
import com.razorpay.Checkout

class MainActivity: FlutterActivity() {

    override fun onStart() {
        super.onStart()
        Checkout.preload(applicationContext)
    }
}
