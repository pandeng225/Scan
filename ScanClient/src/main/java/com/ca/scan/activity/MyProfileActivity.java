package com.ca.scan.activity;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;
import butterknife.ButterKnife;
import butterknife.InjectView;
import butterknife.InjectViews;
import butterknife.OnClick;
import com.ca.scan.R;
import com.ca.scan.application.MyApplication;
import com.ca.scan.common.ButterKnifeAction;
import com.ca.scan.common.Constants.SubmitProgress;
import com.ca.scan.dao.Profile;
import com.ca.scan.dao.ProfileDao;

import java.util.Date;
import java.util.List;

/**
 * Created by pandeng on 2015/7/27.
 */
public class MyProfileActivity extends Activity {
    Context mContext = MyProfileActivity.this;
    @InjectView(R.id.nameText)
    TextView nameText;
    @InjectView(R.id.nameEdit)
    EditText nameEdit;
    @InjectView(R.id.departmentText)
    TextView departmentText;
    @InjectView(R.id.departmentEdit)
    EditText departmentEdit;
    @InjectView(R.id.employeeidText)
    TextView employeeidText;
    @InjectView(R.id.employeeidEdit)
    EditText employeeidEdit;
    @InjectView(R.id.submit)
    Button submit;
    @InjectView(R.id.edit)
    Button edit;

    @InjectViews({R.id.nameText, R.id.departmentText, R.id.employeeidText})
    List<TextView> textViews;
    @InjectViews({R.id.nameEdit, R.id.departmentEdit, R.id.employeeidEdit})
    List<EditText> editViews;
    Profile profile;
    String submitProgress;
    ProfileDao profileDao;
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.myprofileactivity);
        ButterKnife.inject(this);
        profile = (Profile) this.getIntent().getSerializableExtra("profile");
        if (profile != null) {
            //���ؼ���ֵ
            nameText.setText(profile.getEmployeename());
            departmentText.setText(profile.getDepartment());
            employeeidText.setText(profile.getEmployeeid());
            nameEdit.setText(profile.getEmployeename());
            departmentEdit.setText(profile.getDepartment());
            employeeidEdit.setText(profile.getEmployeeid());
            //���ؼ�չ��
            ButterKnife.apply(textViews, ButterKnifeAction.VISIBLE);
            ButterKnife.apply(editViews, ButterKnifeAction.GONE);
            edit.setVisibility(View.VISIBLE);
            submitProgress= SubmitProgress.Modified.value;
        } else {
            //���ؼ�չ��
            nameEdit.setVisibility(View.VISIBLE);
            departmentEdit.setVisibility(View.VISIBLE);
            employeeidEdit.setVisibility(View.VISIBLE);
            nameText.setVisibility(View.GONE);
            departmentText.setVisibility(View.GONE);
            employeeidText.setVisibility(View.GONE);
            edit.setVisibility(View.INVISIBLE);
            submitProgress= SubmitProgress.Creat.value;
        }
        profileDao=MyApplication.getDaoSession(mContext).getProfileDao();
    }

    @OnClick({R.id.submit,R.id.edit})
    void submitClicked(View view) {
        Intent intent=new Intent();
        intent.setClass(mContext,MainMenuActivity.class);
        if(view.getId()==R.id.edit){
            nameEdit.setText(nameText.getText());
            departmentEdit.setText(departmentText.getText());
            employeeidEdit.setText(employeeidText.getText());
            nameEdit.setVisibility(View.VISIBLE);
            departmentEdit.setVisibility(View.VISIBLE);
            employeeidEdit.setVisibility(View.VISIBLE);
            nameText.setVisibility(View.GONE);
            departmentText.setVisibility(View.GONE);
            employeeidText.setVisibility(View.GONE);
            submitProgress= SubmitProgress.Modify.toString();
            edit.setVisibility(View.INVISIBLE);
        }else if(view.getId()==R.id.submit){
            if(submitProgress.equals(SubmitProgress.Creat.value)){
                Profile newProfile=new Profile();
                newProfile.setEmployeename(nameEdit.getText().toString());
                newProfile.setDepartment(departmentEdit.getText().toString());
                newProfile.setEmployeeid(employeeidEdit.getText().toString());
                newProfile.setDate(new Date());
                if(profileDao.insert(newProfile)>0){
                    mContext.startActivity(intent);
                    MyProfileActivity.this.finish();
                }else{
                    Toast.makeText(mContext,R.string.insert_error,Toast.LENGTH_LONG).show();
                }
            }else if(submitProgress.equals(SubmitProgress.Modify.value)){
                Profile newProfile=new Profile();
                newProfile.setId(profile.getId());
                newProfile.setEmployeename(nameEdit.getText().toString());
                newProfile.setDepartment(departmentEdit.getText().toString());
                newProfile.setEmployeeid(employeeidEdit.getText().toString());
                newProfile.setDate(new Date());
                if(profileDao.insertOrReplace(newProfile)>0){
                    edit.setVisibility(View.VISIBLE);
                    submitProgress= SubmitProgress.Modified.toString();
                    Toast.makeText(mContext,R.string.update_success,Toast.LENGTH_LONG).show();
                }else{
                    Toast.makeText(mContext,R.string.update_error,Toast.LENGTH_LONG).show();
                }
            }else if(submitProgress.equals(SubmitProgress.Modified.value)){
                mContext.startActivity(intent);
                MyProfileActivity.this.finish();
            }

        }

    }
}