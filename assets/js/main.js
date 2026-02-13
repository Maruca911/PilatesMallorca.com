(function () {
  var navBtn = document.querySelector('[data-nav-toggle]');
  var nav = document.querySelector('[data-nav]');
  var slides = document.querySelectorAll('[data-hero-slideshow] .hero-slide');
  var filterArea = document.querySelector('[data-studio-filter="area"]');
  var filterType = document.querySelector('[data-studio-filter="type"]');
  var studioCards = document.querySelectorAll('.studio-card');
  var hubspotFormTarget = document.querySelector('[data-hubspot-form]');
  var prefersReducedMotion = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  var slideTimer = null;

  if (navBtn && nav) {
    navBtn.addEventListener('click', function () {
      nav.classList.toggle('open');
    });
  }

  if (slides.length > 1 && !prefersReducedMotion) {
    var idx = 0;
    slides[idx].classList.add('is-active');
    function rotateSlides() {
      if (document.hidden) return;
      slides[idx].classList.remove('is-active');
      idx = (idx + 1) % slides.length;
      slides[idx].classList.add('is-active');
    }
    slideTimer = setInterval(rotateSlides, 4400);

    document.addEventListener('visibilitychange', function () {
      if (!document.hidden && slideTimer === null) {
        slideTimer = setInterval(rotateSlides, 4400);
      } else if (document.hidden && slideTimer !== null) {
        clearInterval(slideTimer);
        slideTimer = null;
      }
    });
  } else if (slides.length > 0) {
    slides[0].classList.add('is-active');
  }

  function applyStudioFilters() {
    if (!studioCards.length) return;
    var area = filterArea ? filterArea.value : 'all';
    var type = filterType ? filterType.value : 'all';
    studioCards.forEach(function (card) {
      var matchArea = area === 'all' || (card.dataset.area || '').indexOf(area) !== -1;
      var matchType = type === 'all' || (card.dataset.type || '').indexOf(type) !== -1;
      card.style.display = matchArea && matchType ? '' : 'none';
    });
  }

  if (filterArea) filterArea.addEventListener('change', applyStudioFilters);
  if (filterType) filterType.addEventListener('change', applyStudioFilters);
  applyStudioFilters();

  if ('IntersectionObserver' in window && !prefersReducedMotion) {
    var observer = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add('is-visible');
        }
      });
    }, { threshold: 0.12, rootMargin: '0px 0px -8% 0px' });

    document.querySelectorAll('.card, .kpi, .notice, .faq-group').forEach(function (el) {
      el.classList.add('reveal');
      observer.observe(el);
    });
  }

  document.querySelectorAll('[data-count]').forEach(function (counter) {
    var target = parseInt(counter.getAttribute('data-count'), 10);
    if (!target || Number.isNaN(target)) return;
    if (prefersReducedMotion) {
      counter.textContent = target.toString();
      return;
    }
    var start = 0;
    var step = Math.max(1, Math.round(target / 45));
    var timer = setInterval(function () {
      start += step;
      if (start >= target) {
        start = target;
        clearInterval(timer);
      }
      counter.textContent = start.toString();
    }, 28);
  });

  // HubSpot form integration point: set your real portalId/formId on the container.
  if (hubspotFormTarget && window.hbspt && window.hbspt.forms) {
    var portalId = hubspotFormTarget.getAttribute('data-portal-id');
    var formId = hubspotFormTarget.getAttribute('data-form-id');
    if (portalId && formId && portalId !== 'REPLACE_PORTAL_ID' && formId !== 'REPLACE_FORM_ID') {
      window.hbspt.forms.create({
        region: 'eu1',
        portalId: portalId,
        formId: formId,
        target: '[data-hubspot-form]'
      });

      var fallback = document.querySelector('[data-fallback-form]');
      if (fallback) fallback.style.display = 'none';
    }
  }
})();
