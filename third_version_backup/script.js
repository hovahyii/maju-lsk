/* ============================================
   MAJU LSK LOGISTICS & FOODFARE SDN BHD
   Script — Trilingual, Animations, Interactivity
   ============================================ */

// ============ TRANSLATIONS (loaded from lang/*.json) ============
const _translationCache = {};
let _currentTranslations = {};

async function loadTranslations(lang) {
  if (_translationCache[lang]) {
    _currentTranslations = _translationCache[lang];
    return _translationCache[lang];
  }
  try {
    const res = await fetch('lang/' + lang + '.json?v=2');
    const data = await res.json();
    _translationCache[lang] = data;
    _currentTranslations = data;
    return data;
  } catch (e) {
    console.warn('Failed to load translations for', lang);
    return {};
  }
}

// ============ PERSON IN CHARGE DATA ============
const personData = {
  hq: {
    name: "Encik Sam Ying Kok",
    roleKey: "person_hq_role",
    roleFallback: "Pengasas & CEO",
    phone: "+673 267 1161",
    email: "inquiry@majulskgroup.com",
    hoursKey: "person_hq_hours",
    hoursFallback: "Isnin - Sabtu: 8pg - 5ptg",
    avatar: "logo/lsk.png"
  },
  jimart: {
    name: "Ji-Mart Enterprise",
    roleKey: "person_jimart_role",
    roleFallback: "Pengedar Makanan & Bakeri",
    phone: "+673 267 1161",
    email: "ji-martenterprise@majulskgroup.com",
    hoursKey: "person_jimart_hours",
    hoursFallback: "Isnin - Sabtu: 8pg - 5ptg",
    avatar: "logo/lsk.png"
  },
  andong: {
    name: "Syarikat Andong",
    roleKey: "person_andong_role",
    roleFallback: "Pengedar Tenusu & Sejuk Beku",
    phone: "+673 822 2862",
    email: "syarikatandong@majulskgroup.com",
    hoursKey: "person_andong_hours",
    hoursFallback: "Isnin - Sabtu: 8pg - 5ptg",
    avatar: "logo/lsk.png"
  },
  iburia: {
    name: "Iburia Sdn Bhd",
    roleKey: "person_iburia_role",
    roleFallback: "Runcit & Pengedaran",
    phone: "+673 267 1161",
    email: "iburia@majulskgroup.com",
    hoursKey: "person_iburia_hours",
    hoursFallback: "Isnin - Sabtu: 8pg - 5ptg",
    avatar: "logo/iburia.jpg"
  },
  mgs: {
    name: "Mas Grocery Store (MGS)",
    roleKey: "person_mgs_role",
    roleFallback: "Kedai Runcit",
    phone: "+673 267 1161",
    email: "mgs@majulskgroup.com",
    hoursKey: "person_mgs_hours",
    hoursFallback: "Isnin - Sabtu: 8pg - 5ptg",
    avatar: "logo/mgs.png"
  }
};

// ============ LANGUAGE SWITCHER ============
let currentLang = 'ms';

const langLabels = {
  ms: "BM",
  en: "EN",
  zh: "中文"
};

function applyTranslations(t) {
  if (!t) return;
  // 1. Update all standard translations using data-i18n
  document.querySelectorAll('[data-i18n]').forEach(el => {
    const key = el.getAttribute('data-i18n');
    if (!t[key]) return;
    if (el.tagName === 'INPUT' || el.tagName === 'TEXTAREA') {
      el.placeholder = t[key];
    } else if (el.tagName === 'TITLE') {
      document.title = t[key];
    } else if (el.tagName === 'META') {
      el.setAttribute('content', t[key]);
    } else {
      el.textContent = t[key];
    }
  });

  // 2. Handle HTML-specific translations
  document.querySelectorAll('[data-i18n-html]').forEach(el => {
    const key = el.getAttribute('data-i18n-html');
    if (t[key]) el.innerHTML = t[key];
  });

  const metaDesc = document.querySelector('meta[name="description"]');
  if (metaDesc && t.seo_home_desc) metaDesc.setAttribute('content', t.seo_home_desc);

  const langLabel = document.getElementById('langLabel');
  if (langLabel) langLabel.textContent = langLabels[currentLang] || currentLang.toUpperCase();

  document.querySelectorAll('.lang-dropdown-item').forEach(item => {
    const itemLang = item.getAttribute('data-lang');
    const isActive = itemLang === currentLang;
    item.classList.toggle('active', isActive);
    const check = item.querySelector('.check');
    if (check) check.style.visibility = isActive ? 'visible' : 'hidden';
  });

  if (typeof updatePersonPanel === 'function') updatePersonPanel();
  document.documentElement.lang = currentLang;
}

function setLanguage(lang) {
  currentLang = lang;
  localStorage.setItem('maju-lang', lang);
  loadTranslations(lang).then(t => {
    _currentTranslations = t;
    applyTranslations(t);
  });
}

// ============ LANGUAGE DROPDOWN ============
function initLangDropdown() {
  const dropdown = document.getElementById('langDropdown');
  const toggle = document.getElementById('langToggle');
  const menu = document.getElementById('langMenu');

  if (!dropdown || !toggle || !menu) return;

  const handleToggle = (e) => {
    e.preventDefault();
    e.stopPropagation();
    dropdown.classList.toggle('open');
  };

  toggle.addEventListener('click', handleToggle);

  menu.querySelectorAll('.lang-dropdown-item').forEach(item => {
    item.addEventListener('click', (e) => {
      e.preventDefault();
      e.stopPropagation();
      const lang = item.dataset.lang;
      setLanguage(lang);
      dropdown.classList.remove('open');
    });
  });

  document.addEventListener('click', (e) => {
    if (dropdown.classList.contains('open') && !dropdown.contains(e.target)) {
      dropdown.classList.remove('open');
    }
  });
}

// ============ NAVBAR ============
function initNavbar() {
  const navbar = document.querySelector('.navbar');
  const navToggle = document.querySelector('.nav-toggle');
  const navLinks = document.querySelector('.nav-links');
  const overlay = document.querySelector('.mobile-overlay');

  const handleScroll = () => {
    const isScrolled = window.scrollY > 10;
    navbar.classList.toggle('scrolled', isScrolled);
  };

  window.addEventListener('scroll', handleScroll, { passive: true });
  handleScroll();

  if (navToggle) {
    navToggle.addEventListener('click', () => {
      navToggle.classList.toggle('active');
      navLinks.classList.toggle('open');
      overlay.classList.toggle('show');
      document.body.style.overflow = navLinks.classList.contains('open') ? 'hidden' : '';
    });
  }

  if (overlay) {
    overlay.addEventListener('click', () => {
      navToggle.classList.remove('active');
      navLinks.classList.remove('open');
      overlay.classList.remove('show');
      document.body.style.overflow = '';
    });
  }
}

// ============ INTERACTIVE MAP ============
let currentPerson = 'hq';

function initInteractiveMap() {
  const mapCards = document.querySelectorAll('.map-info-card');
  const mapIframe = document.getElementById('mapIframe');

  // Map URLs updated to your requested pinpoints
  const mapUrls = {
    // Ji-Mart and Andong
    'andong': 'https://maps.google.com/maps?q=Ji-Mart%20Enterprise%20Brunei&t=&z=16&ie=UTF8&iwloc=&output=embed',
    'jimart': 'https://maps.google.com/maps?q=Ji-Mart%20Enterprise%20Brunei&t=&z=16&ie=UTF8&iwloc=&output=embed',

    // NEW: Updated pinpoint using your latest link for Iburia
    'iburia': 'https://maps.google.com/maps?q=Iburia+Sdn+Bhd/4.8877218,114.9111413&z=17&output=embed',

    // Mas Grocery Store (MGS)
    'mgs': 'https://maps.google.com/maps?q=Mas+Grocery+Store,+Simpang+659,+Jangsak,+Brunei&t=&z=16&ie=UTF8&iwloc=&output=embed',

    // Default fallback
    'hq': 'https://maps.google.com/maps?q=Ji-Mart%20Enterprise%20Brunei&t=&z=16&ie=UTF8&iwloc=&output=embed'
  };

  mapCards.forEach(card => {
    card.addEventListener('click', () => {
      // Find out which store was clicked based on data-person
      const person = card.dataset.person || 'hq';

      // 1. Highlight the active card
      mapCards.forEach(c => c.classList.remove('active'));
      card.classList.add('active');

      // 2. Change the map iframe to the correct URL
      if (mapIframe && mapUrls[person]) {
        mapIframe.src = mapUrls[person];
      }

      // 3. Update the Person in Charge panel
      currentPerson = person;
      updatePersonPanel();
    });
  });
}

function updatePersonPanel() {
  const data = personData[currentPerson];
  if (!data) return;

  const t = _currentTranslations;

  const nameEl = document.getElementById('personName');
  const roleEl = document.getElementById('personRole');
  const phoneEl = document.getElementById('personPhone');
  const emailEl = document.getElementById('personEmail');
  const hoursEl = document.getElementById('personHours');
  const avatarEl = document.querySelector('.person-avatar');

  if (nameEl) nameEl.textContent = data.name;
  if (roleEl) roleEl.textContent = t[data.roleKey] || data.roleFallback || data.roleKey;
  if (phoneEl) phoneEl.textContent = data.phone;
  if (emailEl) emailEl.textContent = data.email;
  if (hoursEl) hoursEl.textContent = t[data.hoursKey] || data.hoursFallback || data.hoursKey;

  if (avatarEl) {
    if (data.avatar.includes('.')) {
      avatarEl.innerHTML = `<img src="${data.avatar}" alt="${data.name}" style="width: 100%; height: 100%; object-fit: contain; padding: 10px;">`;
    } else {
      avatarEl.textContent = data.avatar;
    }
  }
}

// ============ SCROLL ANIMATIONS ============
function initScrollAnimations() {
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
      }
    });
  }, {
    threshold: 0.1,
    rootMargin: '0px'
  });

  document.querySelectorAll('.reveal, .reveal-left, .reveal-right, .stagger-children').forEach(el => {
    observer.observe(el);
  });
}

// ============ SMOOTH SCROLL ============
function initSmoothScroll() {
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      if (this.getAttribute('href').startsWith('#') && this.getAttribute('href').length > 1) {
        e.preventDefault();
        const targetId = this.getAttribute('href');

        history.pushState(null, null, targetId);

        const target = document.querySelector(targetId);
        if (target) {
          target.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }
      }
    });
  });
}

// ============ BRAND FILTER ============
function initBrandFilter() {
  const filterBtns = document.querySelectorAll('.brand-filter-btn');
  const brandItems = document.querySelectorAll('.brand-item');

  if (!filterBtns.length || !brandItems.length) return;

  function applyFilter(filter) {
    brandItems.forEach(item => {
      const company = item.dataset.company;
      if (filter === 'all' || company === filter) {
        item.style.display = 'flex';
        // Remove the scroll animation class so it stops fighting the JS
        item.classList.remove('reveal');

        setTimeout(() => {
          item.style.opacity = '1';
          item.style.transform = 'scale(1)';
          item.style.pointerEvents = 'auto';
        }, 10);
      } else {
        item.style.opacity = '0';
        item.style.transform = 'scale(0.9)';
        item.style.pointerEvents = 'none';
        setTimeout(() => {
          item.style.display = 'none';
        }, 300);
      }
    });
  }

  filterBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      const filter = btn.dataset.filter;
      filterBtns.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      applyFilter(filter);
    });
  });

  // --- BULLETPROOF FIRST LOAD ---
  const activeFilter = document.querySelector('.brand-filter-btn.active')?.dataset.filter || 'all';
  applyFilter(activeFilter);
}

function loadProducts(filters = {}) {
  const grid = document.getElementById('productsGrid');
  if (!grid) return Promise.resolve();

  const t = _currentTranslations;
  const messageText = t.prod_loading || "Loading products...";
  grid.innerHTML = '';
  const loadingCard = document.createElement('div');
  loadingCard.className = 'product-card';
  const loadingBody = document.createElement('div');
  loadingBody.className = 'product-card-body';
  const loadingTitle = document.createElement('h4');
  loadingTitle.textContent = messageText;
  loadingBody.appendChild(loadingTitle);
  loadingCard.appendChild(loadingBody);
  grid.appendChild(loadingCard);

  const params = new URLSearchParams();
  if (filters.category) params.set('category', filters.category);
  if (filters.subcategory) params.set('subcategory', filters.subcategory);
  if (filters.brand) params.set('brand', filters.brand);
  const url = params.toString() ? `api/products.php?${params.toString()}` : 'api/products.php';

  return fetch(url, { cache: 'no-store' })
    .then(response => response.json())
    .then(payload => {
      const products = Array.isArray(payload?.data) ? payload.data : [];
      grid.innerHTML = '';

      if (!products.length) {
        const emptyCard = document.createElement('div');
        emptyCard.className = 'product-card';
        const emptyBody = document.createElement('div');
        emptyBody.className = 'product-card-body';
        const emptyTitle = document.createElement('h4');
        emptyTitle.textContent = t.prod_none || "No products found.";
        emptyBody.appendChild(emptyTitle);
        emptyCard.appendChild(emptyBody);
        grid.appendChild(emptyCard);
        return;
      }

      products.forEach(product => {
        const card = document.createElement('div');
        card.className = 'product-card reveal';
        card.dataset.category = product.category_slug || 'all';

        const imgWrap = document.createElement('div');
        imgWrap.className = 'product-card-img';
        const img = document.createElement('img');
        img.src = product.image_url || '';
        img.alt = product.name || '';
        imgWrap.appendChild(img);

        const body = document.createElement('div');
        body.className = 'product-card-body';

        if (product.brand_name) {
          const brand = document.createElement('span');
          brand.className = 'product-brand';
          brand.textContent = product.brand_name;
          body.appendChild(brand);
        }

        const title = document.createElement('h4');
        title.textContent = product.name || '';
        body.appendChild(title);

        const sub = document.createElement('p');
        sub.textContent = product.subcategory_name || '';
        body.appendChild(sub);

        card.appendChild(imgWrap);
        card.appendChild(body);
        grid.appendChild(card);
      });
    })
    .catch(() => {
      grid.innerHTML = '';
      const errorCard = document.createElement('div');
      errorCard.className = 'product-card';
      const errorBody = document.createElement('div');
      errorBody.className = 'product-card-body';
      const errorTitle = document.createElement('h4');
      errorTitle.textContent = t.prod_fail || "Failed to load products.";
      errorBody.appendChild(errorTitle);
      errorCard.appendChild(errorBody);
      grid.appendChild(errorCard);
    });
}

function initProductSidebarFilters() {
  const categorySelect = document.getElementById('filterCategory');
  const subcategorySelect = document.getElementById('filterSubcategory');
  const brandSelect = document.getElementById('filterBrand');
  const resetButton = document.getElementById('filterReset');

  const getAllLabel = () => (_currentTranslations.filter_all) || 'All';

  const buildOptions = (select, options) => {
    select.innerHTML = '';
    const defaultOption = document.createElement('option');
    defaultOption.value = '';
    defaultOption.textContent = getAllLabel();
    defaultOption.setAttribute('data-i18n', 'filter_all');
    select.appendChild(defaultOption);
    options.forEach(({ value, label }) => {
      const opt = document.createElement('option');
      opt.value = value;
      opt.textContent = label;
      select.appendChild(opt);
    });
  };

  const buildMaps = (products) => {
    const categories = new Map();
    const subcategories = new Map();       // category -> Map(subcat_slug -> label)
    const allSubcategories = new Map();
    const brands = new Map();
    const brandsByCategory = new Map();    // category_slug -> Map(brand_slug -> label)
    const brandsBySubcategory = new Map(); // subcategory_slug -> Map(brand_slug -> label)

    products.forEach((p) => {
      if (p.category_slug) {
        categories.set(p.category_slug, p.category_name || p.category_slug);
      }
      if (p.subcategory_slug) {
        allSubcategories.set(p.subcategory_slug, p.subcategory_name || p.subcategory_slug);
        if (p.category_slug) {
          if (!subcategories.has(p.category_slug)) subcategories.set(p.category_slug, new Map());
          subcategories.get(p.category_slug).set(p.subcategory_slug, p.subcategory_name || p.subcategory_slug);
        }
      }
      if (p.brand_slug) {
        const bLabel = p.brand_name || p.brand_slug;
        brands.set(p.brand_slug, bLabel);
        // Index by category
        if (p.category_slug) {
          if (!brandsByCategory.has(p.category_slug)) brandsByCategory.set(p.category_slug, new Map());
          brandsByCategory.get(p.category_slug).set(p.brand_slug, bLabel);
        }
        // Index by subcategory
        if (p.subcategory_slug) {
          if (!brandsBySubcategory.has(p.subcategory_slug)) brandsBySubcategory.set(p.subcategory_slug, new Map());
          brandsBySubcategory.get(p.subcategory_slug).set(p.brand_slug, bLabel);
        }
      }
    });

    return { categories, subcategories, allSubcategories, brands, brandsByCategory, brandsBySubcategory };
  };

  const sortedOptions = (map) =>
    [...map.entries()].sort((a, b) => a[1].localeCompare(b[1])).map(([value, label]) => ({ value, label }));

  const populateCategoryOptions = (map) => buildOptions(categorySelect, sortedOptions(map));
  const populateSubcategoryOptions = (map) => buildOptions(subcategorySelect, sortedOptions(map));
  const populateBrandOptions = (map) => buildOptions(brandSelect, sortedOptions(map));

  fetch('api/products.php', { cache: 'no-store' })
    .then(response => response.json())
    .then(payload => {
      const products = Array.isArray(payload?.data) ? payload.data : [];
      const maps = buildMaps(products);

      populateCategoryOptions(maps.categories);
      populateSubcategoryOptions(maps.allSubcategories);
      populateBrandOptions(maps.brands);

      const getCurrentBrandMap = () => {
        const cat = categorySelect.value;
        const sub = subcategorySelect.value;
        if (sub && maps.brandsBySubcategory.has(sub)) return maps.brandsBySubcategory.get(sub);
        if (cat && maps.brandsByCategory.has(cat)) return maps.brandsByCategory.get(cat);
        return maps.brands;
      };

      const applyFilters = () => {
        const category = categorySelect.value;
        const subcategory = subcategorySelect.value;
        const brand = brandSelect.value;
        loadProducts({ category, subcategory, brand }).finally(() => {
          initScrollAnimations();
        });
      };

      categorySelect.addEventListener('change', () => {
        const cat = categorySelect.value;
        const subMap = cat ? (maps.subcategories.get(cat) || new Map()) : maps.allSubcategories;
        populateSubcategoryOptions(subMap);
        populateBrandOptions(getCurrentBrandMap());
        applyFilters();
      });

      subcategorySelect.addEventListener('change', () => {
        populateBrandOptions(getCurrentBrandMap());
        applyFilters();
      });

      brandSelect.addEventListener('change', applyFilters);

      if (resetButton) {
        resetButton.addEventListener('click', () => {
          categorySelect.value = '';
          populateSubcategoryOptions(maps.allSubcategories);
          subcategorySelect.value = '';
          populateBrandOptions(maps.brands);
          brandSelect.value = '';
          applyFilters();
        });
      }

      applyFilters();
    })
    .catch(() => {
      loadProducts();
    });
}

// ============ PRODUCT FILTER (CATEGORIES) ============
function initProductFilter() {
  const filterBtns = document.querySelectorAll('.products-filter .filter-btn');
  const productCards = document.querySelectorAll('.products-grid .product-card');

  if (!filterBtns.length || !productCards.length) return;

  function applyFilter(filter) {
    productCards.forEach(card => {
      const category = card.dataset.category;
      if (filter === 'all' || category === filter) {
        card.style.display = 'flex';
        // Remove the scroll animation class so it stops fighting the JS
        card.classList.remove('reveal');

        setTimeout(() => {
          card.style.opacity = '1';
          card.style.transform = 'scale(1)';
          card.style.pointerEvents = 'auto';
        }, 10);
      } else {
        card.style.opacity = '0';
        card.style.transform = 'scale(0.9)';
        card.style.pointerEvents = 'none';
        setTimeout(() => {
          card.style.display = 'none';
        }, 300);
      }
    });
  }

  filterBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      const filter = btn.dataset.filter;
      filterBtns.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      applyFilter(filter);
    });
  });

  // --- BULLETPROOF FIRST LOAD ---
  const activeFilter = document.querySelector('.products-filter .filter-btn.active')?.dataset.filter || 'all';
  applyFilter(activeFilter);
}

// ============ CONTACT FORM ============
function initContactForm() {
  const form = document.getElementById('contactForm');
  if (!form) return;

  // Your live Google Apps Script URL
  const scriptURL = 'https://script.google.com/macros/s/AKfycbxBQ_Hu2bycDIIPt3reay_4slm8PrVJZvnNZFcTiVDZfNp6vOhYGyyuOHrX0QO8JMBW/exec';
  const COOLDOWN_MS = 180 * 1000; // 180 seconds in milliseconds

  form.addEventListener('submit', (e) => {
    e.preventDefault();

    const btn = form.querySelector('.btn-submit');
    const originalText = btn.textContent;

    // --- 1. Check the 180-second Cooldown ---
    const lastSubmitTime = localStorage.getItem('maju-contact-cooldown');
    if (lastSubmitTime) {
      const timePassed = Date.now() - parseInt(lastSubmitTime, 10);

      if (timePassed < COOLDOWN_MS) {
        // Calculate how many seconds are left
        const timeLeft = Math.ceil((COOLDOWN_MS - timePassed) / 1000);

        // Show the warning in the correct language
        const t = _currentTranslations;
        const formatWait = t.form_wait || "Please wait {time}s";
        const waitMsg = formatWait.replace('{time}', timeLeft);

        btn.textContent = waitMsg;
        btn.style.background = '#f59e0b'; // Orange warning color

        // Reset the button visual after 3 seconds, but don't send the form
        setTimeout(() => {
          btn.textContent = originalText;
          btn.style.background = '';
        }, 3000);

        return; // STOP the function here so it doesn't send the email
      }
    }

    // --- 2. Proceed with Submission ---
    const t = _currentTranslations;

    // Show sending state and disable button to prevent double clicks
    btn.textContent = t.form_sending || "Sending...";
    btn.style.opacity = '0.7';
    btn.disabled = true;

    // Send data to Google Sheets (Using mode: 'no-cors' to bypass browser blocks)
    fetch(scriptURL, {
      method: 'POST',
      body: new FormData(form),
      mode: 'no-cors'
    })
      .then(response => {
        const t = _currentTranslations;
        // Success state
        btn.textContent = t.form_success || "Thank you! ✓";
        btn.style.background = '#22c55e'; // Green success color
        btn.style.opacity = '1';

        // Save the exact time they successfully submitted the form
        localStorage.setItem('maju-contact-cooldown', Date.now().toString());

        setTimeout(() => {
          btn.textContent = originalText;
          btn.style.background = '';
          btn.disabled = false; // Re-enable button
          form.reset(); // Clear the form fields
        }, 3000);
      })
      .catch(error => {
        // Error state
        console.error('Error!', error.message);
        btn.textContent = 'Ralat / Error!';
        btn.style.background = '#ef4444'; // Red error color
        btn.style.opacity = '1';

        setTimeout(() => {
          btn.textContent = originalText;
          btn.style.background = '';
          btn.disabled = false; // Re-enable button
        }, 3000);
      });
  });
}

// ============ EVENT SLIDESHOW ============
function initEventSlideshow() {
  document.querySelectorAll('.event-slideshow').forEach(slideshow => {
    const slides = slideshow.querySelectorAll('.slide');
    if (slides.length <= 1) return;

    const interval = parseInt(slideshow.dataset.interval) || 3000;
    let current = 0;

    setInterval(() => {
      slides[current].classList.remove('active');
      current = (current + 1) % slides.length;
      slides[current].classList.add('active');
    }, interval);
  });
}

// ============ AUTO SCROLL EVENTS ============
function initEventsAutoScroll() {
  const scrollContainer = document.querySelector('.events-scroll');
  if (!scrollContainer) return;

  let scrollSpeed = 1; // Speed of the scroll (1 is smooth and readable)
  let direction = 1;   // 1 for scrolling right, -1 for scrolling left
  let isPaused = false;

  // Pause the scrolling when the user hovers over it with a mouse or touches it
  scrollContainer.addEventListener('mouseenter', () => isPaused = true);
  scrollContainer.addEventListener('mouseleave', () => isPaused = false);
  scrollContainer.addEventListener('touchstart', () => isPaused = true, { passive: true });
  scrollContainer.addEventListener('touchend', () => isPaused = false);

  function autoScroll() {
    if (!isPaused) {
      scrollContainer.scrollLeft += (scrollSpeed * direction);

      // If it reaches the far right end, reverse direction to left
      if (scrollContainer.scrollLeft >= (scrollContainer.scrollWidth - scrollContainer.clientWidth - 1)) {
        direction = -1;
      }
      // If it reaches the far left end, reverse direction to right
      else if (scrollContainer.scrollLeft <= 0) {
        direction = 1;
      }
    }
    requestAnimationFrame(autoScroll);
  }

  // Start the animation loop
  requestAnimationFrame(autoScroll);
}

// ============ SCROLL TO TOP ============
function initScrollTopBtn() {
  const btn = document.getElementById('scrollTopBtn');
  if (!btn) return;
  window.addEventListener('scroll', () => {
    btn.classList.toggle('visible', window.scrollY > 300);
  }, { passive: true });
  btn.addEventListener('click', () => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });
}

// ============ INITIALIZATION ============
document.addEventListener('DOMContentLoaded', () => {
  document.body.classList.add('js-enabled');

  try {
    const savedLang = localStorage.getItem('maju-lang') || 'ms';
    setLanguage(savedLang);

    const hasSidebarFilters = document.getElementById('filterCategory');
    initLangDropdown();
    initNavbar();
    initScrollAnimations();
    initSmoothScroll();
    if (hasSidebarFilters) {
      initProductSidebarFilters();
    } else {
      const productsReady = loadProducts();
      productsReady.finally(() => {
        initScrollAnimations();
        initProductFilter();
      });
    }
    initBrandFilter();
    initInteractiveMap();
    initContactForm();
    initEventSlideshow();
    initEventsAutoScroll();
    initScrollTopBtn();
  } catch (err) {
    console.error('Critical initialization error:', err);
    document.querySelectorAll('.reveal, .reveal-left, .reveal-right, .stagger-children').forEach(el => {
      el.classList.add('visible');
    });
  }
});
