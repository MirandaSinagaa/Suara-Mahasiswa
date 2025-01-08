<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/style.css">
    <title>Login - SuaraMahasiswa</title>
</head>
<body>
    <div class="navbar">
        <div class="logo-section">
            <img src="Assets/Logo-Undiksha.png" alt="Logo Undiksha">
            <span>Universitas Pendidikan Ganesha<br>Fakultas Teknik dan Kejuruan</span>
        </div>
    </div>

    <div class="hero">
        <h1>SuaraMahasiswa.</h1>
        <p>Pemilihan Ketua dan Wakil Ketua BEM Fakultas Teknik dan Kejuruan Undiksha</p>
    </div>

    <div class="login-container">
        <h1>Login</h1>
        <p>Silahkan Login untuk melakukan voting</p>
        
        <% if (request.getAttribute("errorMessage") != null) { %>  <!-- encapsulation -->
            <div class="error-message">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>
        
        <form action="login" method="post">
            <input type="email" name="email" id="email" class="email-input" required placeholder="Email">
            
            <div style="position: fixed postition;">
                <input type="password" name="password" id="password" required placeholder="Password">
                <label style="display: block; margin-top: 5px;">
                    <input type="checkbox" id="togglePassword" onclick="togglePasswordVisibility()"> 
                    Tampilkan Password
                </label>
            </div>
            
            <div class="form-footer">
                <a href="welcome.jsp" class="back-btn">⬅ Kembali</a>
                <button type="submit">Login</button>
            </div>
        </form>
    </div>

    <script>
        function togglePasswordVisibility() {
            const passwordField = document.getElementById('password');
            const toggleCheckbox = document.getElementById('togglePassword');
            passwordField.type = toggleCheckbox.checked ? 'text' : 'password';
        }
    </script>
</body>
</html>