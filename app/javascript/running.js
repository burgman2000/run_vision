document.addEventListener('DOMContentLoaded', () => {
  // 初期データを取得してグラフを描画
  updateChart();

  const form = document.getElementById("form");
  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    const ranDistance = document.getElementById("ran-distance").value;
    
    // データをサーバーに送信
    const response = await fetch("/runnings", {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: `running[ran_distance]=${ranDistance}`
    });

    if (response.ok) {
      // データが正常に保存された場合、グラフを更新
      updateChart();
      form.reset();
    } else {
      console.error("Failed to save data:", response.statusText);
    }
  });
});

async function updateChart() {
  // サーバーからデータを取得
  const response = await fetch("/runnings");
  const data = await response.json();

  // データから円グラフを描画
  drawChart(data);
}

function drawChart(data) {
  const ctx = document.getElementById("myChart").getContext("2d");

  // データがない場合は円グラフを非表示にするなどの処理も追加できます

  const myChart = new Chart(ctx, {
    type: "pie",
    data: {
      labels: data.labels,
      datasets: [{
        data: data.values,
        backgroundColor: [
          'rgba(255, 99, 132, 0.7)',
          'rgba(54, 162, 235, 0.7)',
          'rgba(255, 206, 86, 0.7)',
          'rgba(75, 192, 192, 0.7)',
          'rgba(153, 102, 255, 0.7)',
        ],
        borderColor: [
          'rgba(255, 99, 132, 1)',
          'rgba(54, 162, 235, 1)',
          'rgba(255, 206, 86, 1)',
          'rgba(75, 192, 192, 1)',
          'rgba(153, 102, 255, 1)',
        ],
        borderWidth: 1
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      legend: {
        position: 'right'
      }
    }
  });
}