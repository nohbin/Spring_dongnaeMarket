package com.marketdongnae.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CommunityController {
	
	@GetMapping("/community")
	public String communityMain() {
		
		return "/community";
	}
	
	
}
