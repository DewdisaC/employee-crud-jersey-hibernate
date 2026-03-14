package lk.jiat.wp2.entity;

import javax.persistence.*;
import javax.validation.constraints.*;
import java.time.LocalDate;

@Entity
@Table(name = "employees")
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Name is required")
    @Size(max = 100, message = "Name must be <= 100 characters")
    @Column(nullable = false, length = 100)
    private String name;

    @NotBlank(message = "Position is required")
    @Size(max = 100, message = "Position must be <= 100 characters")
    @Column(nullable = false, length = 100)
    private String position;

    @NotBlank(message = "Department is required")
    @Size(max = 100, message = "Department must be <= 100 characters")
    @Column(nullable = false, length = 100)
    private String department;

    @NotNull(message = "Hire date is required")
    @PastOrPresent(message = "Hire date must be today or in the past")
    @Column(name = "hire_date", nullable = false)
    private LocalDate hireDate;

    @NotNull(message = "Salary is required")
    @Positive(message = "Salary must be greater than 0")
    @Column(nullable = false)
    private Double salary;

    public Employee() {}

    public Employee(String name, String position, String department, LocalDate hireDate, Double salary) {
        this.name = name;
        this.position = position;
        this.department = department;
        this.hireDate = hireDate;
        this.salary = salary;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public LocalDate getHireDate() { return hireDate; }
    public void setHireDate(LocalDate hireDate) { this.hireDate = hireDate; }

    public Double getSalary() { return salary; }
    public void setSalary(Double salary) { this.salary = salary; }
}
