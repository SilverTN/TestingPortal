package model;

import lombok.Data;

import java.util.List;

@Data
public class Test {
    private int id;
    private String title;
    private String description;
    private List<Question> questions;
}