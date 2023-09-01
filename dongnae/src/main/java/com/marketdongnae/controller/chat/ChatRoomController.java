package com.marketdongnae.controller.chat;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.marketdongnae.domain.chat.ChatRoomDTO;
import com.marketdongnae.domain.member.MemberDTO;
import com.marketdongnae.security.CustomUserDetails;
import com.marketdongnae.service.chat.ChatService;
import com.marketdongnae.service.member.MemberService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/chat")
public class ChatRoomController {
	@Autowired
	private ChatService chatService;
	private final MemberService memberService;

	@GetMapping("/rooms")
	public ModelAndView rooms() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/chat/rooms");
		mv.addObject("list",chatService.findAllRoom());
		return mv; 
	}

	
	// 채팅창 개설
	@PostMapping("/createRoom")
	public String createRoom(String title,RedirectAttributes rttr) {
		rttr.addFlashAttribute("create", chatService.createRoom(title));
		return "redirect:/chat/rooms";
	}
	
	// 채팅방 방문
	@GetMapping("/room")
	public String getRoom(String roomId, Model model){
		CustomUserDetails customUserDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	MemberDTO member = memberService.getMember(customUserDetails);
    	model.addAttribute("member",member);
		model.addAttribute("room",chatService.findRoomById(roomId));
    return "/chat/room";
	}
	
	@PostMapping("/findUserName")
	@ResponseBody
	public String findUserName(@RequestBody String findUserName) {
		System.out.println(findUserName);
		System.out.println("mmmmmmmmmmmmmmmmmmmmmmmmm");
		String user =chatService.findUserName(findUserName.replace("=", ""));
		return user;
	}
}
