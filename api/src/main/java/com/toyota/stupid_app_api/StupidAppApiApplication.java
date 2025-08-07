package com.toyota.stupid_app_api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@SpringBootApplication
public class StupidAppApiApplication {

	public static void main(String[] args) {
		SpringApplication.run(StupidAppApiApplication.class, args);
	}

	@GetMapping("/")
	public String Hello(){
		return "Hello, World!";
	}

}
