package com.marketdongnae.domain.chat;


import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class ChatMessageDTO implements Serializable{
    private String roomId;
    private String writer;
    private String message;
    private String timestamp;
    
    public ChatMessageDTO() {
    }
    
    public ChatMessageDTO(String writer,String message) {
    	this.writer = writer;
        this.message = message;
    }
    
    @Override
    public String toString() {
        return "Message{" +
                "writer='" + writer + '\'' +
                ", message='" + message + '\'' +
                ", timestamp='" + timestamp + '\'' +
                '}';
    }
}
