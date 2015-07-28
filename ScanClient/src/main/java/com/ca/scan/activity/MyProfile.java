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
import butterknife.OnClick;
import com.ca.scan.R;
import com.ca.scan.application.MyApplication;
import com.ca.scan.common.Constants;
import com.ca.scan.dao.Profile;
import com.ca.scan.dao.ProfileDao;

import java.util.Date;

/**
 * Created by pandeng on 2015/7/27.
 */
public class MyProfile extends Activity {
    Context mContext = MyProfile.this;
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
    //to-do
//    @InjectViews({R.id.nameText, R.id.departmentText, R.id.employeeidText})
//    List<TextView> textViews;
//    @InjectViews({R.id.nameEdit, R.id.departmentEdit, R.id.employeeidEdit})
//    List<EditText> editViews;
    Profile profile;
    String submitProgress;
    ProfileDao profileDao;
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.myprofile);
        ButterKnife.inject(this);
        profile = (Profile) this.getIntent().getSerializableExtra("profile");
        if (profile != null) {
            //各控件赋值
            nameText.setText(profile.getName());
            departmentText.setText(profile.getDepartment());
            employeeidText.setText(profile.getEmployeeid());
            nameEdit.setText(profile.getName());
            departmentEdit.setText(profile.getDepartment());
            employeeidEdit.setText(profile.getEmployeeid());
            //各控件展现
            nameText.setVisibility(View.VISIBLE);
            departmentText.setVisibility(View.VISIBLE);
            employeeidText.setVisibility(View.VISIBLE);
//            ButterKnife.apply(textViews, Property.);

            nameEdit.setVisibility(View.GONE);
            departmentEdit.setVisibility(View.GONE);
            employeeidEdit.setVisibility(View.GONE);
            edit.setVisibility(View.VISIBLE);
            submitProgress= Constants.SubmitProgress.Modified.value;
        } else {
            //各控件展现
            nameEdit.setVisibility(View.VISIBLE);
            departmentEdit.setVisibility(View.VISIBLE);
            employeeidEdit.setVisibility(View.VISIBLE);
            nameText.setVisibility(View.GONE);
            departmentText.setVisibility(View.GONE);
            employeeidText.setVisibility(View.GONE);
            edit.setVisibility(View.INVISIBLE);
            submitProgress= Constants.SubmitProgress.Creat.value;
        }
        profileDao=MyApplication.getDaoSession(mContext).getProfileDao();
    }

    @OnClick({R.id.submit,R.id.edit})
    void submitClicked(View view) {
        Intent intent=new Intent();
        intent.setClass(mContext,MainMenu.class);
        if(view.getId()==R.id.edit){
            //编辑按钮
            nameEdit.setText(nameText.getText());
            departmentEdit.setText(departmentText.getText());
            employeeidEdit.setText(employeeidText.getText());
            nameEdit.setVisibility(View.VISIBLE);
            departmentEdit.setVisibility(View.VISIBLE);
            employeeidEdit.setVisibility(View.VISIBLE);
            nameText.setVisibility(View.GONE);
            departmentText.setVisibility(View.GONE);
            employeeidText.setVisibility(View.GONE);
            submitProgress= Constants.SubmitProgress.Modify.toString();
            edit.setVisibility(View.INVISIBLE);
        }else if(view.getId()==R.id.submit){
            //完成按钮
            //第一次输入，直接跳入主菜单
            if(submitProgress.equals(Constants.SubmitProgress.Creat.value)){
                Profile newProfile=new Profile();
                newProfile.setName(nameEdit.getText().toString());
                newProfile.setDepartment(departmentEdit.getText().toString());
                newProfile.setEmployeeid(employeeidEdit.getText().toString());
                newProfile.setDate(new Date());
                if(profileDao.insert(newProfile)>0){
                    mContext.startActivity(intent);
                    MyProfile.this.finish();
                }else{
                    Toast.makeText(mContext,R.string.insert_error,Toast.LENGTH_LONG).show();
                }
            }else if(submitProgress.equals(Constants.SubmitProgress.Modify.value)){
                Profile newProfile=new Profile();
                newProfile.setId(profile.getId());
                newProfile.setName(nameEdit.getText().toString());
                newProfile.setDepartment(departmentEdit.getText().toString());
                newProfile.setEmployeeid(employeeidEdit.getText().toString());
                newProfile.setDate(new Date());
                if(profileDao.insertOrReplace(newProfile)>0){
                    edit.setVisibility(View.VISIBLE);
                    submitProgress= Constants.SubmitProgress.Modified.toString();
                    Toast.makeText(mContext,R.string.update_success,Toast.LENGTH_LONG).show();
                }else{
                    Toast.makeText(mContext,R.string.update_error,Toast.LENGTH_LONG).show();
                }
            }else if(submitProgress.equals(Constants.SubmitProgress.Modified.value)){
                mContext.startActivity(intent);
                MyProfile.this.finish();
            }

        }

    }
}