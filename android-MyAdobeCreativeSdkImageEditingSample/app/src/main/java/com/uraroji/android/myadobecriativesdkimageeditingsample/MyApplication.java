package com.uraroji.android.myadobecriativesdkimageeditingsample;

import android.app.Application;

import com.adobe.creativesdk.foundation.AdobeCSDKFoundation;
import com.aviary.android.feather.sdk.IAviaryClientCredentials;

public class MyApplication extends Application implements IAviaryClientCredentials {
    @Override
    public void onCreate() {
        super.onCreate();
        AdobeCSDKFoundation.initializeCSDKFoundation(getApplicationContext());
    }

    @Override
    public String getClientID() {
        return "<YOUR CLIENT ID>";
    }

    @Override
    public String getClientSecret() {
        return "<YOUR CLIENT SECRET>";
    }

    @Override
    public String getBillingKey() {
        return "";
    }
}
