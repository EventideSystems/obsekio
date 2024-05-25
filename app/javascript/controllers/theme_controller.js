import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "lightMode", "darkMode", "toggle" ]

  connect() {
    if (localStorage.getItem('color-theme') === 'dark' || (!('color-theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
      this.darkModeTarget.classList.remove('hidden');
      document.documentElement.classList.add('dark');
    } else {
      this.lightModeTarget.classList.remove('hidden');
      document.documentElement.classList.remove('dark');
    }
  }

  toggle() {
    this.lightModeTarget.classList.toggle('hidden');
    this.darkModeTarget.classList.toggle('hidden');

    if (localStorage.getItem('color-theme')) {
        if (localStorage.getItem('color-theme') === 'light') {
            document.documentElement.classList.add('dark');
            localStorage.setItem('color-theme', 'dark');
        } else {
            document.documentElement.classList.remove('dark');
            localStorage.setItem('color-theme', 'light');
        }

    // if NOT set via local storage previously
    } else {
        if (document.documentElement.classList.contains('dark')) {
            document.documentElement.classList.remove('dark');
            localStorage.setItem('color-theme', 'light');
        } else {
            document.documentElement.classList.add('dark');
            localStorage.setItem('color-theme', 'dark');
        }
    }
  }
}