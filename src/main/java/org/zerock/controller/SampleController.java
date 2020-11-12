package org.zerock.controller;

import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;


@Log4j
@Controller
@RequestMapping("/sample/*")


public class SampleController {

	@GetMapping("/all")
	public void doAll() {
		log.info("모든 방문자");
	}
	
	@GetMapping("/member")
	public void doMember() {
		log.info("로그인한 회원");
	}
	
	@GetMapping("/admin")
	public void doAdmin() {
		log.info("관리자");
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@GetMapping("/annoMember")
	public void deMember2() {
		log.info("로그인한 멤버 어노테이션");
	}
	@Secured({"ROLE_ADMIN"})
	@GetMapping("/annoAdmin")
	public void doAdmin2() {
		log.info("관리자 어노테이션");
	}
	
}
