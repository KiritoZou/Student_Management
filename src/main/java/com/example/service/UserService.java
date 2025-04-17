package com.example.service;

import com.example.model.User;

public interface UserService {
    User authenticate(String username, String password);
    void register(User user, String confirmPassword, String inviteCode) throws Exception;
    User login(String username, String password) throws Exception;
}