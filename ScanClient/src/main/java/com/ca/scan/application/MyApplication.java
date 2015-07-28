package com.ca.scan.application;

import android.app.Application;
import android.content.Context;
import com.ca.scan.common.Constants;
import com.ca.scan.dao.DaoMaster;
import com.ca.scan.dao.DaoSession;

/**
 * Created by pandeng on 2015/7/27.
 */
public class MyApplication extends Application {
    private static MyApplication mInstance;
    private static DaoMaster daoMaster;
    private static DaoSession daoSession;

    @Override
    public void onCreate() {
        super.onCreate();
        if(mInstance == null)
            mInstance = this;
    }

    /**
     * ȡ��DaoMaster
     *
     * @param context
     * @return
     */
    public static DaoMaster getDaoMaster(Context context) {
        if (daoMaster == null) {
            DaoMaster.OpenHelper helper = new DaoMaster.DevOpenHelper(context, Constants.DB_NAME, null);
            daoMaster = new DaoMaster(helper.getWritableDatabase());
        }
        return daoMaster;
    }

    /**
     * ȡ��DaoSession
     *
     * @param context
     * @return
     */
    public static DaoSession getDaoSession(Context context) {
        if (daoSession == null) {
            if (daoMaster == null) {
                daoMaster = getDaoMaster(context);
            }
            daoSession = daoMaster.newSession();
        }
        return daoSession;
    }


}
