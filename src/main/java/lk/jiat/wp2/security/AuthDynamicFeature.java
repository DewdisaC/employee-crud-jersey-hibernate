package lk.jiat.wp2.security;

import org.glassfish.jersey.server.filter.RolesAllowedDynamicFeature;

import javax.ws.rs.container.DynamicFeature;
import javax.ws.rs.container.ResourceInfo;
import javax.ws.rs.core.FeatureContext;
import javax.ws.rs.ext.Provider;

@Provider
public class AuthDynamicFeature implements DynamicFeature {

    private final RolesAllowedDynamicFeature delegate = new RolesAllowedDynamicFeature();

    @Override
    public void configure(ResourceInfo resourceInfo, FeatureContext context) {
        delegate.configure(resourceInfo, context);
    }
}
