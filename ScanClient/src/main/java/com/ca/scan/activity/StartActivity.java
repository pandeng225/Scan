package com.ca.scan.activity;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import com.ca.scan.R;
import com.ca.scan.application.MyApplication;
import com.ca.scan.dao.Profile;

import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

/**
 * Created by pandeng on 2015/7/23.
 */
public class StartActivity extends Activity {
    Context mContext =StartActivity.this;
    Intent intent=new Intent();
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.startactivity);
        List<Profile> profileList=MyApplication.getDaoSession(mContext).getProfileDao().loadAll();
        Profile profile=null;
        if (profileList!=null&&profileList.size()>0){
            intent=new Intent();
            intent.setClass(mContext, MainMenuActivity.class);
            profile=profileList.get(0);
            intent.putExtra("profile",profile);
        }else{
            intent=new Intent();
            intent.setClass(mContext, MyProfileActivity.class);
            intent.putExtra("profile",profile);
        }
        Timer timer = new Timer();
        TimerTask task = new TimerTask() {
            @Override
            public void run() {
                startActivity(intent); //÷¥––
                StartActivity.this.finish();
            }
        };
        timer.schedule(task, 1000 * 3); //3√Î∫Û
    }
}