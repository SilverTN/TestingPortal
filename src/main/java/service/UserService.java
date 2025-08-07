package service;

import dao.UserDao;
import model.User;
import util.PasswordUtil;

public class UserService {

    private UserDao userDAO = new UserDao();

    public boolean register(String username, String password) {
        try {
            User user = new User();
            user.setUsername(username);
            user.setPasswordHash(PasswordUtil.hashPassword(password));
            user.setRole(1);
            userDAO.registerUser(user.getUsername(),user.getPasswordHash(), user.getEmail());
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean authenticate(String username, String password) {
        try {
            User user = userDAO.getUserByUsername(username);
            return user != null && PasswordUtil.checkPassword(password, user.getPasswordHash());
        } catch (Exception e) {
            return false;
        }
    }
}
