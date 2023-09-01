package com.marketdongnae.service.chat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.marketdongnae.chat.ChatRoomRepository;
import com.marketdongnae.domain.chat.ChatRoomDTO;
import com.marketdongnae.domain.member.MemberDTO;
import com.marketdongnae.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class ChatServiceImpl implements ChatService{
	@Autowired
	private ChatRoomRepository chatRoomRepository;
	private final MemberMapper memberMapper;

	@Override
	public ChatRoomDTO createRoom(String title) {
		return chatRoomRepository.createRoom(title);
	}

	@Override
	public ChatRoomDTO findRoomById(String roomId) {
		return chatRoomRepository.findRoomById(roomId);
	}

	@Override
	public Object findAllRoom() {
		return chatRoomRepository.findAllRoom();
	}
	
	@Override
	public String findUserName(String findUserName){
        String user;
        MemberDTO memberDTO = memberMapper.findUserName(findUserName);
        if(memberDTO==null){
            user = "fail";
        }else{
            user = "find";
        }
        return user;
    }
}
