package com.ca.utils;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.XmlFriendlyNameCoder;
import com.thoughtworks.xstream.io.xml.XppDriver;

public class XstreamUtils {

	public static String bean2Xml(Object obj) {
		XStream xstream = new XStream(new XppDriver(new XmlFriendlyNameCoder(
				"_-", "_")));
		xstream.autodetectAnnotations(true);
		return xstream.toXML(obj);
	}

	public static Object xml2Bean(String xml, Class<?>[] clazz) {
        if(null==xml||xml.trim().length()==0)
            return null;
		XStream xstream = new XStream(new XppDriver(new XmlFriendlyNameCoder(
				"_-", "_")));
		xstream.processAnnotations(clazz);
		return xstream.fromXML(xml);
	}

}
