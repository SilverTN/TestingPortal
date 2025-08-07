package model;

import jakarta.servlet.http.HttpServletRequest;
import java.util.*;

public class QuestionParser {

    public static List<Question> parseQuestions(HttpServletRequest request) {
        List<Question> questions = new ArrayList<>();

        Enumeration<String> parameterNames = request.getParameterNames();
        Set<Integer> questionIndices = new HashSet<>();

        // Собираем индексы всех вопросов
        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();

            if (paramName.startsWith("questionText_")) {
                int index = extractIndex(paramName);
                questionIndices.add(index);
            }
        }

        for (int i : questionIndices) {
            String text = request.getParameter("questionText_" + i);
            int type = Integer.parseInt(request.getParameter("questionType_" + i));

            List<Option> options = new ArrayList<>();
            Enumeration<String> allParams = request.getParameterNames();

            while (allParams.hasMoreElements()) {
                String p = allParams.nextElement();

                if (p.startsWith("optionText_" + i + "_")) {
                    int optIndex = extractOptionIndex(p);

                    String optionText = request.getParameter(p);
                    boolean isCorrect = request.getParameter("isCorrect_" + i + "_" + optIndex) != null;

                    if (optionText != null && !optionText.trim().isEmpty()) {
                        options.add(new Option(0, 0, optionText, isCorrect));
                    }
                }
            }

            if (text != null && !text.trim().isEmpty()) {
                questions.add(new Question(0, 0, text, type, options));
            }
        }

        return questions;
    }

    private static int extractIndex(String paramName) {
        return Integer.parseInt(paramName.split("_")[1]);
    }

    private static int extractOptionIndex(String paramName) {
        return Integer.parseInt(paramName.split("_")[2]);
    }
}