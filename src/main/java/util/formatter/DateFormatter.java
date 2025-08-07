package util.formatter;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateFormatter {
    private static final String DATE_PATTERN = "dd.MM.yyyy HH:mm:ss";

    public static String format(Date date) {
        if (date == null) return "";
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
        return sdf.format(date);
    }

    public static String format(java.sql.Timestamp timestamp) {
        if (timestamp == null) return "";
        return format(new Date(timestamp.getTime()));
    }
}