package com.example.service.impl;

import com.example.model.User;
import com.example.service.UserService;
import com.example.dao.UserDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@Service
public class UserServiceImpl implements UserService {
    
    @Autowired
    private UserDAO userDAO;
    
    private String md5(String input) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(input.getBytes());
        byte[] digest = md.digest();
        return bytesToHex(digest).toLowerCase();
    }
    
    @Override
    public User authenticate(String username, String password) {
        try {
            // 特殊处理 root 用户
            if ("root".equals(username)) {
                if ("zby2766485803".equals(password)) {
                    User rootUser = new User();
                    rootUser.setId(0L);
                    rootUser.setUsername("root");
                    rootUser.setPassword(md5("zby2766485803"));
                    rootUser.setRealName("系统管理员");
                    rootUser.setEmail("admin@example.com");
                    return rootUser;
                }
                return null;
            }
            
            // 查找用户
            return userDAO.findByUsernameAndPassword(username, md5(password));
        } catch (Exception e) {
            return null;
        }
    }
    
    @Override
    @Transactional
    public void register(User user, String confirmPassword, String inviteCode) throws Exception {
        // 验证密码
        if (!user.getPassword().equals(confirmPassword)) {
            throw new Exception("两次输入的密码不一致");
        }

        // 验证邀请码
        if (!"STUDENT2024".equals(inviteCode)) {
            throw new Exception("邀请码无效");
        }

        // MD5加密密码
        user.setPassword(md5(user.getPassword()));
        
        // 设置用户状态为待审核(0)
        user.setStatus(0);

        // 保存用户 - 这里需要扩展UserDAO接口
        // 暂时留空，等待DAO接口扩展
    }
    
    @Override
    public User login(String username, String password) throws Exception {
        return authenticate(username, password);
    }
    
    // 新增方法：byte数组转十六进制字符串
    private static String bytesToHex(byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }
}