<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html>
<head>
    <title>Employees | Dashboard</title>
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f6f8fb; }
        .mono { font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace; }
        .card { border: 0; border-radius: 16px; }
        .btn { border-radius: 12px; }
        .table thead th { white-space: nowrap; }
        .table td { vertical-align: middle; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg bg-white border-bottom">
    <div class="container py-2">
        <a class="navbar-brand fw-bold" href="index.jsp">Employee CRUD</a>

        <div class="ms-auto d-flex align-items-center gap-2">
            <span class="badge rounded-pill text-bg-secondary" id="roleBadge">Not logged</span>
            <button class="btn btn-outline-primary btn-sm" id="btnLoginOpen" type="button">Login</button>
            <button class="btn btn-outline-danger btn-sm d-none" id="btnLogout" type="button">Logout</button>
        </div>
    </div>
</nav>

<div class="container py-4">

    <!-- Top stats -->
    <div class="row g-3 mb-3">
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <div class="text-muted small">Total Employees</div>
                    <div class="fs-3 fw-bold" id="statTotal">0</div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <div class="text-muted small">Current User</div>
                    <div class="fs-5 fw-semibold" id="currentUser">-</div>
                    <div class="text-muted small" id="currentRole">-</div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <div class="text-muted small">API</div>
                    <div class="mono">/api/employees</div>
                    <div class="text-muted small mt-1">Login required for access</div>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-3">
        <div class="col-lg-9">
            <div class="card shadow-sm">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-start flex-wrap gap-2">
                        <div>
                            <h5 class="mb-1">Employees</h5>
                            <div class="text-muted small">Search, add, update, delete employees.</div>
                        </div>
                        <div class="d-flex gap-2">
                            <button class="btn btn-outline-secondary btn-sm" id="btnRefresh" type="button">Refresh</button>
                            <button class="btn btn-primary btn-sm" id="btnAdd" type="button" disabled>Add Employee</button>
                        </div>
                    </div>

                    <hr/>

                    <!-- Search -->
                    <div class="row g-2 mb-3">
                        <div class="col-md-3">
                            <input class="form-control form-control-sm" id="qName" placeholder="Name">
                        </div>
                        <div class="col-md-3">
                            <input class="form-control form-control-sm" id="qPosition" placeholder="Position">
                        </div>
                        <div class="col-md-3">
                            <input class="form-control form-control-sm" id="qDepartment" placeholder="Department">
                        </div>
                        <div class="col-md-3">
                            <input class="form-control form-control-sm" id="qHireDate" type="date">
                        </div>
                        <div class="col-12 d-flex gap-2">
                            <button class="btn btn-sm btn-outline-primary" id="btnSearch" type="button">Search</button>
                            <button class="btn btn-sm btn-outline-danger" id="btnClear" type="button">Clear</button>
                        </div>
                    </div>

                    <div id="alertBox"></div>

                    <div class="table-responsive">
                        <table class="table table-sm table-hover align-middle">
                            <thead class="table-light">
                            <tr>
                                <th style="width:70px;">ID</th>
                                <th>Name</th>
                                <th>Position</th>
                                <th>Department</th>
                                <th style="width:140px;">Hire Date</th>
                                <th style="width:120px;">Salary</th>
                                <th style="width:160px;" class="text-end">Actions</th>
                            </tr>
                            </thead>
                            <tbody id="empBody">
                            <tr><td colspan="7" class="text-muted">Please login to load employees.</td></tr>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>

        <!-- Accounts card -->
        <div class="col-lg-3">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h6 class="mb-2">Accounts</h6>
                    <div class="small text-muted mb-3">Use these for assessment demo.</div>

                    <div class="alert alert-info small mb-0">
                        <b>Admin</b>: <span class="mono">admin / admin123</span><br/>
                        <b>User</b>: <span class="mono">user / user123</span><br/>
                        <hr class="my-2"/>
                        Admin can Add/Edit/Delete.<br/>
                        User can View only.
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Login Modal -->
<div class="modal fade" id="loginModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content border-0 shadow" style="border-radius:16px;">
            <div class="modal-header">
                <h5 class="modal-title">Login (Basic Auth)</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="mb-2">
                    <label class="form-label">Username</label>
                    <input class="form-control" id="username" placeholder="admin or user">
                </div>
                <div class="mb-2">
                    <label class="form-label">Password</label>
                    <input class="form-control" id="password" type="password" placeholder="admin123 or user123">
                </div>
                <div class="text-muted small">
                    Tip: login then press Refresh.
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                <button class="btn btn-primary" id="btnDoLogin" type="button">Login</button>
            </div>
        </div>
    </div>
</div>

<!-- Add/Edit Modal -->
<div class="modal fade" id="editModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content border-0 shadow" style="border-radius:16px;">
            <div class="modal-header">
                <h5 class="modal-title" id="editTitle">Add Employee</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="empId">

                <div class="mb-2">
                    <label class="form-label">Name</label>
                    <input class="form-control" id="empName">
                </div>
                <div class="mb-2">
                    <label class="form-label">Position</label>
                    <input class="form-control" id="empPosition">
                </div>
                <div class="mb-2">
                    <label class="form-label">Department</label>
                    <input class="form-control" id="empDepartment">
                </div>
                <div class="mb-2">
                    <label class="form-label">Hire Date</label>
                    <input class="form-control" id="empHireDate" type="date">
                </div>
                <div class="mb-2">
                    <label class="form-label">Salary</label>
                    <input class="form-control" id="empSalary" type="number" step="0.01">
                </div>

                <div class="text-muted small">Date format: yyyy-MM-dd</div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <button class="btn btn-primary" id="btnSave" type="button">Save</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Always use absolute base from current app
    const API = window.location.origin + window.location.pathname.replace(/\\/[^\\/]*$/, '') + "/api/employees";

    let authHeader = null;
    let role = null; // "ADMIN" or "USER"
    let loggedUser = null;

    const empBody = document.getElementById("empBody");

    function showAlert(type, message) {
        document.getElementById("alertBox").innerHTML =
            `<div class="alert alert-${type} py-2 small">${message}</div>`;
        setTimeout(() => document.getElementById("alertBox").innerHTML = "", 3500);
    }

    function setLoggedUser(username) {
        loggedUser = username;
        role = (username === "admin") ? "ADMIN" : "USER";

        document.getElementById("currentUser").innerText = loggedUser || "-";
        document.getElementById("currentRole").innerText = role || "-";
        document.getElementById("roleBadge").innerText = role ? role : "Not logged";

        document.getElementById("btnAdd").disabled = (role !== "ADMIN");
        document.getElementById("btnLogout").classList.toggle("d-none", !role);
        document.getElementById("btnLoginOpen").classList.toggle("d-none", !!role);
    }

    function buildHeaders(isJson) {
        const headers = { "Accept": "application/json" };
        if (authHeader) headers["Authorization"] = authHeader;
        if (isJson) headers["Content-Type"] = "application/json";
        return headers;
    }

    function renderTable(data) {
        if (!data || data.length === 0) {
            empBody.innerHTML = `<tr><td colspan="7" class="text-muted">No employees found</td></tr>`;
            document.getElementById("statTotal").innerText = "0";
            return;
        }

        document.getElementById("statTotal").innerText = String(data.length);

        const disabledAttr = (role !== "ADMIN") ? "disabled" : "";

        empBody.innerHTML = data.map(e => `
            <tr>
                <td>${e.id}</td>
                <td>${escapeHtml(e.name)}</td>
                <td>${escapeHtml(e.position)}</td>
                <td>${escapeHtml(e.department)}</td>
                <td class="mono">${e.hireDate}</td>
                <td class="mono">${Number(e.salary).toFixed(2)}</td>
                <td class="text-end">
                    <button class="btn btn-outline-primary btn-sm"
                            type="button"
                            onclick='openEdit(${JSON.stringify(e)})'
                            ${disabledAttr}>Edit</button>
                    <button class="btn btn-outline-danger btn-sm"
                            type="button"
                            onclick="deleteEmp(${e.id})"
                            ${disabledAttr}>Delete</button>
                </td>
            </tr>
        `).join("");
    }

    async function loadEmployees(url = API) {
        empBody.innerHTML = `<tr><td colspan="7" class="text-muted">Loading...</td></tr>`;

        try {
            const res = await fetch(url, { headers: buildHeaders(false) });

            if (res.status === 401) {
                empBody.innerHTML = `<tr><td colspan="7" class="text-danger">401 Unauthorized - Please login</td></tr>`;
                showAlert("danger", "Unauthorized. Click Login and use admin/admin123 or user/user123.");
                return;
            }

            if (!res.ok) {
                const txt = await res.text();
                empBody.innerHTML = `<tr><td colspan="7" class="text-danger">Error ${res.status}</td></tr>`;
                showAlert("danger", "Error " + res.status + ": " + txt);
                return;
            }

            const data = await res.json();
            renderTable(data);
        } catch (e) {
            empBody.innerHTML = `<tr><td colspan="7" class="text-danger">Connection error</td></tr>`;
            showAlert("danger", "Connection error: " + e.message);
        }
    }

    function buildQuery() {
        const name = document.getElementById("qName").value.trim();
        const position = document.getElementById("qPosition").value.trim();
        const department = document.getElementById("qDepartment").value.trim();
        const hireDate = document.getElementById("qHireDate").value;

        const params = new URLSearchParams();
        if (name) params.append("name", name);
        if (position) params.append("position", position);
        if (department) params.append("department", department);
        if (hireDate) params.append("hireDate", hireDate);

        const qs = params.toString();
        return qs ? ("?" + qs) : "";
    }

    function clearSearch() {
        document.getElementById("qName").value = "";
        document.getElementById("qPosition").value = "";
        document.getElementById("qDepartment").value = "";
        document.getElementById("qHireDate").value = "";
        loadEmployees();
    }

    function openAdd() {
        if (role !== "ADMIN") {
            showAlert("warning", "Only ADMIN can add employees.");
            return;
        }

        document.getElementById("editTitle").innerText = "Add Employee";
        document.getElementById("empId").value = "";
        document.getElementById("empName").value = "";
        document.getElementById("empPosition").value = "";
        document.getElementById("empDepartment").value = "";
        document.getElementById("empHireDate").value = "";
        document.getElementById("empSalary").value = "";

        new bootstrap.Modal(document.getElementById('editModal')).show();
    }

    function openEdit(emp) {
        if (role !== "ADMIN") return;

        document.getElementById("editTitle").innerText = "Edit Employee";
        document.getElementById("empId").value = emp.id;
        document.getElementById("empName").value = emp.name;
        document.getElementById("empPosition").value = emp.position;
        document.getElementById("empDepartment").value = emp.department;
        document.getElementById("empHireDate").value = emp.hireDate;
        document.getElementById("empSalary").value = emp.salary;

        new bootstrap.Modal(document.getElementById('editModal')).show();
    }

    async function saveEmployee() {
        if (role !== "ADMIN") {
            showAlert("warning", "Only ADMIN can save employees.");
            return;
        }

        const id = document.getElementById("empId").value;
        const payload = {
            name: document.getElementById("empName").value.trim(),
            position: document.getElementById("empPosition").value.trim(),
            department: document.getElementById("empDepartment").value.trim(),
            hireDate: document.getElementById("empHireDate").value,
            salary: Number(document.getElementById("empSalary").value)
        };

        const isUpdate = !!id;
        const url = isUpdate ? (API + "/" + id) : API;
        const method = isUpdate ? "PUT" : "POST";

        try {
            const res = await fetch(url, {
                method,
                headers: buildHeaders(true),
                body: JSON.stringify(payload)
            });

            if (res.status === 401) { showAlert("danger", "Unauthorized. Please login again."); return; }
            if (res.status === 403) { showAlert("danger", "Forbidden. ADMIN only."); return; }

            if (!res.ok) {
                const txt = await res.text();
                showAlert("danger", "Error " + res.status + ": " + txt);
                return;
            }

            bootstrap.Modal.getInstance(document.getElementById('editModal')).hide();
            showAlert("success", isUpdate ? "Employee updated!" : "Employee added!");
            await loadEmployees();

        } catch (e) {
            showAlert("danger", "Save error: " + e.message);
        }
    }

    async function deleteEmp(id) {
        if (role !== "ADMIN") {
            showAlert("warning", "Only ADMIN can delete employees.");
            return;
        }

        if (!confirm("Delete employee ID " + id + "?")) return;

        try {
            const res = await fetch(API + "/" + id, {
                method: "DELETE",
                headers: buildHeaders(false)
            });

            if (res.status === 401) { showAlert("danger", "Unauthorized. Please login again."); return; }
            if (res.status === 403) { showAlert("danger", "Forbidden. ADMIN only."); return; }

            if (res.status !== 204) {
                const txt = await res.text();
                showAlert("danger", "Error " + res.status + ": " + txt);
                return;
            }

            showAlert("success", "Employee deleted!");
            await loadEmployees();

        } catch (e) {
            showAlert("danger", "Delete error: " + e.message);
        }
    }

    function escapeHtml(str) {
        if (!str) return "";
        return str.replaceAll("&", "&amp;")
            .replaceAll("<", "&lt;")
            .replaceAll(">", "&gt;")
            .replaceAll('"', "&quot;")
            .replaceAll("'", "&#039;");
    }

    // Wire buttons safely (no onclick issues)
    document.getElementById("btnLoginOpen").addEventListener("click", () => {
        new bootstrap.Modal(document.getElementById('loginModal')).show();
    });

    document.getElementById("btnDoLogin").addEventListener("click", async () => {
        const u = document.getElementById("username").value.trim();
        const p = document.getElementById("password").value;

        if (!u || !p) { showAlert("warning", "Enter username and password"); return; }

        authHeader = "Basic " + btoa(u + ":" + p);
        setLoggedUser(u);

        bootstrap.Modal.getInstance(document.getElementById('loginModal')).hide();
        showAlert("success", "Logged in as " + u + " (" + role + ")");

        await loadEmployees();
    });

    document.getElementById("btnLogout").addEventListener("click", () => {
        authHeader = null;
        role = null;
        loggedUser = null;
        setLoggedUser(null);
        document.getElementById("statTotal").innerText = "0";
        empBody.innerHTML = `<tr><td colspan="7" class="text-muted">Please login to load employees.</td></tr>`;
        showAlert("info", "Logged out");
    });

    document.getElementById("btnRefresh").addEventListener("click", () => loadEmployees());
    document.getElementById("btnAdd").addEventListener("click", () => openAdd());
    document.getElementById("btnSave").addEventListener("click", () => saveEmployee());

    document.getElementById("btnSearch").addEventListener("click", () => {
        const qs = buildQuery();
        loadEmployees(API + qs);
    });

    document.getElementById("btnClear").addEventListener("click", () => clearSearch());

    // Initial state
    setLoggedUser(null);
</script>

</body>
</html>