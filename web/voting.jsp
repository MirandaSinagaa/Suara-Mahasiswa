<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Voting Kandidat</title>
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <%
        // Check if user is logged in
        if (session.getAttribute("NIM") == null) {   //encapsulation
            response.sendRedirect("login.jsp");
            return;
        }
    %>
    
    <header>
        <div class="user-info">
            Welcome, <%= session.getAttribute("namaMahasiswa") %>  
        </div>
    </header>

    <div class="container">
        <h2>VOTING KANDIDAT</h2>
        
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } else { %>
            <div class="instruction">
                Silakan pilih pasangan calon di bawah ini:
            </div>
        <% } %>
        
        <% if (request.getAttribute("errorMessage") == null) { %>
            <div class="card">
                <img src="Assets/kandidat1.jpg" alt="Pasangan Calon 1">
                <button onclick="selectCandidate(this, '1')">Pilih</button>
            </div>

            <div class="card">
                <img src="Assets/kandidat2.jpg" alt="Pasangan Calon 2">
                <button onclick="selectCandidate(this, '2')">Pilih</button>
            </div>

            <button class="vote-button" onclick="submitVote()" disabled>VOTING</button>
            
            <form id="voteForm" action="voting" method="post" style="display:none;">
                <input type="hidden" name="NIM" value="<%= session.getAttribute("NIM") %>">
                <input type="hidden" name="nomorPaslon" id="selectedPaslon" value="">
            </form>
        <% } %>
    </div>

    <script>
        let selectedCandidate = null;
        
        function selectCandidate(button, candidateId) {
            document.querySelectorAll(".card button").forEach(btn => {
                btn.classList.remove("selected");
            });
            button.classList.add("selected");
            selectedCandidate = candidateId;
            document.querySelector(".vote-button").disabled = false;
        }
        
        function submitVote() {
            if (selectedCandidate) {
                document.getElementById("selectedPaslon").value = selectedCandidate;
                document.getElementById("voteForm").submit();
            }
        }
    </script>
</body>
</html>
