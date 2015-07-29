package com.ca.scan.common;

import android.view.View;
import butterknife.ButterKnife;

/**
 * Created by pandeng on 2015/7/29.
 */
public class ButterKnifeAction {
    public static final ButterKnife.Action<View> GONE = new ButterKnife.Action<View>() {

        @Override public void apply(View view, int index) {

            view.setVisibility(View.GONE);

        }

    };
    public static final ButterKnife.Action<View>  INVISIBLE= new ButterKnife.Action<View>() {

        @Override public void apply(View view, int index) {

            view.setVisibility(View.INVISIBLE);

        }

    };
    public static final ButterKnife.Action<View>  VISIBLE= new ButterKnife.Action<View>() {

        @Override public void apply(View view, int index) {

            view.setVisibility(View.VISIBLE);

        }

    };
}
