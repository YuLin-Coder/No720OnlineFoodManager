package com.lyy.food.util;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

public class StringUtil {
    private final static String FORMAT_CODE = "0000";

    /**
     * 生成流水号 日期+
     * @param codes
     * @return
     */
    public static String randomNumber(String codes){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String date = sdf.format(new Date()); // 格式化日期 date: 20200724
        String codeEnd = codes + date+UUID.randomUUID().toString().substring(0,4);
        return codeEnd;
    }
}
