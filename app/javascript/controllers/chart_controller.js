import { Controller } from "@hotwired/stimulus";
import Chart from "chart.js/auto";

export default class extends Controller {
  static targets = ["chart"];

  connect() {
    const ctx = this.chartTarget.getContext("2d");

    new Chart(ctx, {
      type:    "pie",
      data:    {
        labels:   [
          "Entradas",
          "Saídas",
          "Saldo"
        ],
        datasets: [{
          data:            [
            this.chartTarget.dataset.entradas,
            this.chartTarget.dataset.saidas,
            this.chartTarget.dataset.saldo
          ],
          backgroundColor: ["#28a745", "#dc3545", "#007bff"]
        }]
      },
      options: {
        responsive: true
      }
    });
  }
}
