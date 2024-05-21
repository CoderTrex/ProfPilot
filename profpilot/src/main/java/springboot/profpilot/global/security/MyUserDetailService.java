package springboot.profpilot.global.security;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import springboot.profpilot.model.member.Member;
import springboot.profpilot.model.member.MemberService;
import java.util.List;


@Service
@RequiredArgsConstructor
public class MyUserDetailService implements UserDetailsService {
    private final MemberService memberService;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Member member = memberService.findByEmail(email);
        if (member == null) throw new UsernameNotFoundException("User not found");
        SimpleGrantedAuthority authority = new SimpleGrantedAuthority("USER");
        List<SimpleGrantedAuthority> authorities = List.of(authority);
        return new User(member.getEmail(), member.getPassword(), authorities);
    }
}