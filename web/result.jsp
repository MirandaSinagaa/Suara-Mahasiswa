<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hasil Voting</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <h1>Hasil Voting</h1>
    <canvas id="voteChart" width="400" height="200"></canvas>
    <script>
        const ctx = document.getElementById('voteChart').getContext('2d');
        let voteChart;

        function updateChart() {
            fetch('vote-data')
                .then(response => response.json())
                .then(data => {
                    const labels = Object.keys(data).map(paslon => `Paslon ${paslon}`);   <!-- abstraction -->
                    const values = Object.values(data);

                    if (voteChart) {
                        voteChart.data.labels = labels;
                        voteChart.data.datasets[0].data = values;
                        voteChart.update();
                    } else {
                        voteChart = new Chart(ctx, {
                            type: 'pie',
                            data: {
                                labels: labels,
                                datasets: [{
                                    label: 'Jumlah Vote',
                                    data: values,
                                    backgroundColor: [
                                        'rgba(75, 192, 192, 0.2)',
                                        'rgba(255, 99, 132, 0.2)',
                                        'rgba(255, 205, 86, 0.2)',
                                        'rgba(54, 162, 235, 0.2)'
                                    ],
                                    borderColor: [
                                        'rgba(75, 192, 192, 1)',
                                        'rgba(255, 99, 132, 1)',
                                        'rgba(255, 205, 86, 1)',
                                        'rgba(54, 162, 235, 1)'
                                    ],
                                    borderWidth: 1
                                }]
                            }
                        });
                    }
                });
        }

        // Update chart every 5 seconds
        setInterval(updateChart, 5000);
        updateChart();
    </script>
</body>
</html>
