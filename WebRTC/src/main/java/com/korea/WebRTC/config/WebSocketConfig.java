package com.korea.WebRTC.config;

import org.springframework.context.annotation.Bean;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.standard.ServletServerContainerFactoryBean;

import java.io.IOException;
import java.util.logging.SocketHandler;

public class WebSocketConfig implements WebSocketConfigurer {
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry webSocketHandlerRegistry) {
        try {
            webSocketHandlerRegistry.addHandler(signalingSocketHandler(), "/signal")
                    .setAllowedOrigins("*");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Bean
    private WebSocketHandler signalingSocketHandler() throws IOException {
        return (WebSocketHandler) new SocketHandler();
    }

    @Bean
    public ServletServerContainerFactoryBean createWebSocketContainer() {
        ServletServerContainerFactoryBean container = new ServletServerContainerFactoryBean();
        container.setMaxTextMessageBufferSize(8192);
        container.setMaxBinaryMessageBufferSize(8192);
        return container;
    }
}
