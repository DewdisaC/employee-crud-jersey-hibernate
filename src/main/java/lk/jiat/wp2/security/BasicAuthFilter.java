package lk.jiat.wp2.security;

import javax.annotation.Priority;
import javax.ws.rs.Priorities;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.Provider;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Map;
import java.util.Set;

@Provider
@Priority(Priorities.AUTHENTICATION)
public class BasicAuthFilter implements ContainerRequestFilter {

    // Hardcoded users for assignment demo
    // admin/admin123 => ADMIN
    // user/user123   => USER
    private static final Map<String, String> PASSWORDS = Map.of(
            "admin", "admin123",
            "user", "user123"
    );

    private static final Map<String, Set<String>> ROLES = Map.of(
            "admin", Set.of("ADMIN", "USER"),
            "user", Set.of("USER")
    );

    @Override
    public void filter(ContainerRequestContext requestContext) {

        // allow public health endpoint
        String path = requestContext.getUriInfo().getPath();
        if (path != null && path.startsWith("health")) {
            return;
        }

        String auth = requestContext.getHeaderString(HttpHeaders.AUTHORIZATION);

        // Missing header
        if (auth == null || !auth.startsWith("Basic ")) {
            abort(requestContext, "Missing Authorization header");
            return;
        }

        String base64 = auth.substring("Basic ".length()).trim();

        String decoded;
        try {
            decoded = new String(Base64.getDecoder().decode(base64), StandardCharsets.UTF_8);
        } catch (Exception e) {
            abort(requestContext, "Invalid Authorization header");
            return;
        }

        // decoded format = username:password
        String[] parts = decoded.split(":", 2);
        if (parts.length != 2) {
            abort(requestContext, "Invalid username/password format");
            return;
        }

        String username = parts[0];
        String password = parts[1];

        // Validate credentials
        if (!PASSWORDS.containsKey(username) || !PASSWORDS.get(username).equals(password)) {
            abort(requestContext, "Invalid username or password");
            return;
        }

        // Set SecurityContext with roles
        UserPrincipal principal = new UserPrincipal(username, ROLES.getOrDefault(username, Set.of()));
        requestContext.setSecurityContext(
                new SimpleSecurityContext(principal, requestContext.getSecurityContext().isSecure())
        );
    }

    private void abort(ContainerRequestContext ctx, String message) {
        String json = String.format(
                "{\"status\":401,\"error\":\"Unauthorized\",\"message\":\"%s\"}",
                escapeJson(message)
        );

        ctx.abortWith(Response.status(Response.Status.UNAUTHORIZED)
                .header("WWW-Authenticate", "Basic realm=\"EmployeeCRUD\"")
                .type(MediaType.APPLICATION_JSON)
                .entity(json)
                .build());
    }

    // Small helper to keep JSON safe
    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}