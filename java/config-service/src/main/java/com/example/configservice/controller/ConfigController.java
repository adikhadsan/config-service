package com.example.configservice.controller;

import com.example.configservice.entity.Config;
import com.example.configservice.service.ConfigService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
public class ConfigController {

    private final ConfigService service;

    public ConfigController(ConfigService service) {
        this.service = service;
    }

    @GetMapping("/ping")
    public String ping() {
        return "pong";
    }

    @GetMapping("/configs/{id}")
    public ResponseEntity<?> get(@PathVariable Long id) {
        return service.getConfig(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/configs")
    public Config save(@RequestBody Config config) {
        return service.save(config);
    }
}
