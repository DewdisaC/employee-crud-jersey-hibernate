package lk.jiat.wp2.service;

import lk.jiat.wp2.dao.EmployeeDAO;
import lk.jiat.wp2.dto.EmployeeRequest;
import lk.jiat.wp2.entity.Employee;
import lk.jiat.wp2.exception.NotFoundException;

import java.time.LocalDate;
import java.util.List;

public class EmployeeService {

    private final EmployeeDAO dao = new EmployeeDAO();

    public Employee create(EmployeeRequest req) {
        Employee e = new Employee(req.name, req.position, req.department, req.hireDate, req.salary);
        return dao.save(e);
    }

    public Employee get(Long id) {
        return dao.findById(id).orElseThrow(() -> new NotFoundException("Employee not found: " + id));
    }

    public List<Employee> list(String name, String position, String department, LocalDate hireDate) {
        return dao.findAll(name, position, department, hireDate);
    }

    public Employee update(Long id, EmployeeRequest req) {
        Employee existing = get(id);
        existing.setName(req.name);
        existing.setPosition(req.position);
        existing.setDepartment(req.department);
        existing.setHireDate(req.hireDate);
        existing.setSalary(req.salary);
        return dao.update(existing);
    }

    public void delete(Long id) {
        Employee existing = get(id);
        dao.delete(existing);
    }
}
