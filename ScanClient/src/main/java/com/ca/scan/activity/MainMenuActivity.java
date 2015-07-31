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
        intent = new Intent(mContext, CaptureActivity.class);        //CaptureActivity��ɨ���Activity��
        startActivityForResult(intent, 0);

		/*
         *ע��: Ҫ��startActivityForResult����ת��,(�����ײ�android API)
		 *��һ������Ϊһ��Intent����,�����������ݺܶ���ֵ,
		 *�ڶ�������ΪInt�εĶ���,����Ϊ�˷���,û��ʹ�ó���,��ֱ��ʹ����0 ������,�����ó���,��������������˭����*/
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
     * ��ת����Ŀ��ҳ��,�����Ժ�,��ص��������
     * ��һ����������startActivityForResult(intent, 0) �еڶ���int�β���
     * �ڶ�����������CaptureActivity����,setResult(RESULT_OK,intent) �ĵ�һ������,Ҳ����������˭���ò���
     * ��������Intent����,���ݾ����ô˶��������ݵ�
     */
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        Log.d("requestCode",String.valueOf(requestCode));
        if (resultCode == RESULT_OK) {        //�˴�������result������,��˭���ص�����
            Bundle bundle = data.getExtras();
            String scanResult = bundle.getString("result");            //��ͻ�ȡ��ɨ���������
            Toast.makeText(mContext, scanResult+mContext.getString(R.string.upload_success), Toast.LENGTH_LONG).show();
        }
    }
}