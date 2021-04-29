import Chart from 'chart.js/auto';

class TempChart {
  constructor(ctx, labels, values) {
    this.chart = new Chart(ctx, {
      type: "line",
      data: {
        labels: labels,
        datasets: [
          {
            label: "Temperature",
            data: values,
            borderColor: "#4c51bf",
          },
        ],
      },
      options: {
        plugins: {
          legend: {
            display: false
          }
        },
        scales: {
          x: {
            ticks: {
              display: false
            }
          },
          y: {
            suggestedMin: 20,
            suggestedMax: 80
          }
        },
      },
    });
  }

  addPoint(label, value) {
    const labels = this.chart.data.labels;
    const data = this.chart.data.datasets[0].data;

    labels.push(label);
    data.push(value);

    if (data.length > 12) {
      data.shift();
      labels.shift();
    }

    this.chart.update();
  }
}

class MemChart {
  constructor(ctx, labels, values) {
    this.chart = new Chart(ctx, {
      type: "line",
      data: {
        labels: labels,
        datasets: [
          {
            label: "Memory",
            data: values,
            borderColor: "#4c51bf",
          },
        ],
      },
      options: {
        plugins: {
          legend: {
            display: false
          }
        },
        scales: {
          x: {
            ticks: {
              display: false
            }
          },
          y: {
            min: 0,
            max: 100
          }
        },
      },
    });
  }

  addPoint(label, value) {
    const labels = this.chart.data.labels;
    const data = this.chart.data.datasets[0].data;

    labels.push(label);
    data.push(value);

    if (data.length > 12) {
      data.shift();
      labels.shift();
    }

    this.chart.update();
  }
}

export default MemChart;
export default TempChart;
