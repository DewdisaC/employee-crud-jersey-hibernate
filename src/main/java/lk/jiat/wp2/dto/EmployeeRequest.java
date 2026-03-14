package lk.jiat.wp2.dto;

import javax.validation.constraints.*;
import java.time.LocalDate;

public class EmployeeRequest {

    @NotBlank(message = "Name is required")
    @Size(max = 100)
    public String name;

    @NotBlank(message = "Position is required")
    @Size(max = 100)
    public String position;

    @NotBlank(message = "Department is required")
    @Size(max = 100)
    public String department;

    @NotNull(message = "Hire date is required")
    @PastOrPresent(message = "Hire date must be today or in the past")
    public LocalDate hireDate;

    @NotNull(message = "Salary is required")
    @Positive(message = "Salary must be greater than 0")
    public Double salary;
}
