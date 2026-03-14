package lk.jiat.wp2.dao;

import lk.jiat.wp2.entity.Employee;
import lk.jiat.wp2.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import javax.persistence.criteria.*;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public class EmployeeDAO {

    public Employee save(Employee employee) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.save(employee);
            tx.commit();
            return employee;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }

    public Optional<Employee> findById(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return Optional.ofNullable(session.get(Employee.class, id));
        }
    }

    public List<Employee> findAll(String name, String position, String department, LocalDate hireDate) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            CriteriaBuilder cb = session.getCriteriaBuilder();
            CriteriaQuery<Employee> cq = cb.createQuery(Employee.class);
            Root<Employee> root = cq.from(Employee.class);

            Predicate predicate = cb.conjunction();

            if (name != null && !name.isBlank()) {
                predicate = cb.and(predicate, cb.like(cb.lower(root.get("name")), "%" + name.toLowerCase() + "%"));
            }
            if (position != null && !position.isBlank()) {
                predicate = cb.and(predicate, cb.like(cb.lower(root.get("position")), "%" + position.toLowerCase() + "%"));
            }
            if (department != null && !department.isBlank()) {
                predicate = cb.and(predicate, cb.like(cb.lower(root.get("department")), "%" + department.toLowerCase() + "%"));
            }
            if (hireDate != null) {
                predicate = cb.and(predicate, cb.equal(root.get("hireDate"), hireDate));
            }

            cq.select(root).where(predicate).orderBy(cb.asc(root.get("id")));
            return session.createQuery(cq).getResultList();
        }
    }

    public Employee update(Employee employee) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.update(employee);
            tx.commit();
            return employee;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }

    public void delete(Employee employee) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.delete(employee);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }
}
