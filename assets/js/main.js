(function () {
  var navBtn = document.querySelector('[data-nav-toggle]');
  var nav = document.querySelector('[data-nav]');
  var slides = document.querySelectorAll('[data-hero-slideshow] .hero-slide');
  var filterArea = document.querySelector('[data-studio-filter="area"]');
  var filterType = document.querySelector('[data-studio-filter="type"]');
  var studioCards = document.querySelectorAll('.studio-card');

  if (navBtn && nav) {
    navBtn.addEventListener('click', function () {
      nav.classList.toggle('open');
    });
  }

  if (slides.length > 1) {
    var idx = 0;
    slides[idx].classList.add('is-active');
    setInterval(function () {
      slides[idx].classList.remove('is-active');
      idx = (idx + 1) % slides.length;
      slides[idx].classList.add('is-active');
    }, 4200);
  }

  function applyStudioFilters() {
    if (!studioCards.length) return;
    var area = filterArea ? filterArea.value : 'all';
    var type = filterType ? filterType.value : 'all';
    studioCards.forEach(function (card) {
      var matchArea = area === 'all' || card.dataset.area.indexOf(area) !== -1;
      var matchType = type === 'all' || card.dataset.type.indexOf(type) !== -1;
      card.style.display = matchArea && matchType ? '' : 'none';
    });
  }

  if (filterArea) filterArea.addEventListener('change', applyStudioFilters);
  if (filterType) filterType.addEventListener('change', applyStudioFilters);
  applyStudioFilters();

  var observer = new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      if (entry.isIntersecting) entry.target.classList.add('is-visible');
    });
  }, { threshold: 0.1 });

  document.querySelectorAll('.card, .kpi, .notice').forEach(function (el) {
    el.classList.add('reveal');
    observer.observe(el);
  });
})();
