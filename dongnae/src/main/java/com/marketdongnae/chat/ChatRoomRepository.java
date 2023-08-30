package com.marketdongnae.chat;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.UUID;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Repository;
import com.marketdongnae.domain.chat.ChatRoomDTO;

@Repository
public class ChatRoomRepository {

	private Map<String, ChatRoomDTO> chatRoomDTOMap;

	@PostConstruct
	private void init(){
		chatRoomDTOMap = new LinkedHashMap<>();
	}
	
	// 채팅방 방문
	public ChatRoomDTO findRoomById(String id){
		return chatRoomDTOMap.get(id);
	}

	//채팅방 개설
	public ChatRoomDTO createRoom(String title) {
		String roomId = UUID.randomUUID().toString();
		ChatRoomDTO room = new ChatRoomDTO(roomId,title);
		chatRoomDTOMap.put(room.getRoomId(), room);
		return room;
	}

	public Object findAllRoom() {
		ChatRoomDTO lastValue= null;
		for (Map.Entry<String, ChatRoomDTO> entry : chatRoomDTOMap.entrySet()) {
			lastValue = entry.getValue();
		}
		return lastValue;
	}
}