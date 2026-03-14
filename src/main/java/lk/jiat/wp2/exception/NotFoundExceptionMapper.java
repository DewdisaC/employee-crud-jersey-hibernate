package lk.jiat.wp2.exception;

import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;
import javax.ws.rs.core.UriInfo;

@Provider
public class NotFoundExceptionMapper implements ExceptionMapper<NotFoundException> {

    @Context
    private UriInfo uriInfo;

    @Override
    public Response toResponse(NotFoundException ex) {
        ApiError err = new ApiError(404, "Not Found", ex.getMessage(), uriInfo.getPath());
        return Response.status(Response.Status.NOT_FOUND).entity(err).build();
    }
}
