package com.example.Lab2Q3_DevOps;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController
{
    @GetMapping("/")
    public String Index()
    {
        return "index";
    }
}
