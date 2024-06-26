import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["previewPanel", "settingsPanel", "historyPanel"]

  showPanel(event, panelToShow, panelsToHide) {
    event.preventDefault();

    panelsToHide.forEach(function(panel) {
      panel.classList.add('hidden');
    });

    panelToShow.classList.remove("hidden");
    this.removeIndigoFromLinks(event);
    event.target.classList.add('text-yellow-400');
  }

  showPreviewPanel(event) {
    this.showPanel(event, this.previewPanelTarget, [this.settingsPanelTarget, this.historyPanelTarget]);
  }

  showSettingsPanel(event) {
    this.showPanel(event, this.settingsPanelTarget, [this.previewPanelTarget, this.historyPanelTarget]);
  }

  showHistoryPanel(event) {
    this.showPanel(event, this.historyPanelTarget, [this.previewPanelTarget, this.settingsPanelTarget]);
  }

  removeIndigoFromLinks(event) {
    event.target.parentNode.parentNode.querySelectorAll('a').forEach(function(link) {
      link.classList.remove('text-yellow-400');
    });
  }
}
