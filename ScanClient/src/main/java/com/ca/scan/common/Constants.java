package com.ca.scan.common;

/**
 * Created by pandeng on 2015/7/27.
 */
public class Constants {
    public static final String DB_NAME="local_db";
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
}
