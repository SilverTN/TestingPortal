package model.dto;

public class OptionResult {
    private String text;
    private boolean isSelected;
    private boolean isCorrect;

    public OptionResult(String text, boolean isSelected, boolean isCorrect) {
        this.text = text;
        this.isSelected = isSelected;
        this.isCorrect = isCorrect;
    }

    public String getText() { return text; }
    public boolean Selected() { return isSelected; }
    public boolean isCorrect() { return isCorrect; }
}