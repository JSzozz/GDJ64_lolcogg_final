package gg.lolco.common.websocket;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ChatMessage {
	private MessageTypes type;
	private String sender;
	private String receiver;
	private String content;
	private boolean voiced;
	private boolean banned;
}
