# Project Structure: Maju LSK

This document provides an overview of the directory structure for the Maju LSK project.

> [!NOTE]
> Large dependency folders (`node_modules`) and version control files (`.git`) have been excluded for clarity.
> Backup folders (`old_version_backup`, etc.) have also been omitted from this tree to keep the overview concise.

## Tree Structure

```text
.
|-- api
|   |-- db.php
|   +-- products.php
|-- brands
|   |-- Ji-mart enterprise
|   |   |-- agromas.webp
|   |   |-- ak.webp
|   |   |-- akk.webp
|   |   |-- backaldrin.webp
|   |   |-- bakels.webp
|   |   |-- belcolade.webp
|   |   |-- callebaut.webp
|   |   |-- cap-mee-udang.webp
|   |   |-- cap-udang.webp
|   |   |-- cargill.webp
|   |   |-- chin kitchen.webp
|   |   |-- eggtech.webp
|   |   |-- ever-whip.webp
|   |   |-- gardens.webp
|   |   |-- greenhouse.webp
|   |   |-- happy.webp
|   |   |-- hiestand.webp
|   |   |-- interflour.webp
|   |   |-- jade-leaf.webp
|   |   |-- jongga.webp
|   |   |-- kawan.webp
|   |   |-- kimberly-clark.webp
|   |   |-- nbi.webp
|   |   |-- no1.webp
|   |   |-- ofood.webp
|   |   |-- opencountry.webp
|   |   |-- rnr.webp
|   |   |-- safcol.webp
|   |   |-- sampan.webp
|   |   |-- samyang.webp
|   |   |-- sky blue.webp
|   |   |-- star brand.webp
|   |   |-- sunflower.webp
|   |   |-- teans gourment.webp
|   |   |-- van-houten.webp
|   |   |-- vivo.webp
|   |   |-- win2.webp
|   |   +-- you-ai.webp
|   +-- Syarikat Andong
|       |-- anchor.webp
|       |-- arbella.webp
|       |-- aroma.webp
|       |-- bezt.webp
|       |-- bibigo.webp
|       |-- brumee.webp
|       |-- cafe-latte.webp
|       |-- cap-televisyen.webp
|       |-- charcoal.webp
|       |-- cozzo.webp
|       |-- d-jack.webp
|       |-- dtt.webp
|       |-- easy-meal-everyday.webp
|       |-- freshnsoz.webp
|       |-- genki.webp
|       |-- kitasama.webp
|       |-- lutosa.webp
|       |-- michigan.webp
|       |-- miga.webp
|       |-- minni.webp
|       |-- mykuali.webp
|       |-- nongshim.webp
|       |-- nutrifries.webp
|       |-- see-u.webp
|       |-- sifu.webp
|       |-- starmax.webp
|       |-- taukyung.webp
|       |-- tmfoods.webp
|       |-- tricious.webp
|       |-- VegeWorld.webp
|       |-- visvita.webp
|       +-- volvic.webp
|-- brochures
|   |-- andong_product-catalogue_rev07_compressed.pdf
|   +-- jimart_product-catalogue_rev07_compressed.pdf
|-- COPYRIGHT
|   |-- img
|   |   +-- LICENSE
|   +-- copyright
|-- events
|   |-- consumer-fair-2020
|   |   |-- event-2020-pic-1.webp
|   |   +-- event-2020-pic-2.webp
|   |-- consumer-fair-2021
|   |   |-- event-2020-pic-1.webp
|   |   |-- event-2020-pic-2.webp
|   |   +-- event-2020-pic-3.webp
|   |-- greenhouse-demo-2024
|   |   |-- event-2020-pic-1.webp
|   |   +-- event-2020-pic-2.webp
|   +-- warehouse-market-2020
|       |-- event-2020-pic-1.webp
|       |-- event-2020-pic-2.webp
|       +-- event-2020-pic-3.webp
|-- favicon_io
|   +-- favicon_io
|       |-- android-chrome-192x192.png
|       |-- android-chrome-512x512.png
|       |-- apple-touch-icon.png
|       |-- banner.jpg
|       |-- favicon-16x16.png
|       |-- favicon-32x32.png
|       +-- favicon.ico
|-- lang
|   |-- en.json
|   |-- ms.json
|   +-- zh.json
|-- logo
|   |-- iburia.jpg
|   |-- logo.webp
|   |-- lsk.png
|   |-- mgs.png
|   +-- red-white-logo.webp
|-- products
|   |-- Base
|   |   |-- Dried Fruit
|   |   |   +-- Redman
|   |   |       |-- Dried Cranberries.webp
|   |   |       |-- Mixed Fruits.webp
|   |   |       +-- Sultana.webp
|   |   |-- Nuts
|   |   |   |-- entegre
|   |   |   |   |-- Hazelnut Ground.webp
|   |   |   |   +-- Hazelnut Whole Blanched.webp
|   |   |   +-- Hughson Nut Inc
|   |   |       |-- Almond Flake.webp
|   |   |       |-- Almond Ground.webp
|   |   |       |-- Almond Nib.webp
|   |   |       +-- Almond Whole with Skin.webp
|   |   +-- Seeds
|   |       |-- Braun
|   |       |   +-- Bee Sting Mix.webp
|   |       |-- Franklin Baker
|   |       |   +-- Coconut Flake.webp
|   |       +-- Hughson Nut Inc
|   |           |-- Melon Seed.webp
|   |           |-- Pumpkin Seed.webp
|   |           +-- Sunflower Seed.webp
|   |-- Beverage
|   |   |-- Carbonated Drinks
|   |   |   +-- Sky Blue
|   |   |       |-- Cherry.webp
|   |   |       +-- Pineapple.webp
|   |   |-- Coffee
|   |   |   |-- Cap Televisyen Kluang Coffee
|   |   |   |   |-- Kopi-O 2 in 1.webp
|   |   |   |   |-- Kopi-O Kosong.webp
|   |   |   |   +-- White Coffee 2 in 1.webp
|   |   |   +-- Maeil
|   |   |       |-- My Cafe Latte Caramel Macchiato 220ml x 10cups.webp
|   |   |       +-- My Cafe Latte.webp
|   |   |-- Fruit Juice
|   |   |   |-- drinme
|   |   |   |   |-- Fruit Drink With Jelly Lemonade.webp
|   |   |   |   +-- Fruit Drink With Jelly Mix Berry.webp
|   |   |   |-- Fresh N Sqz
|   |   |   |   |-- Apple with Naca De Coco.webp
|   |   |   |   +-- Mango Passion (No Sugar Added).webp
|   |   |   |-- Nutrifres
|   |   |   |   +-- Concentrate.webp
|   |   |   +-- Visvita
|   |   |       |-- Aloe Vera Original.webp
|   |   |       +-- Aloe Vera Pineapple.webp
|   |   |-- Mineral Water
|   |   |   +-- Volvic
|   |   |       +-- Plain.webp
|   |   |-- Syrup
|   |   |   +-- Sky Blue
|   |   |       +-- Orange.webp
|   |   |-- Vinegar Drinks
|   |   |   +-- O'Food
|   |   |       |-- Hong Cho Vinegar Drinks Black Raspberry.webp
|   |   |       +-- Hong Cho Vinegar Drinks Blueberry.webp
|   |   +-- Water Gallon
|   |       +-- Sky Blue
|   |           +-- Empty Gallon.webp
|   |-- Bread, Pastray & Cakes Products
|   |   |-- Cake Stabilizers
|   |   |   +-- Bakels
|   |   |       +-- Ovalett Special.webp
|   |   +-- Frozen Egg
|   |       +-- Bakels
|   |           |-- Frozen Pasteurized Liquid Egg White - Stranding Order.webp
|   |           |-- Frozen Pasteurized Liquid Egg Yolk - Stranding Order.webp
|   |           +-- Frozen Pasteurized Liquid Whole Egg.webp
|   |-- Chocolate Products
|   |   |-- Cocoa Powder
|   |   |   +-- Tulip Cocoa
|   |   |       +-- Cocoa Powder.webp
|   |   |-- Compound
|   |   |   |-- Bakels
|   |   |   |   |-- Apito Chocolate Rice.webp
|   |   |   |   |-- Apito Colour Rice.webp
|   |   |   |   +-- Butterscotch Choco Chips.webp
|   |   |   |-- Patissien
|   |   |   |   +-- Compound Chips Dark.webp
|   |   |   +-- Van Houten
|   |   |       |-- Intense Dark Compound Block.webp
|   |   |       |-- Intense Dark Compound Button.webp
|   |   |       |-- Milk Compound Block.webp
|   |   |       |-- Semi Sweet Dark Compound Block.webp
|   |   |       |-- Semi Sweet Dark Compound Button.webp
|   |   |       |-- White Compound Block.webp
|   |   |       +-- White Compound Button.webp
|   |   +-- Couverture
|   |       |-- Belcolade
|   |       |   |-- Block - Dark - Stranding Order.webp
|   |       |   |-- Block - Milk - Stranding Order.webp
|   |       |   |-- BLock - White - Stranding Order.webp
|   |       |   |-- Drops - Dark.webp
|   |       |   |-- Drops - Milk.webp
|   |       |   +-- Drops - White.webp
|   |       +-- Van Houten
|   |           |-- Dark Couverture Button.webp
|   |           +-- Milk Couverture Button.webp
|   |-- Consumables
|   |   |-- Animal Feed
|   |   |   +-- Cargill
|   |   |       |-- Broiler Grower Protein.webp
|   |   |       |-- Broiler Starter Protein.webp
|   |   |       |-- Domestic Grower Protein.webp
|   |   |       |-- Domestic Starter Protein.webp
|   |   |       |-- Duck Layer Protein.webp
|   |   |       |-- Patin Starter Protein.webp
|   |   |       |-- Rabbit Breeder Protein.webp
|   |   |       |-- Standard Layer Protein.webp
|   |   |       +-- Tilapia Starter Protein.webp
|   |   |-- Cat Litter
|   |   |   +-- Kawan
|   |   |       |-- Cat Litter Apple.webp
|   |   |       |-- Cat Litter Baby Powder.webp
|   |   |       +-- Cat Litter Coffee.webp
|   |   |-- Charcoal
|   |   |   +-- 88
|   |   |       +-- Compressed BBQ Charcoal.webp
|   |   |-- Diapers
|   |   |   +-- Genki!
|   |   |       |-- Genki Tape Mega New Born.webp
|   |   |       |-- Genki Tape Mega S78.webp
|   |   |       +-- Genki! Pants Mega XL40.webp
|   |   |-- Dishwashing
|   |   |   +-- Bezt
|   |   |       |-- Dishwashing Liquid.webp
|   |   |       +-- Lime.webp
|   |   |-- Hand Cleanser
|   |   |   +-- Scott
|   |   |       |-- Antibacterial Skin Cleanser.webp
|   |   |       +-- Control Alcohol Foam Hand Sanitiser.webp
|   |   |-- Hand Gloves
|   |   |   +-- KleenGuard
|   |   |       |-- Blue.webp
|   |   |       +-- White.webp
|   |   +-- Tissues
|   |       |-- Plenty
|   |       |   |-- BT MMF PC.webp
|   |       |   |-- Facial Tissue EE.webp
|   |       |   +-- Facial Tissue Premium SP (Soft Pack).webp
|   |       |-- Scott
|   |       |   |-- Aquarius HBT Dispenser.webp
|   |       |   |-- Bathroom Tissue UW 160's x 2ply.webp
|   |       |   |-- Bathroom Tissue UW 200's x 2ply.webp
|   |       |   |-- Compact Towel Standard.webp
|   |       |   |-- Facial Tissue Flat Rectangle.webp
|   |       |   +-- Hygienic Bathroom Tissue.webp
|   |       +-- See-U
|   |           |-- BT DME Classic.webp
|   |           |-- BT DME Green Value.webp
|   |           +-- Pop Up Tissue 4 in 1.webp
|   |-- Cooking Ingredients
|   |   |-- Frying Flour
|   |   |   +-- Aroma
|   |   |       |-- All Purpose Seasoned Kentucky Crispy Flour (Original).webp
|   |   |       |-- All Purpose Seasoned Kentucky Crispy Flour Spicy.webp
|   |   |       |-- Banana Fritter Flour.webp
|   |   |       +-- Tempura Flour.webp
|   |   |-- Pasta
|   |   |   +-- Arbella
|   |   |       +-- Pasta.webp
|   |   |-- Paste
|   |   |   +-- Tean's Gourmet
|   |   |       |-- Assam Fish Paste.webp
|   |   |       |-- Chicken Curry Paste.webp
|   |   |       |-- Curry Laksa Paste.webp
|   |   |       |-- Steaming Fish Paste (Nyonya Style).webp
|   |   |       +-- Tom Yam Paste.webp
|   |   |-- Protein
|   |   |   |-- Ayam Kens
|   |   |   |   |-- Chicken Floss - Original.webp
|   |   |   |   +-- Chicken Floss - Spicy.webp
|   |   |   +-- Safcol
|   |   |       |-- Tuna Chunk In Soybean Oil.webp
|   |   |       +-- Tuna Flakes In Soybeam Oil - Standing Order.webp
|   |   |-- Salt
|   |   |   +-- Happy
|   |   |       |-- Fine Salt.webp
|   |   |       |-- Iodised Refined Salt.webp
|   |   |       +-- Iodised White Salt.webp
|   |   +-- Sauce
|   |       |-- Gardens
|   |       |   |-- Chilli Garlic Sauce.webp
|   |       |   |-- Chilli Sauce.webp
|   |       |   |-- Thai Chilli Sauce.webp
|   |       |   +-- Tomato Ketchup.webp
|   |       |-- O'Food
|   |       |   |-- GoChuJang Spicy & Sweet.webp
|   |       |   |-- GoChuJang Spicy Noodle.webp
|   |       |   +-- GoChuJang Tteobokki.webp
|   |       |-- Samyang
|   |       |   |-- Hot Chicken Buldak Sauce.webp
|   |       |   +-- Hot Chicken Extreme Buldak Sauce.webp
|   |       +-- Tean's Gourmet
|   |           |-- Chili Giling.webp
|   |           |-- Crispy Prawn Chilli.webp
|   |           |-- Nasi Lemak Sambal Spicy Shrimp Sauce.webp
|   |           |-- Spicy Belacan Paste.webp
|   |           +-- Tomato Sauce.webp
|   |-- Fats
|   |   |-- Cooking Oil
|   |   |   |-- Brooke
|   |   |   |   +-- Michelin Creamy Frying.webp
|   |   |   +-- Cap Udang
|   |   |       +-- Cooking Oil.webp
|   |   +-- Margarine
|   |       |-- Bakels
|   |       |   |-- Butta Blends.webp
|   |       |   +-- Starlight Pastry Fat.webp
|   |       |-- BlueBell
|   |       |   +-- Margarine.webp
|   |       +-- Vivo
|   |           +-- Classico Sheet.webp
|   |-- Flour
|   |   |-- Rice Flour
|   |   |   +-- Sunflower
|   |   |       |-- Corn Flour.webp
|   |   |       |-- Hong Kong Flour.webp
|   |   |       |-- Original Super Flour.webp
|   |   |       |-- Plain Flour.webp
|   |   |       |-- Plain Wheat Flour.webp
|   |   |       |-- Soon Kuay Flour.webp
|   |   |       |-- Super Flour.webp
|   |   |       |-- Tim Sum Flour.webp
|   |   |       +-- White Corn Flour.webp
|   |   |-- Starch
|   |   |   |-- Jade Leaf Brand
|   |   |   |   |-- Corn Starch.webp
|   |   |   |   +-- Tapioca Starch.webp
|   |   |   |-- Redman
|   |   |   |   +-- Corn Starch.webp
|   |   |   |-- Star Brand
|   |   |   |   +-- Sago Starch.webp
|   |   |   |-- Sunflower
|   |   |   |   |-- Potato Starch.webp
|   |   |   |   |-- Sweet Potato Starch.webp
|   |   |   |   +-- Tapioca Starch.webp
|   |   |   +-- Windmill
|   |   |       +-- Potato Starch.webp
|   |   +-- Wheat Flour
|   |       |-- Interflour
|   |       |   |-- Bakers Choice Bread Flour.webp
|   |       |   |-- Bakers Choice Pau Flour.webp
|   |       |   |-- Bakers Choice Superfine Wheat Flour.webp
|   |       |   |-- Blue Horse.webp
|   |       |   |-- Blue Premium.webp
|   |       |   |-- Cap Lili Plain Flour 850g x10pkts.webp
|   |       |   |-- Cap Lili Plain Flour.webp
|   |       |   |-- Golden Premium.webp
|   |       |   |-- Green Horse Enriched.webp
|   |       |   |-- Green Horse.webp
|   |       |   |-- Pink Horse.webp
|   |       |   |-- Pink_Superwhite.webp
|   |       |   |-- Red House.webp
|   |       |   |-- Roti Canai.webp
|   |       |   |-- SFFM 99.webp
|   |       |   |-- Wholemeal Fine_Coarse.webp
|   |       |   +-- Yellow House.webp
|   |       +-- Jade Leaf Brand
|   |           |-- Glutinous Rice Flour.webp
|   |           +-- Rice Flour.webp
|   |-- Frozen Food
|   |   |-- Dim Sum
|   |   |   |-- Easy Meal Everyday
|   |   |   |   |-- Beancurd Prawn Roll 240g x 16pkts.webp
|   |   |   |   +-- Prawn Siew Mai 198g x 24pkts.webp
|   |   |   +-- Kitasama
|   |   |       |-- Keropok Lekor Mega Soft Frozen 1kg x 10pkts.webp
|   |   |       +-- Keropok Lekor Mega Soft Frozen 500g x 20pkts.webp
|   |   |-- French Fries
|   |   |   |-- Lutosa
|   |   |   |   |-- Straight Cut- Rustic.webp
|   |   |   |   |-- Streak Fries Pom's Steak.webp
|   |   |   |   +-- Sweet Potato Fries.webp
|   |   |   +-- Starmax
|   |   |       |-- Shoestring Fries.webp
|   |   |       +-- Straight Cut Fries.webp
|   |   |-- Lasagna
|   |   |   +-- Tricious
|   |   |       |-- Beef Bolognese.webp
|   |   |       +-- Chicken Bolognese.webp
|   |   |-- Pizza
|   |   |   |-- michigan
|   |   |   |   |-- All Cheese.webp
|   |   |   |   |-- Beef Pepperoni.webp
|   |   |   |   +-- Hawaiian Chicken.webp
|   |   |   +-- Tricious
|   |   |       |-- All Cheese.webp
|   |   |       |-- Beef Pepperoni.webp
|   |   |       +-- Chicken Supreme.webp
|   |   |-- Seafood
|   |   |   |-- Bibigo
|   |   |   |   |-- Mandu Beef Bulgogi.webp
|   |   |   |   |-- Mandu Chicken.webp
|   |   |   |   +-- Mandu Korean Spicy.webp
|   |   |   +-- Sifu
|   |   |       |-- Fried Prawn Wonton.webp
|   |   |       |-- Squid Ball.webp
|   |   |       +-- White Fish Ball.webp
|   |   +-- Vegan
|   |       +-- VegeWorld
|   |           |-- Golden Oyster Mushroom.webp
|   |           |-- Vege Lamb Meat.webp
|   |           +-- Vege Roasted Chicken.webp
|   |-- Instant Food
|   |   |-- Canned Food
|   |   |   +-- tmfoods
|   |   |       |-- Cockles in Soya Sauce.webp
|   |   |       |-- Curry Chicken with Potato.webp
|   |   |       |-- Curry Cockles.webp
|   |   |       +-- Sardine in Tomato Sauce.webp
|   |   |-- Desserts
|   |   |   |-- Cozzo
|   |   |   |   |-- Pudding Grape.webp
|   |   |   |   +-- Pudding Lychee.webp
|   |   |   |-- Dadih
|   |   |   |   |-- Inst. Soya Fruits Pudding Powder Chocolate.webp
|   |   |   |   |-- Inst. Soya Fruits Pudding Powder Corn.webp
|   |   |   |   |-- Inst. Soya Fruits Pudding Powder Mango.webp
|   |   |   |   +-- Inst. Soya Fruits Pudding Powder Strawberry.webp
|   |   |   +-- Yogee
|   |   |       |-- Isotonic Konjac Jelly Lemon.webp
|   |   |       |-- Konjac Jelly Apple.webp
|   |   |       +-- Konjac Jelly Grape.webp
|   |   |-- Instant Noodles
|   |   |   |-- Brumee
|   |   |   |   |-- Kolo Mee Pok.webp
|   |   |   |   +-- Kolo Mee.webp
|   |   |   |-- Nongshim
|   |   |   |   |-- Shin Ramyun Noodle Soup.webp
|   |   |   |   |-- Shin Ramyun Red Super Spicy Noodle.webp
|   |   |   |   +-- Shin Ramyun Stir Fry Noodle.webp
|   |   |   +-- Samyang
|   |   |       |-- Hot Chicken Carbonara Ramen.webp
|   |   |       |-- Hot Chicken Cheese Ramen.webp
|   |   |       |-- Hot Chicken Extreme Ramen.webp
|   |   |       +-- Hot Chicken Flavoured Ramen.webp
|   |   +-- Snacks
|   |       |-- D-Jack
|   |       |   |-- Criski Ayam.webp
|   |       |   |-- Crispo Udang.webp
|   |       |   +-- Crista Ketam.webp
|   |       |-- Minni
|   |       |   |-- Yellow Pea Puff Cheese.webp
|   |       |   +-- Yellow Pea Puff Korean Spicy.webp
|   |       |-- No1
|   |       |   |-- All Natural Cocktail.webp
|   |       |   |-- Fun Stix Salted.webp
|   |       |   |-- Potato Chips Salted.webp
|   |       |   |-- Real Potato Stick Black Pepper.webp
|   |       |   |-- Real Potato Stick Lightly Salted.webp
|   |       |   |-- Salted Cashewnut.webp
|   |       |   |-- Salted Pistachios.webp
|   |       |   |-- Seaweed With Almond Slices Hot & Spicy.webp
|   |       |   +-- Seaweed With Almond Slices Original.webp
|   |       |-- Taekyung Food
|   |       |   |-- Roasted Seasoned Laver With Green Algae.webp
|   |       |   +-- Seasoned Laver Original.webp
|   |       +-- Win2
|   |           |-- Potato Crisp Sour Cream.webp
|   |           |-- Potato Crisp Sweet Corn.webp
|   |           |-- Potato Crisp Tomato.webp
|   |           +-- Potato Crisp Vege Flav.webp
|   |-- Leavening Agents
|   |   |-- Banking Powder
|   |   |   +-- Bakels
|   |   |       |-- Double Acting Baking Powder.webp
|   |   |       |-- Hercules Baking Powder.webp
|   |   |       +-- Instant Active Dried Yeast.webp
|   |   +-- Yeast
|   |       +-- Backaldrin
|   |           +-- Instant Dried Yeast (High Sugar).webp
|   +-- Sugar
|       |-- Icing
|       |   |-- Bakels
|       |   |   |-- Fino Dusting Sugar (Snow Powder).webp
|       |   |   +-- Pettinice RTR White Icing Ready to Roll.webp
|       |   +-- Sunflower
|       |       |-- Icing Sugar.webp
|       |       +-- Maltose.webp
|       +-- Others
|           +-- Sunflower
|               |-- Black Sugar.webp
|               |-- Brown Sugar.webp
|               |-- Caster Sugar.webp
|               +-- Red Sugar.webp
|-- scratch
|   +-- generate_tree.js
|-- .cpanel.yml
|-- .ftpquota
|-- .htaccess
|-- about-us.html
|-- banner.webp
|-- contact-us.html
|-- image.png
|-- index.html
|-- jimart-enterprise.html
|-- locations.html
|-- logo.png
|-- logo.webp
|-- majulskgroup.com_1777994774.php
|-- products.html
|-- PROJECT_STRUCTURE.md
|-- Red White logo.png
|-- red-white-logo.webp
|-- robots.txt
|-- script.js
|-- sitemap.xml
|-- style.css
+-- syarikat-andong.html
```

---
*Generated by Antigravity AI on 5/9/2026*
