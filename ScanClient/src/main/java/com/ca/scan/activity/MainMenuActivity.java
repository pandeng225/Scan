package com.ca.scan.activity;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;
import butterknife.ButterKnife;
import butterknife.InjectView;
import butterknife.OnClick;
import com.ca.scan.R;
import com.ca.scan.application.MyApplication;
import com.ca.scan.common.Constants;
import com.ca.scan.dao.Profile;

import java.util.List;

/**
 * Created by pandeng on 2015/7/23.
 */
public class MainMenuActivity extends Activity {
    Context mContext = MainMenuActivity.this;
    Intent intent=new Intent();
    @InjectView(R.id.startScan)
    Button startScan;
    @InjectView(R.id.startBatchScan)
    Button startBatchScan;
    @InjectView(R.id.myProfile)
    Button myProfile;
    @InjectView(R.id.history)
    Button history;
    Profile profile=null;
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.mainmenuactivity);
        ButterKnife.inject(this);
        history.setVisibility(View.GONE);
        List<Profile> profileList= MyApplication.getDaoSession(mContext).getProfileDao().loadAll();
        profile=null;
        if (profileList!=null&&profileList.size()>0){
            profile=profileList.get(0);
        }

    }

    @OnClick(R.id.startScan)
    public void startScan() {
        intent = new Intent(mContext, CaptureActivity.class);        //CaptureActivity是扫描的Activity类
        startActivityForResult(intent, 0);

		/*
         *注意: 要以startActivityForResult方法转跳,(不明白查android API)
		 *第一个参数为一个Intent对象,可以用来传递很多数值,
		 *第二个参数为Int形的对象,这里为了方便,没有使用常量,而直接使用了0 当参数,建议用常量,可以用来区分是谁调用*/
    }

    @OnClick(R.id.startBatchScan)
    public void startBatchScan() {
        intent = new Intent(mContext, HistoryActivity.class);
        intent.putExtra("profile", profile);
        intent.putExtra("historyRequestType", Constants.HistoryRequestType.DescHistory.value);
        startActivity(intent);
    }
    @OnClick(R.id.myProfile)
    public void myProfile() {
        intent=new Intent();
        intent.putExtra("profile",profile);
        intent.setClass(mContext, MyProfileActivity.class);
        startActivity(intent);
    }
    @OnClick(R.id.history)
    public void history() {
        intent = new Intent(mContext, HistoryActivity.class);
        intent.putExtra("profile",profile);
        intent.putExtra("historyRequestType", Constants.HistoryRequestType.ScanHistory.value);
        startActivity(intent);
    }
    /**
     * 当转跳的目标页面,结束以后,会回调这个方法
     * 第一个参数就是startActivityForResult(intent, 0) 中第二个int形参数
     * 第二个参数就是CaptureActivity类中,setResult(RESULT_OK,intent) 的第一个参数,也是用来区分谁调用参数
     * 第三个是Intent对象,数据就是用此对象来传递的
     */
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        Log.d("requestCode",String.valueOf(requestCode));
        if (resultCode == RESULT_OK) {        //此处就是用result来区分,是谁返回的数据
            Bundle bundle = data.getExtras();
            String scanResult = bundle.getString("result");            //这就获取了扫描的内容了
            Toast.makeText(mContext, scanResult+mContext.getString(R.string.upload_success), Toast.LENGTH_LONG).show();
        }
    }
}