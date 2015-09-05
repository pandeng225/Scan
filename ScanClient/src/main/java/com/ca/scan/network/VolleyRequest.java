package com.ca.scan.network;

import android.content.Context;
import android.util.Log;
import com.android.volley.*;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.JsonRequest;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.ca.scan.application.MyApplication;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Pandeng on 2015/9/5 0005.
 */
public class VolleyRequest {
    static String TAG="Request";
    public static void  Post(final HashMap<String,String> params,String httpurl,Context context,Response.Listener successListener,Response.ErrorListener errorListener){
        RequestQueue requestQueue= MyApplication.getRequestQueue(context);
        StringRequest stringRequest = new StringRequest(Request.Method.POST,httpurl,
                successListener, errorListener){
            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                return params;
            }
//            @Override
//            public Map<String, String> getHeaders() {
//                HashMap<String, String> headers = new HashMap<String, String>();
////                headers.put("Accept", "application/json");
////                headers.put("Content-Type", "application/json; charset=UTF-8");
//                return headers;
//            }
        };
        stringRequest.setRetryPolicy(new DefaultRetryPolicy(20 * 1000, 2, 1.0f));
        requestQueue.add(stringRequest);
    }
    public static void  Get(String httpurl,Context context,Response.Listener successListener,Response.ErrorListener errorListener){
        RequestQueue requestQueue= MyApplication.getRequestQueue(context);
        StringRequest stringRequest = new StringRequest(Request.Method.GET,httpurl,
                successListener, errorListener){
        };
        requestQueue.add(stringRequest);
    }
}
