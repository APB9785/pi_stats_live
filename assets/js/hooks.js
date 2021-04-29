import { MemChart, TempChart } from "./line-chart"

let Hooks = {}

Hooks.TempChart = {
  mounted() {
    const { labels, values } = JSON.parse(this.el.dataset.chartData)
    this.chart = new TempChart(this.el, labels, values)

    this.handleEvent("new-temp-point", ({ label, value }) => {
      this.chart.addPoint(label, value)
    })
  }
}

Hooks.MemChart = {
  mounted() {
    const { labels, values } = JSON.parse(this.el.dataset.chartData)
    this.chart = new MemChart(this.el, labels, values)

    this.handleEvent("new-mem-point", ({ label, value }) => {
      this.chart.addPoint(label, value)
    })
  }
}

export default Hooks
