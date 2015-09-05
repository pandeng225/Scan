package com.ca.scan.activity;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.res.AssetFileDescriptor;
import android.graphics.Bitmap;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.media.MediaPlayer.OnCompletionListener;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.Vibrator;
import android.util.Log;
import android.view.SurfaceHolder;
import android.view.SurfaceHolder.Callback;
import android.view.SurfaceView;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;
import butterknife.ButterKnife;
import butterknife.InjectView;
import butterknife.OnClick;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.ca.scan.R;
import com.ca.scan.adapter.HistoryAdapter;
import com.ca.scan.application.MyApplication;
import com.ca.scan.common.Constants;
import com.ca.scan.dao.Profile;
import com.ca.scan.dao.ScanHistory;
import com.ca.scan.dao.ScanHistoryDao;
import com.ca.scan.network.VolleyRequest;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.Result;
import com.zxing.camera.CameraManager;
import com.zxing.decoding.CaptureActivityHandler;
import com.zxing.decoding.InactivityTimer;
import com.zxing.view.ViewfinderView;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.*;

/**
 * Initial the camera
 *
 * @author Ryan.Tang
 */
public class CaptureActivity extends Activity implements Callback {
    protected Context mContext=CaptureActivity.this;
    protected CaptureActivityHandler handler;
    protected ViewfinderView viewfinderView;
    protected boolean hasSurface;
    protected Vector<BarcodeFormat> decodeFormats;
    protected String characterSet;
    protected InactivityTimer inactivityTimer;
    protected MediaPlayer mediaPlayer;
    protected boolean playBeep;
    protected static final float BEEP_VOLUME = 0.10f;
    protected boolean vibrate;
    @InjectView(R.id.cancelScanButton)
    public Button cancelScanButton;
    String TAG="CaptureActivity";
    AlertDialog alertDialog;
    ScanHistoryDao scanHistoryDao;
    Profile profile;
    List<ScanHistory> temp=new ArrayList<>();
    /**
     * Called when the activity is first created.
     */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.captureactivity);
        CameraManager.init(getApplication());
        viewfinderView = (ViewfinderView) findViewById(R.id.viewfinder_view);
        hasSurface = false;
        inactivityTimer = new InactivityTimer(this);

    }

    @Override
    protected void onResume() {
        super.onResume();
        TAG=this.getLocalClassName();
        ButterKnife.inject(this);
        try {
            profile = (Profile) this.getIntent().getSerializableExtra("profile");
        } catch (Exception e) {
            profile = null;
        }
        init();
        checkScanHistoryDao();
        //quit the scan view
    }
    protected void checkScanHistoryDao() {
        if (scanHistoryDao != null) {
        } else {
            scanHistoryDao = MyApplication.getDaoSession(mContext).getScanHistoryDao();
        }
    }
    @OnClick(R.id.cancelScanButton)
    public void cancelScan(View v) {
        super.finish();
    }
    @Override
    protected void onPause() {
        super.onPause();
        if (handler != null) {
            handler.quitSynchronously();
            handler = null;
        }
        CameraManager.get().closeDriver();
    }

    @Override
    protected void onDestroy() {
        inactivityTimer.shutdown();
        super.onDestroy();
    }

    protected void init(){
        SurfaceView surfaceView = (SurfaceView) findViewById(R.id.preview_view);
        SurfaceHolder surfaceHolder = surfaceView.getHolder();
        if (hasSurface) {
            initCamera(surfaceHolder);
        } else {
            surfaceHolder.addCallback(this);
            surfaceHolder.setType(SurfaceHolder.SURFACE_TYPE_PUSH_BUFFERS);
        }
        decodeFormats = null;
        characterSet = null;

        playBeep = true;
        AudioManager audioService = (AudioManager) getSystemService(AUDIO_SERVICE);
        if (audioService.getRingerMode() != AudioManager.RINGER_MODE_NORMAL) {
            playBeep = false;
        }
        initBeepSound();
        vibrate = true;
    }


    /**
     * Handler scan result
     *
     * @param result
     * @param barcode
     */
    public void handleDecode(Result result, Bitmap barcode) {
        inactivityTimer.onActivity();
        playBeepSoundAndVibrate();
        String resultString = result.getText();
        //FIXME
        if (resultString.equals("")) {
            Toast.makeText(CaptureActivity.this, "Scan failed!", Toast.LENGTH_SHORT).show();
        }else {
            ScanHistory scanHistory = new ScanHistory();
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
                temp=new ArrayList<>();
                temp.add(scanHistory);
                Gson gson=new Gson();
                String recordList=gson.toJson(temp);
                HashMap<String,String> params=new HashMap<>();
                params.put("recordList", recordList);
                params.put("listSize", "1");
                VolleyRequest.Post(params, Constants.getHttpurl() + "scan/add", mContext, successListener, errorListener);
            } else {
                Toast.makeText(mContext, R.string.update_error, Toast.LENGTH_LONG).show();
            }

        }
        CaptureActivity.this.finish();
    }

    private void initCamera(SurfaceHolder surfaceHolder) {
        try {
            CameraManager.get().openDriver(surfaceHolder);
        } catch (IOException ioe) {
            return;
        } catch (RuntimeException e) {
            return;
        }
        if (handler == null) {
            handler = new CaptureActivityHandler(this, decodeFormats,
                    characterSet);
        }
    }

    @Override
    public void surfaceChanged(SurfaceHolder holder, int format, int width,
                               int height) {

    }

    @Override
    public void surfaceCreated(SurfaceHolder holder) {
        if (!hasSurface) {
            hasSurface = true;
            initCamera(holder);
        }

    }

    @Override
    public void surfaceDestroyed(SurfaceHolder holder) {
        hasSurface = false;

    }

    public ViewfinderView getViewfinderView() {
        return viewfinderView;
    }

    public Handler getHandler() {
        return handler;
    }

    public void drawViewfinder() {
        viewfinderView.drawViewfinder();

    }

    private void initBeepSound() {
        if (playBeep && mediaPlayer == null) {
            // The volume on STREAM_SYSTEM is not adjustable, and users found it
            // too loud,
            // so we now play on the music stream.
            setVolumeControlStream(AudioManager.STREAM_MUSIC);
            mediaPlayer = new MediaPlayer();
            mediaPlayer.setAudioStreamType(AudioManager.STREAM_MUSIC);
            mediaPlayer.setOnCompletionListener(beepListener);

            AssetFileDescriptor file = getResources().openRawResourceFd(R.raw.beep);
            try {
                mediaPlayer.setDataSource(file.getFileDescriptor(),
                        file.getStartOffset(), file.getLength());
                file.close();
                mediaPlayer.setVolume(BEEP_VOLUME, BEEP_VOLUME);
                mediaPlayer.prepare();
            } catch (IOException e) {
                mediaPlayer = null;
            }
        }
    }

    private static final long VIBRATE_DURATION = 200L;

    protected void playBeepSoundAndVibrate() {
        if (playBeep && mediaPlayer != null) {
            mediaPlayer.start();
        }
        if (vibrate) {
            Vibrator vibrator = (Vibrator) getSystemService(VIBRATOR_SERVICE);
            vibrator.vibrate(VIBRATE_DURATION);
        }
    }

    /**
     * When the beep has finished playing, rewind to queue up another one.
     */
    private final OnCompletionListener beepListener = new OnCompletionListener() {
        public void onCompletion(MediaPlayer mediaPlayer) {
            mediaPlayer.seekTo(0);
        }
    };



   protected Response.Listener successListener=new Response.Listener<String>() {
        @Override
        public void onResponse(String response) {
            if (alertDialog == null || alertDialog.isShowing()) {
                alertDialog = new AlertDialog.Builder(mContext).create();
            }
            JSONObject json=null;
            try {
                json=new JSONObject(response);
                if(json.optBoolean("result", true)){
                    alertDialog.setTitle(mContext.getString(R.string.upload_success));
                }else{
                    alertDialog.setTitle(mContext.getString(R.string.upload_error));
                }
                alertDialog.setMessage(json.optString("message"));
                alertDialog.setButton(AlertDialog.BUTTON_POSITIVE, mContext.getString(R.string.confirm), new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
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
            } catch (JSONException e) {
                e.printStackTrace();
            }
            alertDialog.show();
            Log.d(TAG, "response -> " + response.toString());
        }
    };
    protected Response.ErrorListener errorListener=new Response.ErrorListener() {
        @Override
        public void onErrorResponse(VolleyError volleyError) {
            if (alertDialog == null || alertDialog.isShowing()) {
                alertDialog = new AlertDialog.Builder(mContext).create();
            }
            alertDialog.setTitle(mContext.getString(R.string.upload_error));
            alertDialog.setMessage( volleyError.toString());
            alertDialog.setButton(AlertDialog.BUTTON_POSITIVE, mContext.getString(R.string.confirm), new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialogInterface, int i) {
                    alertDialog.dismiss();
                }
            });
            alertDialog.setButton(AlertDialog.BUTTON_NEGATIVE, mContext.getString(R.string.cancel), new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialogInterface, int i) {
                    alertDialog.dismiss();
                }
            });
            alertDialog.show();
            Log.d(TAG, "response -> " + volleyError.toString());
        }


    };
    protected Handler mHandler = new Handler() {
        public void handleMessage(Message msg) {
            switch (msg.what) {
                case 0:
                    for(ScanHistory scanHistory:temp){
                        scanHistory.setIfupload("1");
                        scanHistoryDao.update(scanHistory);
                    }
                    if(TAG.contains("Batch")){
                        updateView();
                    }else{
                        Log.d(TAG, "DoNothing");
                    }
                    break;
                default:
                    break;
            }
            super.handleMessage(msg);
        }
    };

    public void updateView() {
    }
}