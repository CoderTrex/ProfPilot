package springboot.profpilot.model.AuthApply;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import springboot.profpilot.model.member.Member;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AuthApplyService {
    private final AuthApplyRepository authApplyRepository;

    public AuthApply save(AuthApply authApply) {
        return authApplyRepository.save(authApply);
    }

    public AuthApply findByApplicant(Member applicant) {
        return authApplyRepository.findByApplicant(applicant);
    }

    public AuthApply findById(Long id) {
        return authApplyRepository.findById(id).orElse(null);
    }

    public void delete(AuthApply authApply) {
        authApplyRepository.delete(authApply);
    }
}
