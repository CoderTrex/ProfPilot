package springboot.profpilot.controller.security;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import springboot.profpilot.model.Passenger;
import springboot.profpilot.model.Pilot;
import springboot.profpilot.repository.PassengerRepository;
import springboot.profpilot.repository.PilotRepository;

import java.util.List;


@Service
@RequiredArgsConstructor
public class MyUserDetailService implements UserDetailsService {
    private final PassengerRepository passengerRepository;
    private final PilotRepository pilotRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Passenger passenger = passengerRepository.findByEmail(email).orElse(null);
        Pilot pilot = pilotRepository.findByEmail(email).orElse(null);

        if (passenger == null && pilot == null) {
            throw new UsernameNotFoundException("사용자를 찾을 수 없습니다.");
        }

        String password = (passenger != null) ? passenger.getPassword() : pilot.getPassword();

        SimpleGrantedAuthority authority = new SimpleGrantedAuthority("USER");
        List<SimpleGrantedAuthority> authorities = List.of(authority);

        return new User(email, password, authorities);
    }

}