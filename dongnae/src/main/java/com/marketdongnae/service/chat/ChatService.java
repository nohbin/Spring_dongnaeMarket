package com.marketdongnae.service.chat;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.marketdongnae.chat.ChatRoomRepository;
import com.marketdongnae.domain.chat.ChatRoomDTO;
import com.marketdongnae.domain.member.MemberDTO;
import com.marketdongnae.security.CustomUserDetails;

@Service
public class ChatService {
	@Autowired
	private ChatRoomRepository chatRoomRepository;
	
	// 채팅방 개설
	public ChatRoomDTO createRoom(String title) {
		return chatRoomRepository.createRoom(title);
	}

	// 채팅방 방문
	public ChatRoomDTO findRoomById(String roomId) {
		return chatRoomRepository.findRoomById(roomId);
	}

	public Object findAllRoom() {
		return chatRoomRepository.findAllRoom();
	}

}
