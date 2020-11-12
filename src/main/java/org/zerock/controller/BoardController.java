package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/notice/*")
@AllArgsConstructor
@Log4j
public class BoardController {

	private BoardService service;
	
	
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list");
		model.addAttribute("list", service.getList(cri));
		//model.addAttribute("pageMaker", new PageDTO(cri, 123));
		
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
	public String register(BoardVO board, RedirectAttributes rttr) {
		
		//ip
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null)
			ip = req.getRemoteAddr();
		
		board.setIp(ip);
		
		log.info("register: " + board);
		
		if(board.getAttachList() != null) {
			
			board.getAttachList().forEach(attach -> log.info(attach));
			
		}
		
		
		
		service.register(board);
		
		rttr.addFlashAttribute("result", board.getBno());
		
		return "redirect:/board/list";
	}
	
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("/get or modify");
		
		model.addAttribute("board", service.get(bno));
	}
	
	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify:" + board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}
		

		return "redirect:/board/list" + cri.getListLink();		
	}
	
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String writer) {
		log.info("remove..." + bno);
		
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		if(service.remove(bno)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}
		

		
		return "redirect:/board/list" + cri.getListLink();		
	}
	
	@GetMapping(value = "/getAttachList",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		
		log.info("getAttachList"+bno);
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}
	
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		
		if(attachList == null || attachList.size() == 0) {
			return;
		}
	
		log.info("delete attach files.................");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			try {
			
			Path file = Paths.get("C:/upload/"+attach.getUploadPath()+"/"+attach.getUuid()+"_"+ attach.getFileName());
			
			Files.deleteIfExists(file);
			if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:/upload/"+attach.getUploadPath()+"\\s_"+attach.getUuid()+"_"+ attach.getFileName());
					Files.delete(thumbNail);
				}
			} catch (Exception e) {
				log.error("delete file error" + e.getMessage());
			}
		});
	}
	
	
}
