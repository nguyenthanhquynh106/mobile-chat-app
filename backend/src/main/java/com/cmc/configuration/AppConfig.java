package com.cmc.configuration;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {

	@Bean
	public DateFormat dateFormat() {
		SimpleDateFormat format = new SimpleDateFormat();
		return format;
	}
}
