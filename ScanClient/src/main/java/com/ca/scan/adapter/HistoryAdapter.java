package com.ca.scan.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import com.ca.scan.R;
import com.ca.scan.application.MyApplication;
import com.ca.scan.common.Constants.HistoryRequestType;
import com.ca.scan.dao.DescHistory;
import com.ca.scan.dao.ScanHistory;
import com.ca.scan.dao.ScanHistoryDao;

import java.util.List;

/**
 * Created by pandeng on 2015/7/29.
 */
public class HistoryAdapter extends BaseAdapter {
    private List<?> histories;
    private Boolean ifDescHisory=true;
    private LayoutInflater mInflater;
    private Context mContext;



    public HistoryAdapter(Context context, List<?> Histories,String historyType) {

        this.mInflater = LayoutInflater.from(context);
        this.ifDescHisory = historyType.equals(HistoryRequestType.DescHistory.value);
        this.histories = Histories;
        this.mContext=context;
    }

    @Override
    public int getCount() {
        if (histories != null && histories.size() > 0) {
            return histories.size();
        } else {
            return 0;
        }

    }

    @Override
    public Object getItem(int i) {
        if (histories != null && histories.size() > 0) {
            return histories.get(i);
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
            convertView = mInflater.inflate(R.layout.historyitem, null);
            holder = new ViewHolder(convertView);
            convertView.setTag(holder);//绑定ViewHolder对象
        } else {
            holder = (ViewHolder) convertView.getTag();//取出ViewHolder对象//
        }
        if(ifDescHisory){
            holder.title.setText(((DescHistory)histories.get(position)).getDesc());
            holder.uploaded.setVisibility(View.INVISIBLE);
            holder.deleteButton.setVisibility(View.INVISIBLE);
        }else{
            ScanHistory scanHistory=(ScanHistory)histories.get(position);
            holder.title.setText(scanHistory.getExpressno());
            if(scanHistory.getIfupload()!=null&&scanHistory.getIfupload().equals("0")){
                holder.uploaded.setVisibility(View.INVISIBLE);
                holder.deleteButton.setVisibility(View.VISIBLE);
            }else{
                holder.uploaded.setVisibility(View.VISIBLE);
                holder.deleteButton.setVisibility(View.INVISIBLE);
            }
            holder.deleteButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    ScanHistoryDao scanHistoryDao = MyApplication.getDaoSession(mContext).getScanHistoryDao();
                    scanHistoryDao.delete((ScanHistory)histories.get(position));
                    histories.remove(position);
                    notifyDataSetChanged();
                }
            });
        }

        return convertView;
    }
    public List<?> getHistories() {
        return histories;
    }

    public void setHistories(List<?> histories) {
        this.histories = histories;
        this.notifyDataSetChanged();
    }

}