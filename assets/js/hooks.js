import LineChart from "./line-chart"

let Hooks = {}

Hooks.TempChart = {
  mounted() {
    const { labels, values } = JSON.parse(this.el.dataset.chartData)
    this.chart = new LineChart(this.el, labels, values)

    this.handleEvent("new-temp-point", ({ label, value }) => {
      this.chart.addPoint(label, value)
    })
  }
}

Hooks.MemChart = {
  mounted() {
    const { labels, values } = JSON.parse(this.el.dataset.chartData)
    this.chart = new LineChart(this.el, labels, values)

    this.handleEvent("new-mem-point", ({ label, value }) => {
      this.chart.addPoint(label, value)
    })
  }
}

export default Hooks
