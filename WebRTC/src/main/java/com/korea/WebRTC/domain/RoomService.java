package com.korea.WebRTC.domain;

import com.korea.WebRTC.utils.Parser;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.WebSocketSession;

import java.util.Collections;
import java.util.Comparator;
import java.util.Map;
import java.util.TreeSet;
import java.util.Optional;
import java.util.Set;
import java.util.TreeSet;

public class RoomService {
    private final Parser parser;
    private final Set<Room> rooms = new TreeSet<>(Comparator.comparing(Room::getId));

    public RoomService(Parser parser) {
        this.parser = parser;
    }

    public Set<Room> getRooms() {
        final TreeSet<Room> rooms_a = new TreeSet<>(Comparator.comparing(Room::getId));
        rooms_a.addAll(rooms);
        return rooms_a;
    }

    public Boolean addRoom(Room room) {
        return rooms.add(room);
    }

    public Optional<Room> findRoomById(Long id) {
        return rooms.stream().filter(room -> room.getId().equals(id)).findFirst();
    }

    public Long getRoomId(Room room) {
        return room.getId();
    }

    public Map<String, WebSocketSession> getClients(Room room) {
        return Optional.ofNullable(room)
                .map(r -> Collections.unmodifiableMap(r.getClients()))
                .orElse(Collections.emptyMap());
    }

    public WebSocketSession addclient(final Room room, final String uuid, final WebSocketSession session) {
        return room.getClients().put(uuid, session);
    }

    public WebSocketSession removeClientByName(final Room room, final String uuid) {
        return room.getClients().remove(uuid);
    }
}
