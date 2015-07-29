package com.ca.scan.activity;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.*;
import butterknife.*;
import com.ca.scan.R;
import com.ca.scan.adapter.HistoryAdapter;
import com.ca.scan.application.MyApplication;
import com.ca.scan.common.ButterKnifeAction;
import com.ca.scan.common.Constants;
import com.ca.scan.dao.DescHistory;
import com.ca.scan.dao.DescHistoryDao;
import com.ca.scan.dao.Profile;

import java.util.List;

/**
 * Created by pandeng on 2015/7/29.
 */
public class HistoryActivity extends Activity {
    Context mContext = HistoryActivity.this;
    @InjectView(R.id.fileNameAdd)
    Button fileNameAdd;
    @InjectView(R.id.desc)
    TextView desc;
    @InjectView(R.id.history)
    ListView history;
    String historyRequestType;
    @InjectViews({R.id.fileNameAdd, R.id.desc})
    List<View> views;
    Profile profile = null;
    DescHistoryDao descHistoryDao;
    List<DescHistory> descHistoryList;
    HistoryAdapter historyAdapter;
    EditText editText;
    AlertDialog alertDialog;
    String newDesc = "";

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.historyactivity);
        editText = (EditText) LayoutInflater.from(mContext).inflate(R.layout.edittext, null);
        ButterKnife.inject(this);


    }

    @Override
    protected void onResume() {
        super.onResume();
        try {
            String HRT = this.getIntent().getStringExtra("historyRequestType");
            if (HRT != null)
                historyRequestType = HRT;
        } catch (Exception e) {
            historyRequestType = Constants.HistoryRequestType.JustHistory.value;
        }
        try {
            profile = (Profile) this.getIntent().getSerializableExtra("profile");
        } catch (Exception e) {
            profile = null;
        }
        if (historyRequestType.equals(Constants.HistoryRequestType.JustHistory.value)) {
            ButterKnife.apply(views, ButterKnifeAction.GONE);
        } else {
            ButterKnife.apply(views, ButterKnifeAction.VISIBLE);
        }
        if (descHistoryDao != null) {
        } else {
            descHistoryDao = MyApplication.getDaoSession(mContext).getDescHistoryDao();
        }
        descHistoryList = descHistoryDao.loadAll();
        historyAdapter = new HistoryAdapter(mContext, descHistoryList, null);
        history.setAdapter(historyAdapter);

    }

    @OnClick(R.id.fileNameAdd)
    public void fileNameAdd() {
        if (alertDialog == null || alertDialog.isShowing()) {
            alertDialog = new AlertDialog.Builder(mContext).create();
            alertDialog.setTitle(mContext.getString(R.string.please_enter));
            alertDialog.setView(editText);
            alertDialog.setButton(AlertDialog.BUTTON_POSITIVE, mContext.getString(R.string.confirm), new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialogInterface, int i) {
                    newDesc = editText.getText().toString();
                    mHandler.obtainMessage(0).sendToTarget();
                    alertDialog.dismiss();
                }
            });
            alertDialog.setButton(AlertDialog.BUTTON_NEGATIVE, mContext.getString(R.string.cancel), new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialogInterface, int i) {
                    alertDialog.dismiss();
                }
            });
        }

        alertDialog.show();

    }


    @OnItemClick(R.id.history)
    public void nextStep(AdapterView<?> adapterView, View view, int i, long l) {
        Intent intent = new Intent(mContext, BatchCaptureActivity.class);
        intent.putExtra("Desc", descHistoryList.get(i).getDesc());
        this.startActivity(intent);
    }

    Handler mHandler = new Handler() {
        public void handleMessage(Message msg) {
            switch (msg.what) {
                case 0:
                    DescHistory descHistory = new DescHistory();
                    descHistory.setDesc(newDesc);
                    descHistory.setEmployeeid(profile.getEmployeeid());
                    descHistory.setDepartment(profile.getDepartment());
                    descHistory.setName(profile.getName());
                    if (descHistoryDao != null) {
                    } else {
                        descHistoryDao = MyApplication.getDaoSession(mContext).getDescHistoryDao();
                    }

                    if (descHistoryDao.insert(descHistory) > 0) {
                        descHistoryList.add(descHistory);
                        historyAdapter.setDescHistory(descHistoryList);
                        history.setAdapter(historyAdapter);
//                        historyAdapter.notifyDataSetChanged();
                    } else {
                        Toast.makeText(mContext, R.string.update_error, Toast.LENGTH_LONG).show();
                    }
                    break;
                default:
                    break;
            }
            super.handleMessage(msg);
        }
    };
}