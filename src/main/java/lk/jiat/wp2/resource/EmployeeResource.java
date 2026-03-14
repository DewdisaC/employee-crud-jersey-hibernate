package lk.jiat.wp2.resource;

import lk.jiat.wp2.dto.EmployeeRequest;
import lk.jiat.wp2.dto.EmployeeResponse;
import lk.jiat.wp2.entity.Employee;
import lk.jiat.wp2.service.EmployeeService;

import javax.annotation.security.RolesAllowed;
import javax.validation.Valid;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Path("/employees")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class EmployeeResource {

    private final EmployeeService service = new EmployeeService();

    @POST
    @RolesAllowed("ADMIN")
    public Response create(@Valid EmployeeRequest req) {
        Employee e = service.create(req);
        return Response.status(Response.Status.CREATED).entity(toResponse(e)).build();
    }

    @GET
    @RolesAllowed({"ADMIN", "USER"})
    public Response list(@QueryParam("name") String name,
                         @QueryParam("position") String position,
                         @QueryParam("department") String department,
                         @QueryParam("hireDate") String hireDateStr) {

        LocalDate hireDate = null;
        if (hireDateStr != null && !hireDateStr.isBlank()) {
            hireDate = LocalDate.parse(hireDateStr); // yyyy-MM-dd
        }

        List<EmployeeResponse> out = service.list(name, position, department, hireDate)
                .stream().map(this::toResponse).collect(Collectors.toList());
        return Response.ok(out).build();
    }

    @GET
    @Path("/{id}")
    @RolesAllowed({"ADMIN", "USER"})
    public Response get(@PathParam("id") Long id) {
        Employee e = service.get(id);
        return Response.ok(toResponse(e)).build();
    }

    @PUT
    @Path("/{id}")
    @RolesAllowed("ADMIN")
    public Response update(@PathParam("id") Long id, @Valid EmployeeRequest req) {
        Employee e = service.update(id, req);
        return Response.ok(toResponse(e)).build();
    }

    @DELETE
    @Path("/{id}")
    @RolesAllowed("ADMIN")
    public Response delete(@PathParam("id") Long id) {
        service.delete(id);
        return Response.noContent().build();
    }

    private EmployeeResponse toResponse(Employee e) {
        EmployeeResponse r = new EmployeeResponse();
        r.id = e.getId();
        r.name = e.getName();
        r.position = e.getPosition();
        r.department = e.getDepartment();
        r.hireDate = e.getHireDate();
        r.salary = e.getSalary();
        return r;
    }
}
