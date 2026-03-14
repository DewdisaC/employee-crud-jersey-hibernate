package lk.jiat.wp2.security;

import java.security.Principal;
import java.util.Set;

public class UserPrincipal implements Principal {
    private final String name;
    private final Set<String> roles;

    public UserPrincipal(String name, Set<String> roles) {
        this.name = name;
        this.roles = roles;
    }

    @Override
    public String getName() {
        return name;
    }

    public boolean hasRole(String role) {
        return roles.contains(role);
    }
}
