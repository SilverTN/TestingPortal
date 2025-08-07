package util;

import jakarta.servlet.http.HttpServletRequest;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

public class RequestUtil {

    public static Map<String, String[]> getAnswersFromRequest(HttpServletRequest request) {
        Map<String, String[]> answerMap = new HashMap<>();
        Enumeration<String> parameterNames = request.getParameterNames();

        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            String[] paramValues = request.getParameterValues(paramName);
            answerMap.put(paramName, paramValues);
        }

        return answerMap;
    }
}
