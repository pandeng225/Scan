package com.ca.scan.activity;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.FrameLayout.LayoutParams;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.Toast;
import butterknife.ButterKnife;
import butterknife.InjectView;
import butterknife.OnClick;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.Volley;
import com.ca.scan.R;
import com.ca.scan.adapter.HistoryAdapter;
import com.ca.scan.application.MyApplication;
import com.ca.scan.common.Constants;
import com.ca.scan.dao.DescHistory;
import com.ca.scan.dao.Profile;
import com.ca.scan.dao.ScanHistory;
import com.ca.scan.dao.ScanHistoryDao;
import com.ca.scan.dao.ScanHistoryDao.Properties;
import com.ca.scan.network.VolleyRequest;
import com.google.gson.Gson;
import com.google.zxing.Result;
import de.greenrobot.dao.query.QueryBuilder;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.*;

/**
 * Created by pandeng on 2015/7/28.
 */
public class BatchCaptureActivity extends CaptureActivity {
    @InjectView(R.id.showLayout)
    LinearLayout showLayout;
    @InjectView(R.id.scanedList)
    ListView scanedList;
    @InjectView(R.id.upload)
    Button startUpload;
    @InjectView(R.id.export)
    Button export;
    Profile profile = null;
    List<ScanHistory> scanHistories;
    HistoryAdapter historyAdapter;
    String desc;
    QueryBuilder queryBuilder;

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.batchcaptureactivity);
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
        int topOffset = this.getResources().getDimensionPixelOffset(R.dimen.activity_margin_double);
        int buttonHeight = this.getResources().getDimensionPixelOffset(R.dimen.activity_button_height);
        LayoutParams layoutParams = new LayoutParams(LayoutParams.MATCH_PARENT, metrics.heightPixels - (topOffset * 4 + height + buttonHeight));
        layoutParams.gravity = Gravity.BOTTOM;
        layoutParams.setMargins(0, 0, 0, topOffset / 2 + buttonHeight);
        showLayout.setLayoutParams(layoutParams);
    }


    @OnClick(R.id.upload)
    public void startUpload(View v) {
        checkScanHistoryDao();
        QueryBuilder unUploadRecord=scanHistoryDao.queryBuilder();
        unUploadRecord.where(Properties.EmployeeName.eq(profile.getEmployeename()),Properties.Department.eq(profile.getDepartment()), Properties.Desc.eq(desc), Properties.Ifupload.eq("0"));
        temp=unUploadRecord.list();
        if(temp!=null&&temp.size()>0){
            Gson gson=new Gson();
            String recordList=gson.toJson(temp);
            HashMap<String,String> params=new HashMap<>();
            params.put("recordList",recordList);
            params.put("listSize",String.valueOf(temp.size()));
            VolleyRequest.Post(params, Constants.getHttpurl() + "scan/add", mContext, successListener, errorListener);
        }else{
            Toast.makeText(BatchCaptureActivity.this, getString(R.string.upload_success), Toast.LENGTH_LONG).show();

        }
    }
    @OnClick(R.id.cancelScanButton)
    public void cancelScan(View v) {
        super.finish();
    }

    protected void onResume() {
        super.onResume();
        try {
            profile = (Profile) this.getIntent().getSerializableExtra("profile");
        } catch (Exception e) {
            profile = null;
        }

        checkScanHistoryDao();
        desc = this.getIntent().getStringExtra("desc");
        setListView();
    }


    @Override
    protected void onDestroy() {
        inactivityTimer.shutdown();
        alertDialog.dismiss();
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
            Toast.makeText(BatchCaptureActivity.this, R.string.scan_error, Toast.LENGTH_SHORT).show();
        } else {
            ScanHistory scanHistory = new ScanHistory();
            scanHistory.setDesc(desc);
            scanHistory.setEmployeeid(profile.getEmployeeid());
            scanHistory.setDepartment(profile.getDepartment());
            scanHistory.setEmployeename(profile.getEmployeename());
            scanHistory.setExpressno(resultString);
            scanHistory.setDate(new Date());
            if (scanHistoryDao != null) {
            } else {
                scanHistoryDao = MyApplication.getDaoSession(mContext).getScanHistoryDao();
            }

            if (scanHistoryDao.insert(scanHistory) > 0) {
                scanHistories.add(scanHistory);
                historyAdapter.setHistories(scanHistories);
                scanedList.smoothScrollByOffset(this.getResources().getDimensionPixelOffset(R.dimen.activity_list_height)+this.getResources().getDimensionPixelOffset(R.dimen.activity_margin_half));
                Timer timer = new Timer();
                TimerTask task = new TimerTask() {
                    @Override
                    public void run() {
                        init();
                        if (handler != null)
                            handler.restartPreviewAndDecode();
                    }
                };
                timer.schedule(task, 1000 * 2); //3���
            } else {
                Toast.makeText(mContext, R.string.update_error, Toast.LENGTH_LONG).show();
            }


        }

    }
    @Override
    public void updateView() {
        super.updateView();
        setListView();
    }

    protected void setListView(){
        queryBuilder=scanHistoryDao.queryBuilder();
        queryBuilder.where(Properties.EmployeeName.eq(profile.getEmployeename()),Properties.Department.eq(profile.getDepartment()), Properties.Desc.eq(desc));
        scanHistories=queryBuilder.list();
        historyAdapter = new HistoryAdapter(BatchCaptureActivity.this, scanHistories, Constants.HistoryRequestType.ScanHistory.value);
        scanedList.setAdapter(historyAdapter);
    }
}