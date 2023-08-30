package com.marketdongnae.controller.chat;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.marketdongnae.domain.chat.ChatMessageDTO;

import lombok.RequiredArgsConstructor;


@RequiredArgsConstructor
@Controller
public class ChatController {

	private final SimpMessagingTemplate template; //특정 Broker로 메세지를 전달

	@MessageMapping(value = "/chat/message")
	public void message(ChatMessageDTO message){
		template.convertAndSend("/sub/chat/room/" + message.getRoomId(), message);
	}
}
