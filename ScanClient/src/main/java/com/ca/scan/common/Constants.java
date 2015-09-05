package com.ca.scan.common;

/**
 * Created by pandeng on 2015/7/27.
 */
public class Constants {

    public static String getHttpurl() {
        return httpurl;
    }

    private static final String httpurl="http://192.168.1.100:8080/admin/am/";

    public static final String DB_NAME="local_db";
    //CameraManager”√
    private static final int MIN_FRAME_WIDTH = 240;
    private static final int MIN_FRAME_HEIGHT = 240;
    private static final int MAX_FRAME_WIDTH = 480;
    private static final int MAX_FRAME_HEIGHT = 360;

    public static int getMinFrameWidth() {
        return MIN_FRAME_WIDTH;
    }

    public static int getMinFrameHeight() {
        return MIN_FRAME_HEIGHT;
    }

    public static int getMaxFrameWidth() {
        return MAX_FRAME_WIDTH;
    }

    public static int getMaxFrameHeight() {
        return MAX_FRAME_HEIGHT;
    }

    public   enum SubmitProgress{
        Creat("00"),Modify("01"),Modified("02");
        public final String value;
        SubmitProgress(String value) {
            this.value = value;
        }

        @Override
        public String toString() {
            return this.value;
        }
    }

    public   enum HistoryRequestType{
        ScanHistory("00"),DescHistory("01");
        public final String value;
        HistoryRequestType(String value) {
            this.value = value;
        }

        @Override
        public String toString() {
            return this.value;
        }
    }
}
