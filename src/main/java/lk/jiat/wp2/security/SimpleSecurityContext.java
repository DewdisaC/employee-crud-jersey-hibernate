package lk.jiat.wp2.security;

import javax.ws.rs.core.SecurityContext;
import java.security.Principal;

public class SimpleSecurityContext implements SecurityContext {

    private final UserPrincipal principal;
    private final boolean secure;

    public SimpleSecurityContext(UserPrincipal principal, boolean secure) {
        this.principal = principal;
        this.secure = secure;
    }

    @Override
    public Principal getUserPrincipal() {
        return principal;
    }

    @Override
    public boolean isUserInRole(String role) {
        return principal != null && principal.hasRole(role);
    }

    @Override
    public boolean isSecure() {
        return secure;
    }

    @Override
    public String getAuthenticationScheme() {
        return "BASIC";
    }
}
