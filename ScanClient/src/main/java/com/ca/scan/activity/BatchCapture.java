package com.ca.scan.activity;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Point;
import android.media.AudioManager;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.*;
import android.widget.*;
import android.widget.FrameLayout.LayoutParams;
import butterknife.ButterKnife;
import butterknife.InjectView;
import butterknife.InjectViews;
import butterknife.OnClick;
import com.ca.scan.R;
import com.ca.scan.adapter.HistoryAdapter;
import com.ca.scan.adapter.ScanedAdapter;
import com.ca.scan.application.MyApplication;
import com.ca.scan.common.ButterKnifeAction;
import com.ca.scan.common.Constants;
import com.ca.scan.dao.DescHistory;
import com.ca.scan.dao.DescHistoryDao;
import com.ca.scan.dao.Profile;
import com.google.zxing.Result;

import java.util.*;

/**
 * Created by pandeng on 2015/7/28.
 */
public class BatchCapture extends Capture {
    @InjectView(R.id.showLayout)
    LinearLayout showLayout;
    @InjectView(R.id.scanedList)
    ListView scanedList;
    @InjectView(R.id.startUpload)
    Button startUpload;
    Profile profile=null;
    List<String> scanedStringList;
    ScanedAdapter scanedAdapter;

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.batchcapture);
        ButterKnife.inject(this);
        WindowManager manager = (WindowManager) this.getSystemService(Context.WINDOW_SERVICE);
        DisplayMetrics metrics = new DisplayMetrics();
        manager.getDefaultDisplay().getMetrics(metrics);
        int height = metrics.heightPixels * 3 / 4;
        if (height < Constants.getMinFrameHeight()) {
            height = Constants.getMinFrameHeight();
        } else if (height > Constants.getMaxFrameHeight()) {
            height = Constants.getMaxFrameHeight();
        }
        int topOffset=this.getResources().getDimensionPixelOffset(R.dimen.activity_margin_double);
        int buttonHeight=this.getResources().getDimensionPixelOffset(R.dimen.activity_button_height);
        LayoutParams layoutParams=new LayoutParams(LayoutParams.MATCH_PARENT,metrics.heightPixels-(topOffset*4 + height+buttonHeight));
        layoutParams.gravity= Gravity.BOTTOM;
        layoutParams.setMargins(0,0,0,topOffset/2+buttonHeight);
        showLayout.setLayoutParams(layoutParams);
    }

    @OnClick(R.id.cancelScanButton)
    public void cancelScan(View v) {
        BatchCapture.this.finish();
    }
    @OnClick(R.id.startUpload)
    public void startUpload(View v) {
        Toast.makeText(BatchCapture.this, getString(R.string.upload_success), Toast.LENGTH_LONG).show();
    }
    protected void onResume() {
        super.onResume();
        try{
            profile = (Profile) this.getIntent().getSerializableExtra("profile");
        }catch(Exception e){
            profile=null;
        }
        scanedStringList=new ArrayList<String>() {};
        scanedAdapter=new ScanedAdapter(BatchCapture.this,scanedStringList);
        scanedList.setAdapter(scanedAdapter);
    }
    @Override
    protected void onDestroy() {
        inactivityTimer.shutdown();
        super.onDestroy();
    }

    /**
     * Handler scan result
     *
     * @param result
     * @param barcode
     */
    @Override
    public void handleDecode(Result result, Bitmap barcode) {
        inactivityTimer.onActivity();
        playBeepSoundAndVibrate();
        String resultString = result.getText();
        if (resultString.equals("")) {
            Toast.makeText(BatchCapture.this, R.string.scan_error, Toast.LENGTH_SHORT).show();
        } else {
            scanedStringList.add(resultString);
            scanedList.setAdapter(scanedAdapter);
            scanedAdapter.notifyDataSetChanged();
            Timer timer = new Timer();
            TimerTask task = new TimerTask() {
                @Override
                public void run() {
                    init();
                    if (handler != null)
                        handler.restartPreviewAndDecode();
                }
            };
            timer.schedule(task, 1000 * 3); //3√Î∫Û

        }

    }
}