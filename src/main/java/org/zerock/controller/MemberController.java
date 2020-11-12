package org.zerock.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.MemberVO;
import org.zerock.domain.AuthVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member/*")
@AllArgsConstructor
@Log4j
public class MemberController {

	private MemberService service;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
		
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		model.addAttribute("list", service.getList(cri));
		
		model.addAttribute("cri",cri);
		
		int total = service.getTotalCount(cri);
		model.addAttribute("total", total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register() {
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(MemberVO member, AuthVO auth, RedirectAttributes rttr) {
				
		log.info("register: " + member);
		log.info("register: " + auth);
		
		member.setUserpw(pwencoder.encode(member.getUserpw()));
				
		service.register(member, auth);
		
		//service.registerAuth(auth);
		
		rttr.addFlashAttribute("result", member.getUserid());
		
		return "redirect:/member/list";
	}
	
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("userid") String userid, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("/get or modify");
		
		model.addAttribute("member", service.get(userid));
	}
	
	/* @PreAuthorize("principal.username == #member.writer") */
	@PostMapping("/modify")
	public String modify(MemberVO member, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify:" + member);
		
		if(service.modify(member)) {
			rttr.addFlashAttribute("result","success");
		}
		
		return "redirect:/member/list" + cri.getListLink();		
	}
	
	/* @PreAuthorize("principal.username == #writer") */
	@PostMapping("/remove")
	public String remove(@RequestParam("userid") String userid, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String writer) {
		log.info("remove..." + userid);
		
		if(service.remove(userid)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/member/list" + cri.getListLink();		
	}
	
}
