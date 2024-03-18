/**
 * EumiraEmptyAppApplication.java
 */

package com.eumira.empty.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@SpringBootApplication
public class EumiraEmptyAppApplication {

	public static void main(String[] args) {
		SpringApplication.run(EumiraEmptyAppApplication.class, args);
	}

	@Controller
	public class DefaultPage {

		@RequestMapping(value = { "/", "/welcome" }, method = {
				RequestMethod.GET })
		public String defaultPage() {
			return "defaultPage";
		}

	}

}
