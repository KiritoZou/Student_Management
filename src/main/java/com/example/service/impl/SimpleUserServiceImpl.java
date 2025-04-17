package com.example.service.impl;

import com.example.model.User;
import com.example.service.UserService;
import org.springframework.stereotype.Service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@Service
public class SimpleUserServiceImpl implements UserService {

    @Override
    public void register(User user, String confirmPassword, String inviteCode) throws Exception {
        throw new Exception("注册功能暂未开放");
    }

    @Override
    public User login(String username, String password) {
        try {
            // 特殊处理 root 用户
            if ("root".equals(username) && "zby2766485803".equals(password)) {
                User rootUser = new User();
                rootUser.setId(0L);
                rootUser.setUsername("root");
                rootUser.setPassword(md5("zby2766485803"));
                rootUser.setRealName("系统管理员");
                rootUser.setGender("男");
                rootUser.setStatus(1);
                return rootUser;
            }
            
            // 拒绝其他用户登录
            return null;
        } catch (Exception e) {
            // 记录异常但不抛出
            e.printStackTrace();
            return null;
        }
    }
    
    @Override
    public User authenticate(String username, String password) {
        return login(username, password);
    }
    
    private String md5(String input) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(input.getBytes());
        byte[] digest = md.digest();
        return bytesToHex(digest).toLowerCase();
    }
    
    private static String bytesToHex(byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }
} 