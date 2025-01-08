<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hasil Voting</title>
    <link rel="stylesheet" href="CSS/style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            padding: 20px;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            text-align: center;
        }
        canvas {
            max-width: 600px;
            margin: 0 auto;
        }
        .error-message {
            color: red;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Hasil Voting</h1>

        <% 
            List<String> candidateNames = (List<String>) request.getAttribute("candidateNames");
            List<Integer> voteCounts = (List<Integer>) request.getAttribute("voteCounts");
            Integer totalVotes = (Integer) request.getAttribute("totalVotes");
            if (candidateNames != null && voteCounts != null && totalVotes != null) {
        %>

        <canvas id="voteChart"></canvas>

        <script>
            const candidateNames = <%= candidateNames.toString() %>.split(",");
            const voteCounts = <%= voteCounts.toString() %>.split(",").map(Number);
            const totalVotes = <%= totalVotes %>;

            const data = {
                labels: candidateNames,
                datasets: [{
                    label: 'Jumlah Suara',
                    data: voteCounts,
                    backgroundColor: ['#FF5733', '#33FF57', '#3357FF', '#FF33A1', '#A1FF33'],
                    borderColor: ['#FF5733', '#33FF57', '#3357FF', '#FF33A1', '#A1FF33'],
                    borderWidth: 1
                }]
            };

            const options = {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function(tooltipItem) {
                                const percentage = (tooltipItem.raw / totalVotes * 100).toFixed(2);
                                return `${tooltipItem.label}: ${tooltipItem.raw} suara (${percentage}%)`;
                            }
                        }
                    }
                }
            };

            const ctx = document.getElementById('voteChart').getContext('2d');
            new Chart(ctx, {
                type: 'pie',
                data: data,
                options: options
            });
        </script>

        <% } else { %>
            <div class="error-message">
                <p>Data hasil voting tidak tersedia.</p>
            </div>
        <% } %>
    </div>
</body>
</html>
