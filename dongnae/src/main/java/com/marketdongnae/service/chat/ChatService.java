package com.marketdongnae.service.chat;

import org.springframework.stereotype.Service;

import com.marketdongnae.domain.chat.ChatRoomDTO;

@Service
public interface ChatService {
		// 채팅방 개설
	public ChatRoomDTO createRoom(String title);

		// 채팅방 방문
	public ChatRoomDTO findRoomById(String roomId);
			
	public Object findAllRoom();
	
	String findUserName(String userName);
			
}
