<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Employee Management System</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      background: linear-gradient(135deg, #eef2ff, #f8fafc);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    .main-card {
      border: none;
      border-radius: 20px;
      box-shadow: 0 20px 50px rgba(0, 0, 0, 0.08);
    }

    .btn {
      border-radius: 12px;
      padding: 10px 18px;
      font-weight: 500;
    }

    .btn-primary {
      background: linear-gradient(135deg, #2563eb, #1e40af);
      border: none;
    }

    .btn-primary:hover {
      opacity: 0.9;
    }

    .info-box {
      background: linear-gradient(135deg, #dbeafe, #bfdbfe);
      border-radius: 16px;
      padding: 25px;
      border: 1px solid #93c5fd;
    }

    footer {
      margin-top: auto;
      padding: 20px 0;
      text-align: center;
      color: #64748b;
      font-size: 14px;
    }

    .title-highlight {
      background: #2563eb;
      color: white;
      padding: 6px 14px;
      border-radius: 10px;
    }
  </style>
</head>

<body>

<div class="container py-5">

  <div class="card main-card p-5">

    <h2 class="fw-bold mb-2">
      <span class="title-highlight">Employee</span>
      Management System
    </h2>

    <p class="text-muted mb-4">
      Jersey REST API + Hibernate + MySQL + Basic Authentication
    </p>

    <div class="mb-4">
      <a href="employees.html" class="btn btn-primary me-2">
        Open Employee Dashboard
      </a>

      <a href="api/health" target="_blank" class="btn btn-outline-secondary">
        API Health
      </a>
    </div>

    <hr class="my-4">

    <div class="info-box">
      <h5 class="fw-bold mb-3">Login (Basic Authentication)</h5>

      <p class="mb-1">
        <strong>Admin:</strong>
        <span class="text-danger">admin</span> /
        <span class="text-danger">admin123</span>
      </p>

      <p class="mb-0">
        <strong>User:</strong>
        <span class="text-danger">user</span> /
        <span class="text-danger">user123</span>
      </p>
    </div>

  </div>

</div>

<footer>
  © Employee CRUD Project | Java • Jersey • Hibernate • MySQL • Tomcat 9
</footer>

</body>
</html>