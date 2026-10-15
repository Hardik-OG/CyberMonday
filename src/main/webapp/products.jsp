<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.cybermonday.model.Product" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>

<%!
    private String escapeHtml(Object value) {
        if (value == null) return "";

        return value.toString()
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }

    private String getProductCategory(String name) {
        String n = name == null ? "" : name.toLowerCase();

        if (n.contains("headphone") || n.contains("watch")
                || n.contains("phone") || n.contains("laptop")
                || n.contains("computer") || n.contains("speaker")
                || n.contains("keyboard")) {
            return "Tech";
        }

        if (n.contains("shirt") || n.contains("shoe")
                || n.contains("dress") || n.contains("jeans")) {
            return "Fashion";
        }

        if (n.contains("lamp") || n.contains("chair")
                || n.contains("table") || n.contains("home")) {
            return "Home";
        }

        if (n.contains("wash") || n.contains("cream")
                || n.contains("beauty") || n.contains("skin")) {
            return "Beauty";
        }

        if (n.contains("book")) {
            return "Books";
        }

        return "Other";
    }

    private String getProductEmoji(String name) {
        String n = name == null ? "" : name.toLowerCase();

        if (n.contains("headphone")) return "🎧";
        if (n.contains("watch")) return "⌚";
        if (n.contains("shirt")) return "👕";
        if (n.contains("shoe")) return "👟";
        if (n.contains("lamp")) return "💡";
        if (n.contains("wash")) return "🧴";
        if (n.contains("book")) return "📚";
        if (n.contains("phone")) return "📱";
        if (n.contains("laptop")) return "💻";
        if (n.contains("chair")) return "🪑";
        if (n.contains("speaker")) return "🔊";

        return "🛍️";
    }
%>

<%
    List<Product> products =
            (List<Product>) request.getAttribute("products");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CyberMonday — Unmissable Deals</title>

    <style>
        :root {
            --ink: #17162b;
            --muted: #77768b;
            --purple: #6741d9;
            --purple-dark: #4e2ab7;
            --lavender: #f1edff;
            --border: #eae8f1;
            --background: #faf9fd;
            --orange: #ff9f43;
            --green: #12805c;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            color: var(--ink);
            background: var(--background);
            font-family: Inter, "Segoe UI", Arial, sans-serif;
        }

        button, input {
            font: inherit;
        }

        button {
            cursor: pointer;
        }

        .announcement {
            background: #19152f;
            color: #fff;
            text-align: center;
            padding: 11px 15px;
            font-size: 12px;
            letter-spacing: .3px;
        }

        .announcement strong {
            color: #ffca76;
        }

        .navbar {
            background: #fff;
            border-bottom: 1px solid var(--border);
        }

        .nav-inner {
            max-width: 1440px;
            margin: auto;
            min-height: 82px;
            padding: 0 36px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 25px;
        }

        .logo {
            font-size: 25px;
            font-weight: 850;
            letter-spacing: -1.2px;
            white-space: nowrap;
        }

        .logo span {
            color: var(--purple);
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 30px;
        }

        .nav-links a {
            color: #55546b;
            font-size: 13px;
            text-decoration: none;
            font-weight: 600;
        }

        .nav-links a:hover {
            color: var(--purple);
        }

        .nav-badge {
            border-radius: 999px;
            padding: 10px 15px;
            background: var(--lavender);
            color: var(--purple);
            font-size: 12px;
            font-weight: 750;
            white-space: nowrap;
        }

        main {
            max-width: 1440px;
            margin: auto;
            padding: 30px 36px 60px;
        }

        .hero {
            position: relative;
            overflow: hidden;
            min-height: 320px;
            border-radius: 26px;
            padding: 48px 55px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 25px;
            color: #fff;
            background:
                radial-gradient(circle at 82% 15%,
                    #9a7bff 0, transparent 28%),
                linear-gradient(120deg, #22134c, #5731b5 65%, #7655e8);
        }

        .hero::after {
            content: "";
            position: absolute;
            width: 360px;
            height: 360px;
            right: -95px;
            bottom: -210px;
            border: 1px solid #ffffff32;
            border-radius: 50%;
            box-shadow: 0 0 0 35px #ffffff0a,
                        0 0 0 75px #ffffff08;
        }

        .hero-content {
            max-width: 620px;
            position: relative;
            z-index: 1;
        }

        .eyebrow {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            border: 1px solid #ffffff36;
            background: #ffffff13;
            border-radius: 99px;
            padding: 9px 13px;
            color: #e8deff;
            font-size: 11px;
            font-weight: 750;
            letter-spacing: 1.2px;
        }

        .hero h1 {
            margin: 22px 0 14px;
            font-size: clamp(35px, 4.5vw, 57px);
            line-height: 1.05;
            letter-spacing: -2px;
        }

        .hero h1 span {
            color: #ffcf84;
        }

        .hero p {
            color: #e3dcf8;
            font-size: 15px;
            line-height: 1.8;
            max-width: 480px;
        }

        .hero-actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 25px;
        }

        .hero-btn {
            display: inline-block;
            border-radius: 10px;
            padding: 13px 19px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 750;
        }

        .hero-btn.primary {
            color: #261747;
            background: #fff;
        }

        .hero-btn.secondary {
            color: #fff;
            border: 1px solid #ffffff50;
        }

        .hero-art {
            position: relative;
            z-index: 1;
            width: 235px;
            height: 220px;
            flex-shrink: 0;
            display: grid;
            place-items: center;
            border: 1px solid #ffffff35;
            border-radius: 30px;
            background: linear-gradient(145deg,
                #ffffff28, #ffffff09);
            transform: rotate(3deg);
        }

        .hero-art .big-icon {
            font-size: 102px;
            filter: drop-shadow(0 20px 24px #160d4a50);
        }

        .hero-art .floating {
            position: absolute;
            right: -18px;
            top: 21px;
            transform: rotate(-3deg);
            padding: 13px 15px;
            border-radius: 12px;
            background: #ffce84;
            color: #35204a;
            box-shadow: 0 9px 28px #170d4040;
            font-size: 12px;
            font-weight: 850;
        }

        .benefits {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin: 25px 0 40px;
        }

        .benefit {
            display: flex;
            align-items: center;
            gap: 13px;
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 15px;
            padding: 18px;
        }

        .benefit-icon {
            width: 43px;
            height: 43px;
            display: grid;
            place-items: center;
            flex-shrink: 0;
            border-radius: 12px;
            background: var(--lavender);
            font-size: 20px;
        }

        .benefit strong {
            display: block;
            font-size: 13px;
            margin-bottom: 4px;
        }

        .benefit small {
            font-size: 11px;
            color: var(--muted);
        }

        .section-heading {
            display: flex;
            align-items: end;
            justify-content: space-between;
            gap: 20px;
            flex-wrap: wrap;
            margin-bottom: 22px;
        }

        .section-heading h2 {
            margin: 0;
            font-size: 28px;
            letter-spacing: -.8px;
        }

        .section-heading p {
            margin: 8px 0 0;
            color: var(--muted);
            font-size: 13px;
        }

        .count-pill {
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 99px;
            padding: 10px 14px;
            font-size: 12px;
            color: #55546b;
        }

        .toolbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            flex-wrap: wrap;
            margin-bottom: 25px;
        }

        .filters {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .filter-btn {
            border: 1px solid var(--border);
            background: #fff;
            color: #5e5d70;
            border-radius: 99px;
            padding: 10px 16px;
            font-size: 12px;
            font-weight: 700;
            transition: .2s;
        }

        .filter-btn:hover,
        .filter-btn.active {
            background: var(--purple);
            border-color: var(--purple);
            color: #fff;
        }

        .search-box {
            width: min(100%, 300px);
            position: relative;
        }

        .search-box span {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
        }

        .search-box input {
            width: 100%;
            border: 1px solid var(--border);
            background: #fff;
            border-radius: 11px;
            padding: 13px 15px 13px 42px;
            outline: none;
            font-size: 12px;
        }

        .search-box input:focus {
            border-color: var(--purple);
            box-shadow: 0 0 0 3px #6741d918;
        }



        .product-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 20px;
            align-items: stretch;
            width: 100%;
        }

        .product-card {
            min-width: 0;
            width: 100%;
            box-sizing: border-box;
            overflow: hidden;
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 18px;
            transition: transform .2s, box-shadow .2s;
        }


        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 18px 38px #21144a10;
        }

        .product-visual {
            position: relative;
            min-height: 190px;
            margin: 10px 10px 0;
            display: grid;
            place-items: center;
            overflow: hidden;
            border-radius: 12px;
            background:
                radial-gradient(circle at 50% 45%,
                    #ffffff 0, #ffffff90 29%, transparent 62%),
                linear-gradient(135deg, #f0ebff, #f9f6ff);
        }

        .product-emoji {
            font-size: 76px;
            filter: drop-shadow(0 14px 12px #20124d20);
            transition: transform .25s;
        }

        .product-card:hover .product-emoji {
            transform: scale(1.09) rotate(-3deg);
        }

        .sale-badge {
            position: absolute;
            top: 12px;
            left: 12px;
            padding: 7px 9px;
            border-radius: 7px;
            background: #ffede5;
            color: #c14c27;
            font-size: 10px;
            font-weight: 850;
        }

        .visual-label {
            position: absolute;
            right: 11px;
            bottom: 11px;
            color: #8c7ab7;
            font-size: 10px;
            font-weight: 750;
            letter-spacing: 1px;
        }

        .product-info {
            padding: 18px;
        }

        .product-category {
            color: var(--purple);
            font-size: 10px;
            font-weight: 850;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .product-title {
            min-height: 42px;
            margin: 9px 0 6px;
            font-size: 16px;
            line-height: 1.35;
            letter-spacing: -.3px;
        }

        .product-description {
            min-height: 33px;
            margin: 0 0 17px;
            color: var(--muted);
            font-size: 11px;
            line-height: 1.6;
        }

        .price-row {
            display: flex;
            flex-wrap: wrap;
            align-items: baseline;
            gap: 8px;
        }

        .current-price {
            font-size: 22px;
            font-weight: 850;
            letter-spacing: -.6px;
        }

        .old-price {
            color: #9996aa;
            font-size: 12px;
            text-decoration: line-through;
        }

        .saving {
            margin-top: 8px;
            color: var(--green);
            font-size: 11px;
            font-weight: 750;
        }

        .stock-row {
            display: flex;
            align-items: center;
            gap: 7px;
            color: var(--muted);
            font-size: 11px;
            margin-top: 13px;
        }

        .stock-dot {
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: #19a775;
        }

        .stock-dot.low {
            background: #f59e0b;
        }

        .product-actions {
            padding: 0 18px 18px;
        }

        .details-btn {
            width: 100%;
            padding: 12px;
            border: 1px solid #ded5ff;
            border-radius: 10px;
            background: #f5f2ff;
            color: var(--purple);
            font-size: 12px;
            font-weight: 800;
            transition: .2s;
        }

        .details-btn:hover {
            background: var(--purple);
            border-color: var(--purple);
            color: #fff;
        }

        .empty-state {
            display: none;
            background: #fff;
            border: 1px dashed #d7d0e9;
            padding: 45px 20px;
            border-radius: 16px;
            text-align: center;
            color: var(--muted);
            grid-column: 1 / -1;
        }

        .empty-state strong {
            display: block;
            color: var(--ink);
            font-size: 18px;
            margin-bottom: 8px;
        }

        .footer {
            margin-top: 55px;
            padding: 25px 0 0;
            border-top: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 12px;
            color: var(--muted);
            font-size: 11px;
        }

        .footer strong { color: var(--purple); }

        .modal-backdrop {
            display: none;
            position: fixed;
            inset: 0;
            z-index: 100;
            padding: 20px;
            align-items: center;
            justify-content: center;
            background: #1510279c;
            backdrop-filter: blur(5px);
        }

        .modal-backdrop.open { display: flex; }

        .modal {
            width: min(100%, 480px);
            background: #fff;
            border-radius: 23px;
            padding: 28px;
            box-shadow: 0 30px 100px #0004;
        }

        .modal-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
        }

        .modal-top h2 {
            margin: 0;
            font-size: 21px;
        }

        .close-modal {
            width: 36px;
            height: 36px;
            border: 1px solid var(--border);
            border-radius: 10px;
            background: #fff;
        }

        .modal-visual {
            display: grid;
            place-items: center;
            margin: 20px 0;
            min-height: 155px;
            border-radius: 16px;
            background: var(--lavender);
            font-size: 75px;
        }

        .modal-description {
            color: var(--muted);
            line-height: 1.7;
            font-size: 13px;
        }

        .modal-price {
            font-size: 27px;
            font-weight: 850;
            margin-top: 15px;
        }

        .modal-stock {
            font-size: 12px;
            color: var(--green);
            margin-top: 10px;
        }

        @media (max-width: 1100px) {
            .product-grid {
                grid-template-columns: repeat(3, minmax(0, 1fr));
            }

            .nav-inner, main {
                padding-left: 24px;
                padding-right: 24px;
            }
        }

        @media (max-width: 780px) {
            .nav-links { display: none; }

            .hero {
                padding: 35px 27px;
            }

            .hero-art {
                width: 155px;
                height: 160px;
            }

            .hero-art .big-icon { font-size: 70px; }

            .benefits {
                grid-template-columns: 1fr;
            }

            .product-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 13px;
            }

            .product-visual { min-height: 145px; }
            .product-emoji { font-size: 59px; }
            .product-info { padding: 14px; }
            .product-actions { padding: 0 14px 14px; }
            .current-price { font-size: 19px; }
        }

        @media (max-width: 490px) {
            .nav-inner {
                min-height: 68px;
                padding: 0 16px;
            }

            main { padding: 20px 14px 40px; }

            .hero {
                padding: 27px 22px;
                min-height: 290px;
            }

            .hero-art { display: none; }
            .hero h1 { font-size: 39px; }

            .section-heading h2 { font-size: 24px; }

            .product-grid {
                grid-template-columns: 1fr;
            }

            .product-visual { min-height: 190px; }
            .product-emoji { font-size: 75px; }
            .product-title, .product-description { min-height: 0; }

            .toolbar, .search-box {
                width: 100%;
            }

            .filters { width: 100%; }
            .filter-btn { padding: 9px 12px; }
        }
    </style>
</head>

<body>

<div class="announcement">
    ⚡ CYBER MONDAY IS HERE &nbsp; • &nbsp;
    <strong>Exceptional deals. Limited-time prices.</strong>
</div>

<header class="navbar">
    <div class="nav-inner">
        <div class="logo">Cyber<span>Monday.</span></div>

        <nav class="nav-links">
            <a href="<%= request.getContextPath() %>/">Home</a>
            <a href="#deals">Shop deals</a>
            <a href="#benefits">Why shop with us?</a>
        </nav>

        <div class="nav-badge">✦ SALE IS LIVE</div>
    </div>
</header>

<main>

    <section class="hero">
        <div class="hero-content">
            <div class="eyebrow">✦ THE BIGGEST SALE EVENT</div>

            <h1>
                Deals worth<br>
                <span>the excitement.</span>
            </h1>

            <p>
                Discover everyday essentials, smart technology and
                handpicked favourites at prices you'll love.
            </p>

            <div class="hero-actions">
                <a href="#deals" class="hero-btn primary">
                    Explore the deals &nbsp; →
                </a>

                <a href="#benefits" class="hero-btn secondary">
                    Why CyberMonday?
                </a>
            </div>
        </div>

        <div class="hero-art">
            <span class="big-icon">🛍️</span>
            <span class="floating">EXTRA VALUE ✦</span>
        </div>
    </section>

    <section class="benefits" id="benefits">
        <div class="benefit">
            <div class="benefit-icon">⚡</div>
            <div>
                <strong>Deals worth discovering</strong>
                <small>Explore our selected product range</small>
            </div>
        </div>

        <div class="benefit">
            <div class="benefit-icon">✦</div>
            <div>
                <strong>Clear, honest pricing</strong>
                <small>Prices and discounts shown together</small>
            </div>
        </div>

        <div class="benefit">
            <div class="benefit-icon">✓</div>
            <div>
                <strong>Shop with confidence</strong>
                <small>Check availability before choosing</small>
            </div>
        </div>
    </section>

    <section id="deals">
        <div class="section-heading">
            <div>
                <h2>Explore the collection.</h2>
                <p>Find your next favourite at a great price.</p>
            </div>

            <div class="count-pill">
                <span id="productCount"><%= products == null ? 0 : products.size() %></span> products
            </div>
        </div>

        <div class="toolbar">
            <div class="filters">
                <button class="filter-btn active" data-filter="All">All deals</button>
                <button class="filter-btn" data-filter="Tech">Technology</button>
                <button class="filter-btn" data-filter="Fashion">Fashion</button>
                <button class="filter-btn" data-filter="Home">Home</button>
                <button class="filter-btn" data-filter="Beauty">Beauty</button>
                <button class="filter-btn" data-filter="Books">Books</button>
            </div>

            <label class="search-box">
                <span>⌕</span>
                <input type="search" id="productSearch"
                       placeholder="Search products..."
                       aria-label="Search products">
            </label>
        </div>

        <div class="product-grid" id="productGrid">

            <% if (products != null && !products.isEmpty()) { %>

                <% for (Product product : products) {
                    String name = product.getName() == null
                            ? "Product" : product.getName();

                    String category = getProductCategory(name);
                    String emoji = getProductEmoji(name);

                    double originalPrice = product.getPrice();
                    double discountPercent = product.getDiscount();
                    double finalPrice = originalPrice * (1.0 - discountPercent / 100.0);
                    int stockCount = product.getStock();
                %>

                <article class="product-card"
                         data-name="<%= escapeHtml(name).toLowerCase(Locale.ROOT) %>"
                         data-category="<%= category %>"
                         data-description="<%= escapeHtml(product.getDescription()) %>"
                         data-price="<%= product.getPrice() %>"
                         data-discount="<%= product.getDiscount() %>"
                         data-stock="<%= product.getStock() %>"
                         data-title="<%= escapeHtml(name) %>"
                         data-emoji="<%= emoji %>">

                    <div class="product-visual">
                        <% if (product.getDiscount() > 0) { %>
                            <span class="sale-badge">
                                <%= String.format(Locale.US, "%.0f",
                                        product.getDiscount()) %>% OFF
                            </span>
                        <% } %>

                        <span class="product-emoji"><%= emoji %></span>
                        <span class="visual-label">CYBER PICK</span>
                    </div>

                    <div class="product-info">
                        <div class="product-category"><%= category %></div>

                        <h3 class="product-title">
                            <%= escapeHtml(name) %>
                        </h3>

                        <p class="product-description">
                            <%= escapeHtml(product.getDescription()) %>
                        </p>

                        <div class="price-row">
                            <span class="current-price"></span>
                            <span class="old-price"></span>
                        </div>

                        <div class="saving"></div>

                        <div class="stock-row">
                            <span class="stock-dot"></span>
                            <span class="stock-text"></span>
                        </div>
                    </div>

                    <div class="product-actions">
                        <button class="details-btn" type="button">
                            Explore this deal &nbsp; →
                        </button>
                    </div>
                </article>

                <% } %>

            <% } else { %>

                <div class="empty-state" style="display:block">
                    <strong>No products available yet</strong>
                    Please check the product database and try again.
                </div>

            <% } %>

            <div class="empty-state" id="noResults">
                <strong>No matching products</strong>
                Try another search or select a different category.
            </div>
        </div>
    </section>



</main>

<div class="modal-backdrop" id="productModal" role="dialog"
     aria-modal="true" aria-labelledby="modalTitle">

    <div class="modal">
        <div class="modal-top">
            <h2 id="modalTitle">Product details</h2>
            <button type="button" class="close-modal"
                    id="closeModal" aria-label="Close">✕</button>
        </div>

        <div class="modal-visual" id="modalEmoji">🛍️</div>
        <p class="modal-description" id="modalDescription"></p>
        <div class="modal-price" id="modalPrice"></div>
        <div class="old-price" id="modalOldPrice"></div>
        <div class="saving" id="modalSaving"></div>
        <div class="modal-stock" id="modalStock"></div>
    </div>
</div>

<script>
"use strict";

document.addEventListener("DOMContentLoaded", function () {
    const cards = Array.from(
        document.querySelectorAll(".product-card")
    );

    const searchInput = document.getElementById("productSearch");
    const filterButtons = document.querySelectorAll(".filter-btn");
    const countLabel = document.getElementById("productCount");
    const noResults = document.getElementById("noResults");

    const modal = document.getElementById("productModal");
    const closeModalButton = document.getElementById("closeModal");

    let activeCategory = "all";

    function formatCurrency(amount) {
        return new Intl.NumberFormat("en-IN", {
            style: "currency",
            currency: "INR",
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        }).format(amount);
    }

    // Fill in prices, discounts, savings and stock from each product card.
    cards.forEach(function (card) {
        const originalPrice = Number(card.dataset.price) || 0;
        const discount = Math.max(
            0,
            Math.min(100, Number(card.dataset.discount) || 0)
        );
        const stock = Number(card.dataset.stock) || 0;

        const finalPrice = originalPrice * (1 - discount / 100);
        const savedAmount = originalPrice - finalPrice;

        const currentPrice = card.querySelector(".current-price");
        const oldPrice = card.querySelector(".old-price");
        const saving = card.querySelector(".saving");
        const stockText = card.querySelector(".stock-text");
        const stockDot = card.querySelector(".stock-dot");

        if (currentPrice) {
            currentPrice.textContent = formatCurrency(finalPrice);
        }

        if (oldPrice) {
            oldPrice.textContent = discount > 0
                ? formatCurrency(originalPrice)
                : "";
        }

        if (saving) {
            saving.textContent = discount > 0
                ? "You save " + formatCurrency(savedAmount)
                : "Great everyday value";
        }

        if (stockText) {
            if (stock <= 0) {
                stockText.textContent = "Currently unavailable";
            } else if (stock <= 5) {
                stockText.textContent = "Only " + stock + " left";
            } else {
                stockText.textContent =
                    "In stock · " + stock + " available";
            }
        }

        if (stockDot) {
            stockDot.classList.toggle("low", stock > 0 && stock <= 5);
            stockDot.style.backgroundColor =
                stock <= 0 ? "#c34b5b" : "";
        }
    });

    // Search and category filtering.
    function applyFilters() {
        const query = searchInput
            ? searchInput.value.trim().toLowerCase()
            : "";

        let visibleCount = 0;

        cards.forEach(function (card) {
            const searchableText = [
                card.dataset.name || "",
                card.dataset.title || "",
                card.dataset.category || "",
                card.dataset.description || ""
            ].join(" ").toLowerCase();

            const matchesSearch = searchableText.includes(query);

            const category = (
                card.dataset.category || ""
            ).toLowerCase();

            const matchesCategory =
                activeCategory === "all" ||
                category === activeCategory;

            const visible = matchesSearch && matchesCategory;

            card.style.display = visible ? "" : "none";

            if (visible) {
                visibleCount++;
            }
        });

        if (countLabel) {
            countLabel.textContent = visibleCount;
        }

        if (noResults) {
            noResults.style.display =
                visibleCount === 0 ? "block" : "none";
        }
    }

    if (searchInput) {
        searchInput.addEventListener("input", applyFilters);
    }

    filterButtons.forEach(function (button) {
        button.addEventListener("click", function () {
            filterButtons.forEach(function (item) {
                item.classList.remove("active");
            });

            button.classList.add("active");

            activeCategory = (
                button.dataset.filter || "all"
            ).toLowerCase();

            applyFilters();
        });
    });

    // Product details popup.
    function openProductDetails(card) {
        const title = card.dataset.title || "Product";
        const description = card.dataset.description || "";
        const emoji = card.dataset.emoji || "🛍️";
        const originalPrice = Number(card.dataset.price) || 0;
        const discount = Math.max(
            0,
            Math.min(100, Number(card.dataset.discount) || 0)
        );
        const stock = Number(card.dataset.stock) || 0;
        const finalPrice = originalPrice * (1 - discount / 100);

        document.getElementById("modalTitle").textContent = title;
        document.getElementById("modalDescription").textContent =
            description;
        document.getElementById("modalEmoji").textContent = emoji;
        document.getElementById("modalPrice").textContent =
            formatCurrency(finalPrice);

        document.getElementById("modalOldPrice").textContent =
            discount > 0 ? formatCurrency(originalPrice) : "";

        document.getElementById("modalSaving").textContent =
            discount > 0
                ? "You save " +
                    formatCurrency(originalPrice - finalPrice) +
                    " (" + discount + "% off)"
                : "Great everyday value";

        document.getElementById("modalStock").textContent =
            stock > 0
                ? stock + " units in stock"
                : "Currently unavailable";

        modal.classList.add("open");
    }

    cards.forEach(function (card) {
        const detailsButton = card.querySelector(".details-btn");

        if (detailsButton) {
            detailsButton.addEventListener("click", function () {
                openProductDetails(card);
            });
        }
    });

    function closeProductDetails() {
        if (modal) {
            modal.classList.remove("open");
        }
    }

    if (closeModalButton) {
        closeModalButton.addEventListener(
            "click",
            closeProductDetails
        );
    }

    if (modal) {
        modal.addEventListener("click", function (event) {
            if (event.target === modal) {
                closeProductDetails();
            }
        });
    }

    document.addEventListener("keydown", function (event) {
        if (event.key === "Escape") {
            closeProductDetails();
        }
    });

    // Show all products when the page first opens.
    applyFilters();
});
</script>
