package lk.jiat.wp2.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

@Provider
public class GenericExceptionMapper implements ExceptionMapper<Throwable> {

    private static final Logger log = LoggerFactory.getLogger(GenericExceptionMapper.class);

    @Context
    private UriInfo uriInfo;

    @Override
    public Response toResponse(Throwable ex) {
        log.error("Unhandled error", ex);
        ApiError err = new ApiError(500, "Internal Server Error",
                "Something went wrong. Please check server logs.", uriInfo.getPath());
        return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity(err).build();
    }
}
