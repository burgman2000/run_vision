document.addEventListener("DOMContentLoaded", () => { 
  // 初期データを取得してグラフを描画
  updateChart();

  const form = document.getElementById("form");
  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    const ranDistance = document.getElementById("ran-distance").value;
    // データをサーバーに送信
    const response = await fetch("/runnings", {// response = { "distances": [20, 30, 40, 50, 60], "months": ["2023-11", "2023-12", "2024-01", "2024-02", "2024-03"]}
      method: "POST",
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
          .content,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ running: { ran_distance: Number(ranDistance) } }),
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
  const response = await fetch("/runnings/json_index");
  const data = await response.json();
  // データから円グラフを描画
  drawChart(data);
}

let myChart;

function drawChart(data) {
  const ctx = document.getElementById("myChart").getContext("2d");// <canvas id="myChart"></canvas>

  if (myChart) {
    // すでにチャートが存在する場合は、データを更新する
    myChart.data.labels = data.user_name;  //user_name//ラベル：月 // data = { "distances": [20, 30, 40, 50, 60], "months": ["2023-11", "2023-12", "2024-01", "2024-02", "2024-03"]}
    console.log(data.user_name);
    myChart.data.datasets[0].data = data.by_user_distances; //by_user_distances//データ：距離
    console.log(data.by_user_distances);

    myChart.update();
  } else {
    // チャートを新規作成する場合
    myChart = new Chart(ctx, {
      type: "pie",
      data: {
        labels: data.user_name,// data = { "distances": [20, 30, 40, 50, 60], "months": ["2023-11", "2023-12", "2024-01", "2024-02", "2024-03"]}
        datasets: [
          {
            data: data.by_user_distances,// [20, 30, 40, 50, 60]
            backgroundColor: [
              "rgba(255, 99, 132, 0.7)",
              "rgba(54, 162, 235, 0.7)",
              "rgba(255, 206, 86, 0.7)",
              "rgba(75, 192, 192, 0.7)",
              "rgba(153, 102, 255, 0.7)",
            ],
            borderColor: [
              "rgba(255, 99, 132, 1)",
              "rgba(54, 162, 235, 1)",
              "rgba(255, 206, 86, 1)",
              "rgba(75, 192, 192, 1)",
              "rgba(153, 102, 255, 1)",
            ],
            borderWidth: 1,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        legend: {
          position: "right",
        },
      },
    });
  }
}
