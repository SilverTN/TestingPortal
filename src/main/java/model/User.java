package model;

import lombok.*;

@Data
public class User {
    private int id;
    private String username;
    private String passwordHash;
    private int role;
    private String email;
}
