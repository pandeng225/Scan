package com.ca.scan.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import com.ca.scan.R;
import com.ca.scan.dao.DescHistory;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by pandeng on 2015/7/29.
 */
public class ScanedAdapter extends BaseAdapter {
    private List<String> scanedStringList = new ArrayList<String>();
    private LayoutInflater mInflater;

    public ScanedAdapter(Context context, List<String> scanedStringList) {
        this.scanedStringList = scanedStringList;
        this.mInflater = LayoutInflater.from(context);
    }

    @Override
    public int getCount() {
        if (scanedStringList != null && scanedStringList.size() > 0) {
            return scanedStringList.size();
        } else {
            return 0;
        }
    }

    @Override
    public String getItem(int i) {
        if (scanedStringList != null && scanedStringList.size() > 0) {
            return scanedStringList.get(i);
        } else {
            return null;
        }
    }

    @Override
    public long getItemId(int i) {
        return 0;
    }

    @Override
    public View getView(final int position, View convertView, ViewGroup viewGroup) {
        ViewHolder holder;
        if (convertView == null) {
            convertView = mInflater.inflate(R.layout.scaneditem, null);
            holder = new ViewHolder(convertView);
            holder.title.setText(scanedStringList.get(position));
            holder.deleteButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    scanedStringList.remove(position);
                    notifyDataSetChanged();

                }
            });
            convertView.setTag(holder);//绑定ViewHolder对象
        } else {
            holder = (ViewHolder) convertView.getTag();//取出ViewHolder对象//
        }
        return convertView;
    }

    public List<String> getScanedStringList() {
        return scanedStringList;
    }

    public void setScanedStringList(List<String> scanedStringList) {
        this.scanedStringList = scanedStringList;
        this.notifyDataSetChanged();
    }
}