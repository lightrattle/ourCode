package com.mall.app.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {
    /*日期转换为制定格式字符串*/
    public static String formatDateToString(Date time, String format) {
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(time);
    }
}