/* ============================================
   MAJU LSK LOGISTICS & FOODFARE SDN BHD
   Script — Trilingual, Animations, Interactivity
   ============================================ */

// ============ TRANSLATIONS ============
const translations = {
  "ms": {
    "nav_home": "Utama",
    "nav_about": "Tentang Kami",
    "nav_products": "Produk",
    "nav_locations": "Lokasi",
    "nav_contact": "Hubungi Kami",
    "seo_home_title": "Maju LSK - Pengimport & Pemborong Makanan Premium di Brunei",
    "seo_home_desc": "Maju LSK Logistics and Foodfare adalah pengimport utama bahan makanan premium di Brunei Darussalam. Kami membekal kepada bakeri, restoran, dan pasar raya.",
    "seo_about_title": "Tentang Kami - Maju LSK Logistics and Foodfare",
    "seo_about_desc": "Kenali sejarah Maju LSK, nilai-nilai kami, dan dedikasi kami dalam menyediakan produk makanan terbaik untuk pasaran Brunei.",
    "seo_products_title": "Produk & Jenama - Maju LSK Foodfare",
    "seo_products_desc": "Lihat rangkaian produk kami yang luas, termasuk barangan sejuk beku, bahan bakeri, tenusu, dan banyak lagi dari jenama global terkemuka.",
    "seo_location_title": "Lokasi & Cawangan - Maju LSK Group",
    "seo_location_desc": "Cari cawangan Maju LSK, Ji-Mart Enterprise, Syarikat Andong, Iburia, dan Mas Grocery Store di seluruh Brunei.",
    "seo_contact_title": "Hubungi Kami - Maju LSK Logistics and Foodfare",
    "seo_contact_desc": "Hubungi pasukan kami untuk sebarang pertanyaan perniagaan, perkongsian, atau maklum balas produk.",
    "hero_title": "MAJU LSK",
    "hero_subtitle_line": "LOGISTICS AND FOODFARE SDN BHD",
    "hero_desc": "Rakan kongsi anda dalam kecemerlangan perkhidmatan makanan. Pengimport dan pemborong utama bahan makanan premium di Negara Brunei Darussalam.",
    "hero_cta_products": "Lihat Produk",
    "hero_cta_contact": "Hubungi Kami",
    "hero_scroll": "Tatal ke bawah",
    "stat_agencies": "Agensi Tempatan & Antarabangsa",
    "stat_products": "Rangkaian Produk",
    "stat_years": "Tahun Pengedaran",
    "stat_outlets": "Outlet Runcit",
    "about_title": "Kecemerlangan Makanan, Warisan Berkekalan",
    "about_p1": "Maju LSK Logistics and Foodfare Sdn Bhd ialah rakan kongsi anda yang berdedikasi dalam meningkatkan kecemerlangan perkhidmatan makanan. Sebagai pengimport dan pemborong utama bahan makanan premium di Negara Brunei Darussalam, kami menyediakan rangkaian produk komprehensif yang disesuaikan untuk keperluan kedai roti, kedai kopi, dan pertubuhan perkhidmatan makanan lain.",
    "about_p2": "Komitmen kami terhadap kualiti, ditambah dengan pilihan produk yang meluas and perkhidmatan yang boleh dipercayai, memastikan anda mempunyai segala yang diperlukan untuk mencipta pengalaman masakan yang luar biasa.",
    "about_p3": "Maju LSK Logistics & Foodfare Sdn Bhd ialah pengedar tunggal dan dilantik untuk lebih daripada 50 agensi tempatan dan luar negara.",
    "lsk_meaning": "<p><strong>LSK</strong> bermaksud <strong>Lau Sim King</strong> — nama arwah ibu kepada pengasas dan CEO, Encik Sam Ying Kok. Nama syarikat ini adalah penghormatan dan dedikasi kasih sayang beliau kepada ibundanya, menjadikan Maju LSK bukan sekadar perniagaan, tetapi warisan keluarga.</p>",
    "about_f1_title": "Sumber Global",
    "about_f1_desc": "Bahan terbaik dari seluruh dunia",
    "about_f2_title": "Produk Premium",
    "about_f2_desc": "Kualiti terjamin untuk perniagaan anda",
    "about_f3_title": "Rantaian Bekalan",
    "about_f3_desc": "Penghantaran konsisten & boleh dipercayai",
    "about_f4_title": "Integriti Utama",
    "about_f4_desc": "Integriti & amanah dalam setiap urusan",
    "sub_title": "Rangkaian Pengedaran Kami",
    "sub_desc": "Rangkaian pengedaran meluas kami dikuasakan oleh dua syarikat pengedaran yang berdedikasi.",
    "jimart_name": "Ji-Mart Enterprise",
    "jimart_desc": "Kedai sehenti anda untuk tepung, coklat, dan keperluan kertas. Pembekal utama penyelesaian komprehensif untuk pasar mini dan pasar raya.",
    "andong_name": "Syarikat Andong",
    "andong_desc": "Pembekal penting anda untuk produk tenusu, sejuk beku, dan produk kertas. Juga pengedar tunggal untuk Genki! Baby Diaper di Brunei.",
    "prod_title": "Produk & Jenama Kami",
    "prod_desc": "Terokai rangkaian produk komprehensif kami yang disusun secara sistematik mengikut kategori dan jenama.",
    "filter_all": "Semua",
    "filter_base": "Bahan Asas",
    "filter_beverage": "Minuman",
    "filter_chocolate": "Coklat",
    "filter_cooking": "Bahan Masakan",
    "filter_fats_flour": "Lemak & Tepung",
    "filter_frozen": "Sejuk Beku",
    "filter_instant": "Snek & Segera",
    "filter_consumables": "Keperluan Harian",
    "prod_fries": "Kentang Goreng",
    "prod_dimsum": "Dim Sum",
    "prod_cake": "Kek & Pencuci Mulut",
    "desc_flour_1": "Tepung gandum serbaguna berkualiti tinggi.",
    "desc_flour_2": "Tepung premium khas untuk pembuatan roti & kek.",
    "desc_fats_1": "Mentega tulen dari New Zealand untuk hasil bakeri unggul.",
    "desc_bev_1": "Teh premium untuk kegunaan restoran dan kafe.",
    "desc_choc_1": "Coklat kompaun untuk pelbagai aplikasi bakeri.",
    "desc_frozen_1": "Dim sum sejuk beku sedia untuk dikukus.",
    "brands_title": "Jenama Dipercayai",
    "brands_desc": "Kami bekerja dengan jenama terkemuka di peringkat global untuk menjamin kualiti.",
    "brand_filter_all": "Semua",
    "brand_filter_andong": "Syarikat Andong",
    "brand_filter_jimart": "Ji-Mart Enterprise",
    "partner_title": "Sertai Rangkaian Jenama Kami",
    "partner_desc": "Berminat untuk menjadi rakan kongsi pengedaran kami? Kami sentiasa mencari jenama dan pembekal baharu untuk mengembangkan rangkaian produk kami di Brunei Darussalam.",
    "partner_btn": "Hubungi Kami Sekarang →",
    "loc_title": "Lokasi Kami",
    "loc_desc": "Cari ibu pejabat dan kedai-kedai kami di seluruh Brunei Darussalam.",
    "loc_andong": "Syarikat Andong",
    "loc_andong_addr": "Mulaut Industrial Parkland, Unit 1-6, Blok L, Simpang 113, Jalan Ban 5, Kg Mulaut, Mukim Sengkurong, BG2121 Brunei Darussalam.",
    "loc_jimart": "Ji-Mart Enterprise",
    "loc_jimart_addr": "Mulaut Industrial Parkland, Brunei Darussalam",
    "loc_iburia": "Iburia Sdn Bhd",
    "loc_iburia_addr": "Unit 2, Bangunan Sri Nor, Simpang 158, Gadong B, Brunei Darussalam",
    "loc_mgs": "Mas Grocery Store (MGS)",
    "loc_mgs_addr": "Block A, Simpang 659, Jangsak, Jalan Gadong, Bandar Seri Begawan BE1118, Brunei Darussalam",
    "pic_title": "Pegawai Bertanggungjawab",
    "person_hq_role": "Pengasas & CEO",
    "person_hq_hours": "Isnin - Sabtu: 8pg - 5ptg",
    "person_jimart_role": "Pengedar Makanan & Bakeri",
    "person_jimart_hours": "Isnin - Sabtu: 8pg - 5ptg",
    "person_andong_role": "Pengedar Tenusu & Sejuk Beku",
    "person_andong_hours": "Isnin - Sabtu: 8pg - 5ptg",
    "person_iburia_role": "Runcit & Pengedaran",
    "person_iburia_hours": "Isnin - Sabtu: 8pg - 5ptg",
    "person_mgs_role": "Kedai Runcit",
    "person_mgs_hours": "Isnin - Sabtu: 8pg - 5ptg",
    "events_title": "Acara & Aktiviti",
    "events_desc": "Sertai kami dalam pelbagai acara dan aktiviti sepanjang tahun.",
    "event1_name": "Demo Greenhouse 2024",
    "event2_name": "Pameran Pengguna 2021",
    "event3_name": "Pasaran Gudang 2020",
    "event4_name": "Pameran Pengguna 2020",
    "contact_title": "Hubungi Kami",
    "contact_desc": "Pasukan sokongan kami sedia membantu anda. Hubungi kami sekarang.",
    "contact_addr_title": "Alamat",
    "contact_addr": "Unit 1-10, Blk L, Mulaut Industrial Parkland, Spg 113, Jalan Ban 5, Kg. Mulaut, BG2121, Brunei",
    "contact_phone_title": "Telefon",
    "contact_email_title": "E-mel",
    "contact_hours_title": "Waktu Operasi",
    "contact_hours": "Isnin - Sabtu: 8pg - 5ptg",
    "form_title": "Hantar Mesej",
    "form_name": "Nama Penuh",
    "form_email": "Alamat E-mel",
    "form_enquiry": "Jenis Pertanyaan",
    "form_enquiry_select": "-- Pilih Jenis Pertanyaan --",
    "form_enquiry_general": "Pertanyaan Umum",
    "form_enquiry_partnership": "Perkongsian / Rakan Niaga",
    "form_enquiry_brand": "Sertai Rangkaian Jenama",
    "form_enquiry_team": "Sertai Pasukan Kami",
    "form_enquiry_product": "Pertanyaan Produk",
    "form_enquiry_feedback": "Maklum Balas",
    "form_message": "Mesej Anda",
    "form_submit": "Hantar Mesej",
    "footer_desc": "Rakan kongsi anda yang dipercayai dalam pengedaran makanan & keperluan di Negara Brunei Darussalam.",
    "footer_quick": "Pautan Pantas",
    "footer_companies": "Syarikat Kami",
    "footer_contact_info": "Maklumat Hubungan",
    "footer_connect": "Ikuti Kami",
    "footer_rights": "© 2024 Maju LSK Logistics and Foodfare Sdn Bhd. Hak cipta terpelihara.",
    "prod_disclaimer": "<strong>Penafian:</strong> Tidak semua produk dipaparkan dalam senarai ini. Sila rujuk <a href='tentang-kami.html#subsidiaries'>katalog produk</a> rasmi kami untuk maklumat lanjut dan senarai produk yang lengkap.",
  },
  "en": {
    "nav_home": "Home",
    "nav_about": "About Us",
    "nav_products": "Products",
    "nav_locations": "Locations",
    "nav_contact": "Contact Us",
    "seo_home_title": "Maju LSK - Premium Food Importer & Wholesaler in Brunei",
    "seo_home_desc": "Maju LSK Logistics and Foodfare is a leading importer of premium food ingredients in Brunei Darussalam. Serving bakeries, restaurants, and supermarkets.",
    "seo_about_title": "About Us - Maju LSK Logistics and Foodfare",
    "seo_about_desc": "Learn about the history of Maju LSK, our values, and our dedication to providing the best food products for the Brunei market.",
    "seo_products_title": "Products & Brands - Maju LSK Foodfare",
    "seo_products_desc": "Explore our wide range of products, including frozen goods, bakery ingredients, dairy, and much more from leading global brands.",
    "seo_location_title": "Locations & Branches - Maju LSK Group",
    "seo_location_desc": "Find branches of Maju LSK, Ji-Mart Enterprise, Syarikat Andong, Iburia, and Mas Grocery Store across Brunei.",
    "seo_contact_title": "Contact Us - Maju LSK Logistics and Foodfare",
    "seo_contact_desc": "Contact our team for any business inquiries, partnerships, or product feedback.",
    "hero_title": "MAJU LSK",
    "hero_subtitle_line": "LOGISTICS AND FOODFARE SDN BHD",
    "hero_desc": "Your dedicated partner in food service excellence. Leading importer and wholesaler of premium food ingredients in Brunei Darussalam.",
    "hero_cta_products": "View Products",
    "hero_cta_contact": "Contact Us",
    "hero_scroll": "Scroll Down",
    "stat_agencies": "Local & Overseas Agencies",
    "stat_products": "Product Range",
    "stat_years": "Years of Distribution",
    "stat_outlets": "Retail Outlets",
    "about_title": "Food Excellence, Lasting Legacy",
    "about_p1": "Maju LSK Logistics and Foodfare Sdn Bhd is your dedicated partner in enhancing food service excellence. As a leading importer and wholesaler of premium food ingredients in Brunei Darussalam, we provide a comprehensive range of products tailored for the needs of bakeries, coffee shops, and other food service establishments.",
    "about_p2": "Our commitment to quality, coupled with an extensive product selection and reliable service, ensures you have everything needed to create exceptional culinary experiences.",
    "about_p3": "Maju LSK Logistics & Foodfare Sdn Bhd is the sole and appointed distributor for over 50 local and overseas agencies.",
    "lsk_meaning": "<p><strong>LSK</strong> stands for <strong>Lau Sim King</strong> — the name of the late mother of founded and CEO, Mr. Sam Ying Kok. The company name is a tribute and dedication of his love to his mother, making Maju LSK not just a business, but a family legacy.</p>",
    "about_f1_title": "Global Sourcing",
    "about_f1_desc": "The best ingredients from around the world",
    "about_f2_title": "Premium Products",
    "about_f2_desc": "Guaranteed quality for your business",
    "about_f3_title": "Supply Chain",
    "about_f3_desc": "Consistent & reliable delivery",
    "about_f4_title": "Integrity First",
    "about_f4_desc": "Integrity & trust in every transaction",
    "sub_title": "Our Distribution Network",
    "sub_desc": "Our extensive distribution network is powered by two dedicated distribution companies.",
    "jimart_name": "Ji-Mart Enterprise",
    "jimart_desc": "Your one-stop shop for flour, chocolate, and paper needs. Leading supplier of comprehensive solutions for mini-marts and supermarkets.",
    "andong_name": "Syarikat Andong",
    "andong_desc": "Your essential supplier for dairy, frozen, and paper products. Also the sole distributor for Genki! Baby Diaper in Brunei.",
    "prod_title": "Our Products & Brands",
    "prod_desc": "Explore our comprehensive product range systematically organized by category and brand.",
    "filter_all": "All",
    "filter_base": "Base Ingredients",
    "filter_beverage": "Beverage",
    "filter_chocolate": "Chocolate",
    "filter_cooking": "Cooking Ingredients",
    "filter_fats_flour": "Fats & Flour",
    "filter_frozen": "Frozen Food",
    "filter_instant": "Snacks & Instant",
    "filter_consumables": "Consumables",
    "prod_fries": "French Fries",
    "prod_dimsum": "Dim Sum",
    "prod_cake": "Cakes & Desserts",
    "desc_flour_1": "High-quality all-purpose wheat flour.",
    "desc_flour_2": "Premium flour specially for bread & cakes.",
    "desc_fats_1": "Pure butter from New Zealand for superior baking.",
    "desc_bev_1": "Premium tea for restaurants and cafes.",
    "desc_choc_1": "Compound chocolate for various bakery applications.",
    "desc_frozen_1": "Ready-to-steam frozen dim sum.",
    "brands_title": "Trusted Brands",
    "brands_desc": "We partner with leading global brands to guarantee quality.",
    "brand_filter_all": "All",
    "brand_filter_andong": "Syarikat Andong",
    "brand_filter_jimart": "Ji-Mart Enterprise",
    "partner_title": "Join Our Brand Network",
    "partner_desc": "Interested in becoming a distribution partner? We are always looking for new brands and suppliers to expand our product range in Brunei Darussalam.",
    "partner_btn": "Contact Us Now →",
    "loc_title": "Our Locations",
    "loc_desc": "Find our headquarters and retail outlets across Brunei Darussalam.",
    "loc_andong": "Syarikat Andong",
    "loc_andong_addr": "Mulaut Industrial Parkland, Unit 1-6, Block L, Simpang 113, Jalan Ban 5, Kg Mulaut, Mukim Sengkurong, BG2121 Brunei Darussalam.",
    "loc_jimart": "Ji-Mart Enterprise",
    "loc_jimart_addr": "Mulaut Industrial Parkland, Brunei Darussalam",
    "loc_iburia": "Iburia Sdn Bhd",
    "loc_iburia_addr": "Unit 2, Bangunan Sri Nor, Simpang 158, Gadong B, Brunei Darussalam",
    "loc_mgs": "Mas Grocery Store (MGS)",
    "loc_mgs_addr": "Block A, Simpang 659, Jangsak, Jalan Gadong, Bandar Seri Begawan BE1118, Brunei Darussalam",
    "pic_title": "Person In Charge",
    "person_hq_role": "Founder & CEO",
    "person_hq_hours": "Mon - Sat: 8am - 5pm",
    "person_jimart_role": "Food & Bakery Distributor",
    "person_jimart_hours": "Mon - Sat: 8am - 5pm",
    "person_andong_role": "Dairy & Frozen Distributor",
    "person_andong_hours": "Mon - Sat: 8am - 5pm",
    "person_iburia_role": "Retail & Distribution",
    "person_iburia_hours": "Mon - Sat: 8am - 5pm",
    "person_mgs_role": "Grocery Store",
    "person_mgs_hours": "Mon - Sat: 8am - 5pm",
    "events_title": "Events & Activities",
    "events_desc": "Join us in our various events and activities throughout the year.",
    "event1_name": "Greenhouse Demo 2024",
    "event2_name": "Consumer Fair 2021",
    "event3_name": "Warehouse Market 2020",
    "event4_name": "Consumer Fair 2020",
    "contact_title": "Contact Us",
    "contact_desc": "Our support team is here to help. Get in touch with us now.",
    "contact_addr_title": "Address",
    "contact_addr": "Unit 1-10, Blk L, Mulaut Industrial Parkland, Spg 113, Jalan Ban 5, Kg. Mulaut, BG2121, Brunei",
    "contact_phone_title": "Phone",
    "contact_email_title": "Email",
    "contact_hours_title": "Operating Hours",
    "contact_hours": "Mon - Sat: 8am - 5pm",
    "form_title": "Send a Message",
    "form_name": "Full Name",
    "form_email": "Email Address",
    "form_enquiry": "Enquiry Type",
    "form_enquiry_select": "-- Select Enquiry Type --",
    "form_enquiry_general": "General Enquiry",
    "form_enquiry_partnership": "Partnership",
    "form_enquiry_brand": "Join Brand Network",
    "form_enquiry_team": "Join Our Team",
    "form_enquiry_product": "Product Enquiry",
    "form_enquiry_feedback": "Feedback",
    "form_message": "Your Message",
    "form_submit": "Send Message",
    "footer_desc": "Your trusted partner in food & essentials distribution in Negara Brunei Darussalam.",
    "footer_quick": "Quick Links",
    "footer_companies": "Our Companies",
    "footer_contact_info": "Contact Info",
    "footer_connect": "Follow Us",
    "prod_disclaimer": "<strong>Disclaimer:</strong> Not all products are shown in this list. Please refer to our official <a href='tentang-kami.html#subsidiaries'>product catalogues</a> for the complete range and full details.",
    "footer_rights": "© 2024 Maju LSK Logistics and Foodfare Sdn Bhd. All rights reserved."
  },
  "zh": {
    "nav_home": "首页",
    "nav_about": "关于我们",
    "nav_products": "产品",
    "nav_locations": "位置",
    "nav_contact": "联系我们",
    "seo_home_title": "Maju LSK - 文莱优质食品进口商与批发商",
    "seo_home_desc": "Maju LSK 物流及食品有限公司是文莱达鲁萨兰国领先的优质食材进口商。为烘焙店、餐厅和超市提供服务。",
    "seo_about_title": "关于我们 - Maju LSK Logistics and Foodfare",
    "seo_about_desc": "了解 Maju LSK 的历史、我们的价值观以及我们致力于为文莱市场提供最佳食品的决心。",
    "seo_products_title": "产品与品牌 - Maju LSK Foodfare",
    "seo_products_desc": "探索我们广泛的产品系列，包括冷冻食品、烘焙原料、乳制品等来自全球领先品牌的商品。",
    "seo_location_title": "地点与分店 - Maju LSK Group",
    "seo_location_desc": "查找遍布文莱的 Maju LSK、Ji-Mart Enterprise、Syarikat Andong、Iburia 和 Mas Grocery Store 分店。",
    "seo_contact_title": "联系我们 - Maju LSK Logistics and Foodfare",
    "seo_contact_desc": "如有任何业务查询、合作意向或产品反馈，请联系我们的团队。",
    "hero_title": "MAJU LSK",
    "hero_subtitle_line": "物流及食品有限公司",
    "hero_desc": "您在提升食品服务卓越方面的忠实合作伙伴。文莱达鲁萨兰国领先的优质食材进口商和批发商。",
    "hero_cta_products": "查看产品",
    "hero_cta_contact": "联系我们",
    "hero_scroll": "向下滚动",
    "stat_agencies": "本地和海外代理店",
    "stat_products": "产品种类",
    "stat_years": "分销经验",
    "stat_outlets": "零售店",
    "about_title": "食品卓越，传承永续",
    "about_p1": "Maju LSK Logistics and Foodfare 有限公司是您在提升食品服务卓越方面的忠实合作伙伴。作为文莱达鲁萨兰国领先的优质食材进口商和批发商，我们提供全面的产品系列，满足面包店、咖啡店及其他食品服务场所的需求。",
    "about_p2": "我们对品质的承诺，加上广泛的产品选择和可靠的服务，确保您拥有创造非凡烹饪体验所需的一切。",
    "about_p3": "Maju LSK Logistics & Foodfare 有限公司是超过50个本地和海外代理的唯一指定经销商。",
    "lsk_meaning": "<p><strong>LSK</strong> 代表 <strong>Lau Sim King</strong> — 创始人兼首席执行官 Sam Ying Kok 先生已故母亲的名字。公司名称是对母亲的致敬与爱的奉献，使 Maju LSK 不仅仅是一家企业，更是家族的传承。</p>",
    "about_f1_title": "全球采购",
    "about_f1_desc": "来自世界各地的最佳原料",
    "about_f2_title": "优质产品",
    "about_f2_desc": "为您的业务提供质量保证",
    "about_f3_title": "供应链",
    "about_f3_desc": "持续可靠的交付",
    "about_f4_title": "诚信为本",
    "about_f4_desc": "在每笔交易中的诚信和信任",
    "sub_title": "我们的分销网络",
    "sub_desc": "我们广泛的分销网络由两家专业分销公司支持。",
    "jimart_name": "Ji-Mart Enterprise",
    "jimart_desc": "您的面粉、巧克力和纸品一站式商店。为迷你市场和超市提供全面解决方案的领先供应商。",
    "andong_name": "Syarikat Andong",
    "andong_desc": "乳制品、冷冻食品和纸品的重要供应商。同时也是Genki! 婴儿尿布在文莱的唯一经销商。",
    "prod_title": "我们的产品和品牌",
    "prod_desc": "探索我们按类别和品牌系统组织的全面产品系列。",
    "filter_all": "全部",
    "filter_base": "基础配料",
    "filter_beverage": "饮料",
    "filter_chocolate": "巧克力",
    "filter_cooking": "烹饪配料",
    "filter_fats_flour": "油脂与面粉",
    "filter_frozen": "冷冻食品",
    "filter_instant": "零食与方便食品",
    "filter_consumables": "日常用品",
    "prod_fries": "炸薯条",
    "prod_dimsum": "点心",
    "prod_cake": "蛋糕与甜点",
    "desc_flour_1": "高品质多用途小麦粉。",
    "desc_flour_2": "专为面包和蛋糕特制的优质面粉。",
    "desc_fats_1": "来自新西兰的纯正黄油，用于卓越烘焙。",
    "desc_bev_1": "用于餐厅和咖啡馆的优质茶叶。",
    "desc_choc_1": "适用于各种烘焙的复合巧克力。",
    "desc_frozen_1": "即蒸冷冻点心。",
    "brands_title": "信赖品牌",
    "brands_desc": "我们与全球领先品牌合作，以保证质量。",
    "brand_filter_all": "全部",
    "brand_filter_andong": "Syarikat Andong",
    "brand_filter_jimart": "Ji-Mart Enterprise",
    "partner_title": "加入我们的品牌网络",
    "partner_desc": "有兴趣成为我们的分销合作伙伴吗？我们一直在寻找新的品牌和供应商，以扩大我们在文莱的产品范围。",
    "partner_btn": "立即联系我们 →",
    "loc_title": "我们的地点",
    "loc_desc": "查找我们在文莱的总部和零售店。",
    "loc_andong": "Syarikat Andong",
    "loc_andong_addr": "文莱达鲁萨兰国，Mulaut 工业园区，1-6号单元，L栋",
    "loc_jimart": "Ji-Mart Enterprise",
    "loc_jimart_addr": "文莱达鲁萨兰国，Mulaut 工业园区",
    "loc_iburia": "Iburia Sdn Bhd",
    "loc_iburia_addr": "Unit 2, Bangunan Sri Nor, Simpang 158, Gadong B, 文莱达鲁萨兰国",
    "loc_mgs": "Mas Grocery Store (MGS)",
    "loc_mgs_addr": "Block A, Simpang 659, Jangsak, Jalan Gadong, 斯里巴加湾 BE1118, 文莱达鲁萨兰国",
    "pic_title": "负责人",
    "person_hq_role": "创始人兼首席执行官",
    "person_hq_hours": "周一至周六：上午8点 - 下午5点",
    "person_jimart_role": "食品与烘焙分销商",
    "person_jimart_hours": "周一至周六：上午8点 - 下午5点",
    "person_andong_role": "乳制品与冷冻分销商",
    "person_andong_hours": "周一至周六：上午8点 - 下午5点",
    "person_iburia_role": "零售与分销",
    "person_iburia_hours": "周一至周六：上午8点 - 下午5点",
    "person_mgs_role": "杂货店",
    "person_mgs_hours": "周一至周六：上午8点 - 下午5点",
    "events_title": "活动",
    "events_desc": "参加我们全年的各种活动。",
    "event1_name": "温室演示 2024",
    "event2_name": "消费者展览会 2021",
    "event3_name": "仓库市场 2020",
    "event4_name": "消费者展览会 2020",
    "contact_title": "联系我们",
    "contact_desc": "我们的支持团队随时为您服务。立即联系我们。",
    "contact_addr_title": "地址",
    "contact_addr": "文莱，Mulaut 工业园区",
    "contact_phone_title": "电话",
    "contact_email_title": "电子邮箱",
    "contact_hours_title": "营业时间",
    "contact_hours": "周一至周六：上午8点 - 下午5点",
    "form_title": "发送消息",
    "form_name": "全名",
    "form_email": "电子邮箱",
    "form_enquiry": "咨询类型",
    "form_enquiry_select": "-- 选择咨询类型 --",
    "form_enquiry_general": "一般查询",
    "form_enquiry_partnership": "合作伙伴",
    "form_enquiry_brand": "加入品牌网络",
    "form_enquiry_team": "加入我们的团队",
    "form_enquiry_product": "产品查询",
    "form_enquiry_feedback": "反馈意见",
    "form_message": "您的留言",
    "form_submit": "发送消息",
    "footer_desc": "您在文莱达鲁萨兰国食品和杂货分销方面的可靠合作伙伴。",
    "footer_quick": "快速链接",
    "footer_companies": "我们的公司",
    "footer_contact_info": "联系信息",
    "footer_connect": "关注我们",
    "prod_disclaimer": "<strong>免责声明：</strong>并非所有产品都列在此清单中。请参阅我们的官方<a href='tentang-kami.html#subsidiaries'>产品目录</a>以获取完整的产品范围和详细信息。",
    "footer_rights": "© 2024 Maju LSK Logistics and Foodfare Sdn Bhd. 版权所有。"
  }
};

// ============ PERSON IN CHARGE DATA ============
const personData = {
  hq: {
    name: "Encik Sam Ying Kok",
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
    email: "syarikatandong@gmail.com",
    hoursKey: "person_andong_hours",
    hoursFallback: "Isnin - Sabtu: 8pg - 5ptg",
    avatar: "logo/lsk.png"
  },
  iburia: {
    name: "Iburia Sdn Bhd",
    roleKey: "person_iburia_role",
    roleFallback: "Runcit & Pengedaran",
    phone: "+673 267 1161",
    email: "admin@majulskgroup.com",
    hoursKey: "person_iburia_hours",
    hoursFallback: "Isnin - Sabtu: 8pg - 5ptg",
    avatar: "logo/iburia.jpg"
  },
  mgs: {
    name: "Mas Grocery Store (MGS)",
    roleKey: "person_mgs_role",
    roleFallback: "Kedai Runcit",
    phone: "+673 267 1161",
    email: "admin@majulskgroup.com",
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

function setLanguage(lang) {
  currentLang = lang;
  const t = translations[lang] || translations['ms'];

  document.querySelectorAll('[data-i18n]').forEach(el => {
    const key = el.getAttribute('data-i18n');
    if (t[key]) {
      // Use textContent for standard labels
      el.textContent = t[key];
    }
  });

  // NEW: Handle HTML translations (like the disclaimer link)
  document.querySelectorAll('[data-i18n-html]').forEach(el => {
    const key = el.getAttribute('data-i18n-html');
    if (t[key]) {
      el.innerHTML = t[key];
    }
  });

  // Update all elements with data-i18n
  document.querySelectorAll('[data-i18n]').forEach(el => {
    const key = el.getAttribute('data-i18n');
    if (t[key]) {
      if (el.tagName === 'INPUT' || el.tagName === 'TEXTAREA') {
        el.placeholder = t[key];
      } else if (el.tagName === 'TITLE') {
        document.title = t[key];
      } else if (el.tagName === 'META') {
        el.setAttribute('content', t[key]);
      } else {
        el.textContent = t[key];
      }
    }
  });

  const metaDesc = document.querySelector('meta[name="description"]');
  if (metaDesc && t.seo_home_desc) {
    metaDesc.setAttribute('content', t.seo_home_desc);
  }

  const lskBlock = document.querySelector('[data-i18n-html="lsk_meaning"]');
  if (lskBlock && t.lsk_meaning) {
    lskBlock.innerHTML = t.lsk_meaning;
  }

  const langLabel = document.getElementById('langLabel');
  if (langLabel) {
    langLabel.textContent = langLabels[lang] || lang.toUpperCase();
  }

  document.querySelectorAll('.lang-dropdown-item').forEach(item => {
    const itemLang = item.getAttribute('data-lang');
    const isActive = itemLang === lang;
    item.classList.toggle('active', isActive);
    const check = item.querySelector('.check');
    if (check) {
      check.style.visibility = isActive ? 'visible' : 'hidden';
    }
  });

  if (typeof updatePersonPanel === 'function') updatePersonPanel();

  document.documentElement.lang = lang;
  localStorage.setItem('maju-lang', lang);
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

  const t = translations[currentLang] || translations['ms'];

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
      if(this.getAttribute('href').startsWith('#') && this.getAttribute('href').length > 1) {
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
        const waitMsg = currentLang === 'ms' ? `Sila tunggu ${timeLeft}s` : currentLang === 'zh' ? `请等待 ${timeLeft}秒` : `Please wait ${timeLeft}s`;
        
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
    
    // Show sending state and disable button to prevent double clicks
    btn.textContent = currentLang === 'ms' ? 'Menghantar...' : currentLang === 'zh' ? '发送中...' : 'Sending...';
    btn.style.opacity = '0.7';
    btn.disabled = true; 

    // Send data to Google Sheets (Using mode: 'no-cors' to bypass browser blocks)
    fetch(scriptURL, { 
        method: 'POST', 
        body: new FormData(form),
        mode: 'no-cors' 
    })
      .then(response => {
        // Success state
        btn.textContent = currentLang === 'ms' ? 'Terima kasih! ✓' : currentLang === 'zh' ? '谢谢！✓' : 'Thank you! ✓';
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
  scrollContainer.addEventListener('touchstart', () => isPaused = true, {passive: true});
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

// ============ INITIALIZATION ============
document.addEventListener('DOMContentLoaded', () => {
  document.body.classList.add('js-enabled');

  try {
    const savedLang = localStorage.getItem('maju-lang') || 'ms';
    setLanguage(savedLang); 
    
    initLangDropdown();
    initNavbar();
    initScrollAnimations();
    initSmoothScroll();
    initProductFilter();
    initBrandFilter();
    initInteractiveMap();
    initContactForm();
    initEventSlideshow();
    initEventsAutoScroll(); // <--- ADD THIS LINE HERE
  } catch (err) {
    console.error('Critical initialization error:', err);
    document.querySelectorAll('.reveal, .reveal-left, .reveal-right, .stagger-children').forEach(el => {
      el.classList.add('visible');
    });
  }
});
