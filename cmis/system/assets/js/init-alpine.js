function data() {
  function getThemeFromLocalStorage() {
    // if user already changed the theme, use it
    if (window.localStorage.getItem('dark')) {
      return JSON.parse(window.localStorage.getItem('dark'))
    }

    // else return their preferences
    return (
      !!window.matchMedia &&
      window.matchMedia('(prefers-color-scheme: dark)').matches
    )
  }

  function setThemeToLocalStorage(value) {
    window.localStorage.setItem('dark', value)
  }

  return {
    dark: getThemeFromLocalStorage(),
    toggleTheme() {
      this.dark = !this.dark
      setThemeToLocalStorage(this.dark)
    },
    isSideMenuOpen: false,
    toggleSideMenu() {
      this.isSideMenuOpen = !this.isSideMenuOpen
    },
    closeSideMenu() {
      this.isSideMenuOpen = false
    },
    isNotificationsMenuOpen: false,
    toggleNotificationsMenu() {
      this.isNotificationsMenuOpen = !this.isNotificationsMenuOpen
    },
    closeNotificationsMenu() {
      this.isNotificationsMenuOpen = false
    },
    isProfileMenuOpen: false,
    toggleProfileMenu() {
      this.isProfileMenuOpen = !this.isProfileMenuOpen
    },
    closeProfileMenu() {
      this.isProfileMenuOpen = false
    },
    isPagesMenuOpen: false,
    togglePagesMenu() {
      this.isPagesMenuOpen = !this.isPagesMenuOpen
    },
    isPagesMenuOpen1: false,
    togglePagesMenu1() {
      this.isPagesMenuOpen1 = !this.isPagesMenuOpen1;
      document.getElementById('fa-1').classList.toggle('fa-rotate-180');
    },
    isPagesMenuOpen2: false,
    togglePagesMenu2() {
      this.isPagesMenuOpen2 = !this.isPagesMenuOpen2;
      document.getElementById('fa-2').classList.toggle('fa-rotate-180');
    },
    isPagesMenuOpen3: false,
    togglePagesMenu3() {
      this.isPagesMenuOpen3 = !this.isPagesMenuOpen3;
      document.getElementById('fa-3').classList.toggle('fa-rotate-180');
    },
    isPagesMenuOpen4: false,
    togglePagesMenu4() {
      this.isPagesMenuOpen4 = !this.isPagesMenuOpen4;
      document.getElementById('fa-4').classList.toggle('fa-rotate-180');
    },
    isPagesMenuOpen5: false,
    togglePagesMenu5() {
      this.isPagesMenuOpen5 = !this.isPagesMenuOpen5;
      document.getElementById('fa-5').classList.toggle('fa-rotate-180');
    },
    isPagesMenuOpen6: false,
    togglePagesMenu6() {
      this.isPagesMenuOpen6 = !this.isPagesMenuOpen6;
      document.getElementById('fa-6').classList.toggle('fa-rotate-180');
    },
    isPagesMenuOpen7: false,
    togglePagesMenu7() {
      this.isPagesMenuOpen7 = !this.isPagesMenuOpen7;
      document.getElementById('fa-7').classList.toggle('fa-rotate-180');
    },
    isPagesMenuOpen8: false,
    togglePagesMenu8() {
      this.isPagesMenuOpen8 = !this.isPagesMenuOpen8;
      document.getElementById('fa-8').classList.toggle('fa-rotate-180');
    },
    isPagesMenuOpen9: false,
    togglePagesMenu9() {
      this.isPagesMenuOpen9 = !this.isPagesMenuOpen9;
      document.getElementById('fa-9').classList.toggle('fa-rotate-180');
    },
    isPagesMenuOpen10: false,
    togglePagesMenu10() {
      this.isPagesMenuOpen10 = !this.isPagesMenuOpen10;
      document.getElementById('fa-10').classList.toggle('fa-rotate-180');
    },
    isPagesMenuOpen11: false,
    togglePagesMenu11() {
      this.isPagesMenuOpen11 = !this.isPagesMenuOpen11;
      document.getElementById('fa-11').classList.toggle('fa-rotate-180');
    },
    isPagesMenuOpen12: false,
    togglePagesMenu12() {
      this.isPagesMenuOpen12 = !this.isPagesMenuOpen12;
      document.getElementById('fa-12').classList.toggle('fa-rotate-180');
    },
    // Modal
    isModalOpen: false,
    trapCleanup: null,
    openModal() {
      this.isModalOpen = true
      this.trapCleanup = focusTrap(document.querySelector('#modal'))
    },
    closeModal() {
      this.isModalOpen = false
      this.trapCleanup()
    },
  }
}
