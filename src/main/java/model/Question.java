package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Question {
    private int id;
    private int testId;
    private String text;
    private int questionType; // 0 = single_choice, 1 = multiple_choice
    private List<Option> options;

}