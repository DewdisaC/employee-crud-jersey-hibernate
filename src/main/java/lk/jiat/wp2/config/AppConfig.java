package lk.jiat.wp2.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import lk.jiat.wp2.exception.GenericExceptionMapper;
import lk.jiat.wp2.exception.NotFoundExceptionMapper;
import lk.jiat.wp2.exception.ValidationExceptionMapper;
import lk.jiat.wp2.security.AuthDynamicFeature;
import lk.jiat.wp2.security.BasicAuthFilter;
import org.glassfish.jersey.jackson.internal.jackson.jaxrs.json.JacksonJaxbJsonProvider;
import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.server.mvc.MvcFeature;
import org.glassfish.jersey.server.validation.ValidationFeature;

import javax.ws.rs.ApplicationPath;

@ApplicationPath("/")
public class AppConfig extends ResourceConfig {

    public AppConfig() {

        // Scan REST resources
        packages("lk.jiat.wp2.resource");

        ObjectMapper mapper = new ObjectMapper();
        mapper.registerModule(new JavaTimeModule());
        mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);

        JacksonJaxbJsonProvider provider = new JacksonJaxbJsonProvider();
        provider.setMapper(mapper);
        register(provider);

        // MVC + Validation
        register(MvcFeature.class);
        register(ValidationFeature.class);

        // Security
        register(BasicAuthFilter.class);
        register(AuthDynamicFeature.class);

        // Exception mappers
        register(NotFoundExceptionMapper.class);
        register(ValidationExceptionMapper.class);
        register(GenericExceptionMapper.class);
    }
}