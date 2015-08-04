package com.ca.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.atomic.AtomicInteger;

public class IdGenerator {
	private static AtomicInteger ID = new AtomicInteger(0);

	/**
	 * Method createId16.
	 * @return String
	 */
	public synchronized static Long createId16() {
		String str = null;

		if (ID.intValue() > 99) {
			ID.set(0);
		}
		str = getYMD() + String.format("%02d", ID.getAndIncrement());
		return Long.valueOf(str);
	}

	/**
	 * Method getYMD.
	 * @return String
	 */
	private static String getYMD() {
		SimpleDateFormat fymd = new SimpleDateFormat("yyyyMMddHHmmss");
		Date date = new Date();
		return fymd.format(date);
	}
}
