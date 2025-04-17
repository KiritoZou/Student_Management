package com.example.dao;

import com.example.model.User;

public interface UserDAO {
    User findByUsernameAndPassword(String username, String password);
    User findByUsername(String username);
    boolean existsByUsername(String username);
    void save(User user);
} 