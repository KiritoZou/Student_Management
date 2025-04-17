package com.example.service;

import com.example.model.Award;
import java.util.List;

public interface AwardService {
    List<Award> getAwardsByUserId(Long userId);
} 