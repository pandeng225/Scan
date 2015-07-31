package com.ca.scan.adapter;

import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import butterknife.ButterKnife;
import butterknife.InjectView;
import butterknife.Optional;
import com.ca.scan.R;

/**
 * Created by pandeng on 2015/7/29.
 */
public final class ViewHolder {
    @InjectView(R.id.title)
    TextView title;
    @Optional
    @InjectView(R.id.uploaded)
    TextView uploaded;
    @Optional
    @InjectView(R.id.deleteButton)
    Button deleteButton;
    public ViewHolder(View view) {
        ButterKnife.inject(this, view);
    }

}
