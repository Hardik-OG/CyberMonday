
<%@ page import="java.util.*" %>
<%@ page import="com.cybermonday.model.Product" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CyberMonday | Products</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 30px;
            font-family: Arial, sans-serif;
            background: #101827;
            color: white;
        }

        h1 {
            color: #fbbf24;
            text-align: center;
            font-size: 42px;
        }

        .subtitle {
            text-align: center;
            color: #cbd5e1;
            font-size: 18px;
        }

        .grid {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-top: 35px;
        }

        .card {
            background: #1e293b;
            padding: 22px;
            border-radius: 12px;
            border: 1px solid #334155;
            transition: transform 0.2s;
        }

        .card:hover {
            transform: translateY(-5px);
            border-color: #fbbf24;
        }

        .card h3 {
            color: #fbbf24;
            font-size: 20px;
        }

        .description {
            color: #cbd5e1;
            min-height: 40px;
        }

        .price {
            font-size: 24px;
            font-weight: bold;
        }

        .discount {
            color: #86efac;
            font-weight: bold;
        }

        .stock {
            color: #cbd5e1;
        }

        .empty {
            text-align: center;
            grid-column: 1 / -1;
            font-size: 20px;
            margin-top: 50px;
        }

        .error {
            color: #fca5a5;
            text-align: center;
        }
    </style>
</head>

<body>

    <h1>CyberMonday</h1>
    <p class="subtitle">Discover our exclusive deals!</p>

    <div class="grid">

        <%
            List<Product> products =
                (List<Product>) request.getAttribute("products");

            if (products != null && !products.isEmpty()) {
                for (Product p : products) {
        %>

            <div class="card">
                <h3><%= p.getName() %></h3>

                <p class="description">
                    <%= p.getDescription() %>
                </p>

                <p class="price">
                    ₹<%= p.getPrice() %>
                </p>

                <p class="discount">
                    Discount: <%= p.getDiscount() %>%
                </p>

                <p class="stock">
                    Available stock: <%= p.getStock() %>
                </p>
            </div>

        <%
                }
            } else {
        %>

            <p class="empty">No products found.</p>

        <%
            }
        %>

    </div>

</body>
</html>
