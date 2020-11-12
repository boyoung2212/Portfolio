package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.zerock.service.MyLocService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
public class MyLocController {


	private MyLocService service;
	
	@GetMapping("/locAdmin")
	public void locAdmin(Model model){
		model.addAttribute("list", service.read());
		log.info("ss");
	}

}
