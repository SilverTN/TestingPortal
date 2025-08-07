package model;

import lombok.*;

@Data
public class UserAnswer {
    private int questionId;
    private int optionId;
    private boolean isSelected;

    public UserAnswer(int questionId, int optionId, boolean isSelected) {
        this.questionId = questionId;
        this.optionId = optionId;
        this.isSelected = isSelected;
    }

    public boolean isSelected() { return isSelected; }
    public void setSelected(boolean selected) { isSelected = selected; }
}
