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
    name: "Sam Ying Kok",
    nameKey: "person_hq_name",
    nameFallback: "Sam Ying Kok",
    roleKey: "person_hq_role",
    roleFallback: "Pengasas & CEO",
    phone: "+673 267 1161",
    email: "admin@majulskgroup.com",
    hoursKey: "person_hq_hours",
    hoursFallback: "Isnin - Sabtu: 8pg - 5ptg",
    avatar: "logo/lsk.png"
  },
  jimart: {
    name: "Ji-Mart Enterprise",
    roleKey: "person_jimart_role",
    roleFallback: "Pengedar Makanan & Bakeri",
    phone: "+673 267 1161",
    email: "hockjimart@hotmail.com",
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
const urlParams = new URLSearchParams(window.location.search);
const urlLang = urlParams.get('lang');
const supportedLanguages = ['ms', 'en', 'zh'];
const defaultLang = document.documentElement.lang || 'ms';
const baseCanonical = document.querySelector('link[rel="canonical"]')?.href;
let currentLang = supportedLanguages.includes(urlLang) ? urlLang : defaultLang;

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

  // Keep each page's translated metadata and language URL in sync.
  const metaDesc = document.querySelector('meta[name="description"]');
  const canonical = baseCanonical ? new URL(baseCanonical) : null;
  if (canonical && currentLang !== defaultLang) canonical.searchParams.set('lang', currentLang);
  if (canonical) document.querySelector('link[rel="canonical"]').href = canonical.href;
  for (const prefix of ['og', 'twitter']) {
    document.querySelector(`meta[property="${prefix}:title"]`)?.setAttribute('content', document.title);
    if (metaDesc) document.querySelector(`meta[property="${prefix}:description"]`)?.setAttribute('content', metaDesc.content);
    if (canonical) document.querySelector(`meta[property="${prefix}:url"]`)?.setAttribute('content', canonical.href);
  }

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
  if (!supportedLanguages.includes(lang)) lang = defaultLang;
  currentLang = lang;
  localStorage.setItem('maju-lang', lang);
  
  // Update URL without reloading
  const url = new URL(window.location);
  url.searchParams.set('lang', lang);
  window.history.pushState({path: url.href}, '', url.href);

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
  const navLogoImg = document.getElementById('navLogoImg');
  const logoDefault = navLogoImg?.dataset.logoDefault;
  const logoScrolled = navLogoImg?.dataset.logoScrolled;

  const handleScroll = () => {
    const isScrolled = window.scrollY > 10;
    navbar.classList.toggle('scrolled', isScrolled);
    if (navLogoImg) {
      const nextLogo = isScrolled ? logoScrolled : logoDefault;
      if (nextLogo && !navLogoImg.src.endsWith(nextLogo)) {
        navLogoImg.src = nextLogo;
      }
    }
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

  const nameValue = data.nameKey ? (t[data.nameKey] || data.nameFallback || data.name || data.nameKey) : data.name;

  if (nameEl) nameEl.textContent = nameValue;
  if (roleEl) roleEl.textContent = t[data.roleKey] || data.roleFallback || data.roleKey;
  if (phoneEl) phoneEl.textContent = data.phone;
  if (emailEl) emailEl.textContent = data.email;
  if (hoursEl) hoursEl.textContent = t[data.hoursKey] || data.hoursFallback || data.hoursKey;

  if (avatarEl) {
    if (data.avatar.includes('.')) {
      avatarEl.innerHTML = `<img src="${data.avatar}" alt="${nameValue}" style="width: 100%; height: 100%; object-fit: contain; padding: 10px;">`;
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

function getGridColumnCount(grid) {
  const columns = getComputedStyle(grid).gridTemplateColumns;
  if (!columns) return 1;
  return columns.split(' ').length || 1;
}

function applyGridLimit({ grid, button, itemSelector, displayType, reset }) {
  if (!grid || !button) return;
  const rows = 3;
  if (reset || !grid.dataset.rowsVisible) {
    grid.dataset.rowsVisible = String(rows);
  }
  const rowsVisible = parseInt(grid.dataset.rowsVisible, 10) || rows;
  const allItems = Array.from(grid.querySelectorAll(itemSelector));
  const visibleItems = allItems.filter(item => item.dataset.filterHidden !== 'true');
  const columns = getGridColumnCount(grid);
  const maxVisible = columns * rowsVisible;

  allItems.forEach(item => {
    if (item.dataset.filterHidden === 'true') {
      item.dataset.loadHidden = 'true';
      item.style.display = 'none';
    }
  });

  visibleItems.forEach((item, index) => {
    const shouldHide = index >= maxVisible;
    item.dataset.loadHidden = shouldHide ? 'true' : 'false';
    item.style.display = shouldHide ? 'none' : displayType;
  });

  button.style.display = visibleItems.length > maxVisible ? 'inline-flex' : 'none';
}

function bindLoadMore({ grid, button, itemSelector, displayType }) {
  if (!grid || !button) return;
  if (!button.dataset.bound) {
    button.addEventListener('click', () => {
      const rows = 3;
      const currentRows = parseInt(grid.dataset.rowsVisible, 10) || rows;
      grid.dataset.rowsVisible = String(currentRows + rows);
      applyGridLimit({ grid, button, itemSelector, displayType, reset: false });
    });
    button.dataset.bound = 'true';
    let resizeTimer;
    window.addEventListener('resize', () => {
      clearTimeout(resizeTimer);
      resizeTimer = setTimeout(() => {
        applyGridLimit({ grid, button, itemSelector, displayType, reset: false });
      }, 150);
    });
  }
  applyGridLimit({ grid, button, itemSelector, displayType, reset: true });
}

// ============ BRAND FILTER ============
function initBrandFilter() {
  const filterBtns = document.querySelectorAll('.brand-filter-btn');
  const brandItems = document.querySelectorAll('.brand-item');
  const brandsGrid = document.querySelector('.brands-grid');
  const brandsLoadMore = document.getElementById('brandsLoadMore');

  if (!filterBtns.length || !brandItems.length) return;

  function applyFilter(filter) {
    brandItems.forEach(item => {
      const company = item.dataset.company;
      if (filter === 'all' || company === filter) {
        item.dataset.filterHidden = 'false';
        // Remove the scroll animation class so it stops fighting the JS
        item.classList.remove('reveal');

        setTimeout(() => {
          item.style.opacity = '1';
          item.style.transform = 'scale(1)';
          item.style.pointerEvents = 'auto';
        }, 10);
      } else {
        item.dataset.filterHidden = 'true';
        item.style.opacity = '0';
        item.style.transform = 'scale(0.9)';
        item.style.pointerEvents = 'none';
        setTimeout(() => {
          item.style.display = 'none';
        }, 300);
      }
    });
    bindLoadMore({ grid: brandsGrid, button: brandsLoadMore, itemSelector: '.brand-item', displayType: 'flex' });
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
  const loadMoreButton = document.getElementById('productsLoadMore');
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
        bindLoadMore({ grid, button: loadMoreButton, itemSelector: '.product-card', displayType: 'flex' });
        return;
      }

      products.forEach(product => {
        const card = document.createElement('div');
        card.className = 'product-card reveal';
        card.dataset.category = product.category_slug || 'all';

        const imgWrap = document.createElement('div');
        imgWrap.className = 'product-card-img';
        const img = document.createElement('img');
        img.loading = 'lazy';
        img.decoding = 'async';
        img.alt = product.name || '';
        // Attempt to normalize accented filenames that may 404 on some hosts
        const originalSrc = product.image_url || '';
        const normalizedSrc = originalSrc
          ? originalSrc.replace(/Caf(?:%C3%A9|é)/gi, 'Cafe')
          : '';
        img.src = originalSrc || '';
        img.onerror = () => {
          if (normalizedSrc && img.src !== normalizedSrc) {
            img.src = normalizedSrc;
          } else {
            img.src = 'logo/logo.webp';
          }
        };
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
      bindLoadMore({ grid, button: loadMoreButton, itemSelector: '.product-card', displayType: 'flex' });
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
      bindLoadMore({ grid, button: loadMoreButton, itemSelector: '.product-card', displayType: 'flex' });
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

      // Pre-select filters from URL query parameters (e.g. from AI Product Assistant)
      const qCat = urlParams.get('category') || '';
      const qSub = urlParams.get('subcategory') || '';
      const qBrand = urlParams.get('brand') || '';

      if (qCat && maps.categories.has(qCat)) {
        categorySelect.value = qCat;
        const subMap = maps.subcategories.get(qCat) || new Map();
        populateSubcategoryOptions(subMap);
      }
      if (qSub) {
        subcategorySelect.value = qSub;
      }
      populateBrandOptions(getCurrentBrandMap());
      if (qBrand) {
        brandSelect.value = qBrand;
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
    // Note: With no-cors, we can't check response.ok or response.status.
    // We assume success if the network request doesn't throw a fatal error.
    fetch(scriptURL, {
      method: 'POST',
      body: new FormData(form),
      mode: 'no-cors'
    })
      .then(() => {
        // Because of no-cors, we always land here if the request was sent.
        // We cannot read the response body.
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
    // Explicit language URLs must win over a previously saved preference.
    setLanguage(currentLang);

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
    initAIChatbot();
  } catch (err) {
    console.error('Critical initialization error:', err);
    document.querySelectorAll('.reveal, .reveal-left, .reveal-right, .stagger-children').forEach(el => {
      el.classList.add('visible');
    });
  }
});


// ============ AI PRODUCT ASSISTANT CHATBOT (Clerk.io-style) ============
function initAIChatbot() {
  if (document.getElementById('aiChatLauncher')) return;

  const CHAT_STORAGE_KEY = 'maju_ai_chat_history_v1';

  const i18nCopy = {
    en: {
      tooltip: 'Ask AI about our products',
      title: 'Maju LSK Product AI',
      status: 'Delivering Promise, Every Single Mile',
      placeholder: 'Ask about products, brands, or categories...',
      welcome: 'Hi! I’m the Maju LSK Product AI. Ask me anything about our wholesale food, bakery ingredients, frozen foods, or brands in our catalog.',
      chips: [
        'What frozen foods do you carry?',
        'About Maju LSK',
        'Do you supply cooking oil?',
        'List your flour & baking brands'
      ],
      clearTitle: 'Clear conversation',
      closeTitle: 'Close chat',
      errorMsg: 'Sorry, I could not reach the product assistant right now. Please try again in a moment.'
    },
    ms: {
      tooltip: 'Tanya AI tentang produk kami',
      title: 'AI Produk Maju LSK',
      status: 'Menunaikan Janji, Setiap Batu Perjalanan',
      placeholder: 'Tanya tentang produk, jenama, atau kategori...',
      welcome: 'Hai! Saya pembantu AI Produk Maju LSK. Tanya saya tentang bahan makanan borong, bahan bakeri, makanan sejuk beku, atau jenama dalam katalog kami.',
      chips: [
        'Apakah makanan sejuk beku yang ada?',
        'Tentang Maju LSK',
        'Adakah anda membekalkan minyak masak?',
        'Senaraikan tepung & bahan bakeri'
      ],
      clearTitle: 'Padam perbualan',
      closeTitle: 'Tutup sembang',
      errorMsg: 'Maaf, pembantu produk tidak dapat dihubungi buat masa ini. Sila cuba sebentar lagi.'
    },
    zh: {
      tooltip: '向 AI 询问产品目录',
      title: 'Maju LSK 产品 AI 助手',
      status: '信守承诺，使命必达',
      placeholder: '搜索产品、品牌或分类...',
      welcome: '您好！我是 Maju LSK 产品 AI 助手。欢迎向我查询我们的批发食品、烘焙原料、冷冻食品或代理品牌。',
      chips: [
        '你们有哪些冷冻食品？',
        '关于 Maju LSK',
        '有供应食用油或人造黄油吗？',
        '列出面粉和烘焙原料品牌'
      ],
      clearTitle: '清空对话',
      closeTitle: '关闭聊天',
      errorMsg: '抱歉，暂时无法连接到产品助手，请稍后再试。'
    }
  };

  const getCopy = () => i18nCopy[currentLang] || i18nCopy.en;

  // Build Launcher Button
  const launcher = document.createElement('button');
  launcher.id = 'aiChatLauncher';
  launcher.type = 'button';
  launcher.className = 'ai-chat-launcher';
  launcher.setAttribute('aria-label', getCopy().tooltip);
  launcher.innerHTML = `
    <span class="ai-chat-tooltip"></span>
    <span class="ai-chat-badge">AI</span>
    <img src="logo/lsk.png" alt="Maju LSK AI" class="ai-icon-chat ai-launcher-logo" />
    <svg class="ai-icon-close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" style="display:none;" aria-hidden="true">
      <line x1="18" y1="6" x2="6" y2="18"></line>
      <line x1="6" y1="6" x2="18" y2="18"></line>
    </svg>
  `;

  // Build Chat Panel
  const panel = document.createElement('section');
  panel.id = 'aiChatPanel';
  panel.className = 'ai-chat-panel';
  panel.setAttribute('role', 'dialog');
  panel.setAttribute('aria-label', getCopy().title);
  panel.innerHTML = `
    <div class="ai-chat-header">
      <div class="ai-chat-header-info">
        <div class="ai-chat-avatar" aria-hidden="true">
          <img src="logo/lsk.png" alt="Maju LSK" />
        </div>
        <div class="ai-chat-title-wrap">
          <h3 class="ai-chat-title"></h3>
          <div class="ai-chat-status">
            <span class="ai-chat-status-dot"></span>
            <span class="ai-chat-status-text"></span>
          </div>
        </div>
      </div>
      <div class="ai-chat-header-actions">
        <button type="button" class="ai-chat-icon-btn ai-chat-clear" aria-label="Clear">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="3 6 5 6 21 6"></polyline>
            <path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"></path>
            <path d="M10 11v6"></path>
            <path d="M14 11v6"></path>
          </svg>
        </button>
        <button type="button" class="ai-chat-icon-btn ai-chat-close" aria-label="Close">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="18" y1="6" x2="6" y2="18"></line>
            <line x1="6" y1="6" x2="18" y2="18"></line>
          </svg>
        </button>
      </div>
    </div>
    <div class="ai-chat-messages" id="aiChatMessages"></div>
    <form class="ai-chat-input-bar" id="aiChatForm">
      <input type="text" class="ai-chat-input" id="aiChatInput" autocomplete="off" maxlength="500" />
      <button type="submit" class="ai-chat-send" id="aiChatSend" aria-label="Send">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
          <line x1="22" y1="2" x2="11" y2="13"></line>
          <polygon points="22 2 15 22 11 13 2 9 22 2"></polygon>
        </svg>
      </button>
    </form>
  `;

  document.body.appendChild(panel);
  document.body.appendChild(launcher);

  const tooltipEl = launcher.querySelector('.ai-chat-tooltip');
  const iconChat = launcher.querySelector('.ai-icon-chat');
  const iconClose = launcher.querySelector('.ai-icon-close');
  const titleEl = panel.querySelector('.ai-chat-title');
  const statusEl = panel.querySelector('.ai-chat-status-text');
  const clearBtn = panel.querySelector('.ai-chat-clear');
  const closeBtn = panel.querySelector('.ai-chat-close');
  const messagesEl = panel.querySelector('#aiChatMessages');
  const formEl = panel.querySelector('#aiChatForm');
  const inputEl = panel.querySelector('#aiChatInput');
  const sendBtn = panel.querySelector('#aiChatSend');

  let isOpen = false;
  let isBusy = false;
  let conversation = [];

  try {
    const saved = sessionStorage.getItem(CHAT_STORAGE_KEY);
    if (saved) {
      const parsed = JSON.parse(saved);
      if (Array.isArray(parsed)) conversation = parsed;
    }
  } catch (e) {
    conversation = [];
  }

  function saveConversation() {
    try {
      sessionStorage.setItem(CHAT_STORAGE_KEY, JSON.stringify(conversation.slice(-20)));
    } catch (e) {
      // Ignore storage quota errors
    }
  }

  function syncLabels() {
    const c = getCopy();
    tooltipEl.textContent = c.tooltip;
    launcher.setAttribute('aria-label', c.tooltip);
    titleEl.textContent = c.title;
    statusEl.textContent = c.status;
    inputEl.placeholder = c.placeholder;
    clearBtn.title = c.clearTitle;
    closeBtn.title = c.closeTitle;
  }

  // Safe inline text formatter (supports **bold** and bullet lines without innerHTML XSS)
  function renderFormattedText(container, text) {
    const lines = String(text || '').split(/\r?\n/);
    let currentList = null;

    const appendInline = (parent, lineText) => {
      const parts = lineText.split(/(\*\*[^*]+\*\*)/g);
      parts.forEach(part => {
        if (part.startsWith('**') && part.endsWith('**') && part.length > 4) {
          const strong = document.createElement('strong');
          strong.textContent = part.slice(2, -2);
          parent.appendChild(strong);
        } else if (part) {
          parent.appendChild(document.createTextNode(part));
        }
      });
    };

    lines.forEach(rawLine => {
      const line = rawLine.trim();
      if (!line) {
        currentList = null;
        return;
      }
      if (/^[-*•]\s+/.test(line)) {
        if (!currentList) {
          currentList = document.createElement('ul');
          container.appendChild(currentList);
        }
        const li = document.createElement('li');
        appendInline(li, line.replace(/^[-*•]\s+/, ''));
        currentList.appendChild(li);
      } else {
        currentList = null;
        const p = document.createElement('p');
        appendInline(p, line);
        container.appendChild(p);
      }
    });
  }

  function buildProductCard(product) {
    const card = document.createElement('a');
    card.className = 'ai-chat-product-card';

    const qp = new URLSearchParams();
    if (product.category_slug) qp.set('category', product.category_slug);
    if (product.subcategory_slug) qp.set('subcategory', product.subcategory_slug);
    if (product.brand_slug) qp.set('brand', product.brand_slug);
    if (currentLang && currentLang !== 'ms') qp.set('lang', currentLang);
    card.href = `products.html${qp.toString() ? '?' + qp.toString() : ''}`;

    const thumb = document.createElement('div');
    thumb.className = 'ai-chat-product-thumb';
    const img = document.createElement('img');
    img.src = product.image_url || 'logo/lsk.png';
    img.alt = product.name || 'Product';
    img.loading = 'lazy';
    img.onerror = () => { img.src = 'logo/lsk.png'; };
    thumb.appendChild(img);

    const info = document.createElement('div');
    info.className = 'ai-chat-product-info';

    if (product.brand_name) {
      const brand = document.createElement('span');
      brand.className = 'ai-chat-product-brand';
      brand.textContent = product.brand_name;
      info.appendChild(brand);
    }

    const name = document.createElement('div');
    name.className = 'ai-chat-product-name';
    name.textContent = product.name || '';
    info.appendChild(name);

    const catText = product.subcategory_name || product.category_name || '';
    if (catText) {
      const cat = document.createElement('div');
      cat.className = 'ai-chat-product-cat';
      cat.textContent = catText;
      info.appendChild(cat);
    }

    card.appendChild(thumb);
    card.appendChild(info);
    return card;
  }

  function appendMessageElement(role, text, products = []) {
    const wrapper = document.createElement('div');
    wrapper.className = `ai-chat-msg ${role}`;

    const bubble = document.createElement('div');
    bubble.className = 'ai-chat-bubble';
    renderFormattedText(bubble, text);
    wrapper.appendChild(bubble);

    if (role === 'assistant' && Array.isArray(products) && products.length > 0) {
      const grid = document.createElement('div');
      grid.className = 'ai-chat-products';
      products.forEach(p => grid.appendChild(buildProductCard(p)));
      wrapper.appendChild(grid);
    }

    messagesEl.appendChild(wrapper);
    messagesEl.scrollTop = messagesEl.scrollHeight;
  }

  function renderAllMessages() {
    messagesEl.innerHTML = '';
    const c = getCopy();
    appendMessageElement('assistant', c.welcome);

    if (conversation.length === 0) {
      const chipsWrap = document.createElement('div');
      chipsWrap.className = 'ai-chat-chips';
      c.chips.forEach(chipText => {
        const chip = document.createElement('button');
        chip.type = 'button';
        chip.className = 'ai-chat-chip';
        chip.textContent = chipText;
        chip.addEventListener('click', () => {
          if (!isBusy) sendMessage(chipText);
        });
        chipsWrap.appendChild(chip);
      });
      messagesEl.appendChild(chipsWrap);
    } else {
      conversation.forEach(item => {
        appendMessageElement(item.role, item.content, item.products || []);
      });
    }
  }

  function showTyping() {
    const typingWrap = document.createElement('div');
    typingWrap.className = 'ai-chat-msg assistant';
    typingWrap.id = 'aiChatTyping';
    typingWrap.innerHTML = '<div class="ai-chat-typing"><span></span><span></span><span></span></div>';
    messagesEl.appendChild(typingWrap);
    messagesEl.scrollTop = messagesEl.scrollHeight;
  }

  function hideTyping() {
    const el = document.getElementById('aiChatTyping');
    if (el) el.remove();
  }

  async function sendMessage(text) {
    const clean = text.trim();
    if (!clean || isBusy) return;

    // Remove starter chips if visible
    const chips = messagesEl.querySelector('.ai-chat-chips');
    if (chips) chips.remove();

    isBusy = true;
    sendBtn.disabled = true;
    inputEl.value = '';

    const historyPayload = conversation.slice(-6).map(m => ({
      role: m.role,
      content: m.content
    }));

    conversation.push({ role: 'user', content: clean });
    saveConversation();
    appendMessageElement('user', clean);
    showTyping();

    try {
      const res = await fetch('api/chat.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          message: clean,
          history: historyPayload,
          lang: currentLang || 'en'
        })
      });

      const data = await res.json();
      hideTyping();

      if (!res.ok || !data || !data.reply) {
        throw new Error(data?.error || 'Request failed');
      }

      const products = Array.isArray(data.products) ? data.products : [];
      conversation.push({ role: 'assistant', content: data.reply, products });
      saveConversation();
      appendMessageElement('assistant', data.reply, products);
    } catch (err) {
      hideTyping();
      const errText = getCopy().errorMsg;
      appendMessageElement('assistant', errText);
    } finally {
      isBusy = false;
      sendBtn.disabled = false;
      inputEl.focus();
    }
  }

  function togglePanel(forceState) {
    isOpen = typeof forceState === 'boolean' ? forceState : !isOpen;
    panel.classList.toggle('is-open', isOpen);
    launcher.classList.toggle('is-open', isOpen);
    iconChat.style.display = isOpen ? 'none' : 'block';
    iconClose.style.display = isOpen ? 'block' : 'none';
    if (isOpen) {
      syncLabels();
      setTimeout(() => inputEl.focus(), 180);
    }
  }

  launcher.addEventListener('click', () => togglePanel());
  closeBtn.addEventListener('click', () => togglePanel(false));
  clearBtn.addEventListener('click', () => {
    conversation = [];
    saveConversation();
    renderAllMessages();
  });

  formEl.addEventListener('submit', e => {
    e.preventDefault();
    sendMessage(inputEl.value);
  });

  // Sync labels & welcome greeting if user switches language
  document.querySelectorAll('.lang-option').forEach(opt => {
    opt.addEventListener('click', () => {
      setTimeout(() => {
        syncLabels();
        renderAllMessages();
      }, 60);
    });
  });

  syncLabels();
  renderAllMessages();
}
