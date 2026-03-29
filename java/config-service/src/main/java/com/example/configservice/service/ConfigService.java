package com.example.configservice.service;

import com.example.configservice.entity.Config;
import com.example.configservice.repository.ConfigRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class ConfigService {

    private final ConfigRepository repo;

    public ConfigService(ConfigRepository repo) {
        this.repo = repo;
    }

    public Optional<Config> getConfig(Long id) {
        return repo.findById(id);
    }

    public Config save(Config config) {
        return repo.save(config);
    }
}
