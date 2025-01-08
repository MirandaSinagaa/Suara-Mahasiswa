<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Halaman Penutup</title>
    <link rel="stylesheet" href="CSS/style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="penutup">
    <!-- Navbar -->
    <div class="navbar">
        <div class="logo-section">
            <img src="Assets/Logo-Undiksha.png" alt="Logo Undiksha" class="logo">
            <span>Universitas Pendidikan Ganesha<br>Fakultas Teknik dan Kejuruan</span>
        </div>
    </div>

    <!-- Hero Section -->
    <div class="hero">
        <h1>SuaraMahasiswa.</h1>
        <p>Pemilihan Ketua dan Wakil Ketua BEM Fakultas Teknik dan Kejuruan Undiksha</p>
        <p>Terima kasih atas partisipasi Anda</p>
        <a href="welcome.jsp" class="btn">KEMBALI</a>
    </div>

    <!-- Chart Section -->
    <div class="chart-section">
        <h2>Hasil Voting</h2>
        <div class="charts">
            <!-- Bar Chart -->
            <canvas id="voteBarChart" class="chart"></canvas>
            <!-- Pie Chart -->
            <canvas id="votePieChart" class="chart"></canvas>
        </div>
        <!-- Keterangan Paslon -->
        <div class="paslon-info">
            <p><b>Paslon 1:</b> Nama Paslon 1 - Agenda Paslon 1</p>
            <p><b>Paslon 2:</b> Nama Paslon 2 - Agenda Paslon 2</p>
        </div>
    </div>

    <script>
        // Fetch voting data from the server
        fetch("vote-data")
            .then(response => response.json())
            .then(data => {
                const labels = Object.keys(data); // Nomor paslon
                const votes = Object.values(data); // Jumlah suara

                // Bar Chart
                const barCtx = document.getElementById('voteBarChart').getContext('2d');
                new Chart(barCtx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Jumlah Suara',
                            data: votes,
                            backgroundColor: ['#FF6384', '#36A2EB'],
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });

                // Pie Chart
                const pieCtx = document.getElementById('votePieChart').getContext('2d');
                new Chart(pieCtx, {
                    type: 'pie',
                    data: {
                        labels: labels,
                        datasets: [{
                            data: votes,
                            backgroundColor: ['#FF6384', '#36A2EB'],
                        }]
                    }
                });
            })
            .catch(error => console.error('Error fetching voting data:', error));
    </script>
</body>
</html>
