package com.ca.scan.adapter;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.TextView;
import com.ca.scan.R;
import com.ca.scan.dao.DescHistory;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by pandeng on 2015/7/29.
 */
public class HistoryAdapter extends BaseAdapter {
    private List<DescHistory> DescHistory = new ArrayList<DescHistory>();
    private String historyType;
    private LayoutInflater mInflater;

    public HistoryAdapter(Context context, List<DescHistory> DescHistory, String historyType) {
        this.DescHistory = DescHistory;
        this.mInflater = LayoutInflater.from(context);
        this.historyType = historyType;
    }

    @Override
    public int getCount() {
        if (DescHistory != null && DescHistory.size() > 0) {
            return DescHistory.size();
        } else {
            return 0;
        }
    }

    @Override
    public DescHistory getItem(int i) {
        if (DescHistory != null && DescHistory.size() > 0) {
            return DescHistory.get(i);
        } else {
            return null;
        }
    }

    @Override
    public long getItemId(int i) {
        return 0;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup viewGroup) {
        ViewHolder holder;
        if (convertView == null) {
            convertView = mInflater.inflate(R.layout.historyitem, null);
            holder = new ViewHolder(convertView);
            holder.title.setText(DescHistory.get(position).getDesc());
            convertView.setTag(holder);//绑定ViewHolder对象
        } else {
            holder = (ViewHolder) convertView.getTag();//取出ViewHolder对象//
        }
        return convertView;
    }

    public List<DescHistory> getDescHistory() {
        return DescHistory;
    }

    public void setDescHistory(List<DescHistory> descHistory) {
        DescHistory = descHistory;
    }
}