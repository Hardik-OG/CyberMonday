
package com.cybermonday.dao;

import java.util.*;
import java.sql.*;
import com.cybermonday.model.Product;

public class ProductDAO {

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();

        String sql = "SELECT id, name, description, price, discount, stock FROM products";

        try (Connection con = DBConnection.getConnection()) {

            System.out.println("Database connected: " + (con != null));

            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Product p = new Product();

                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getDouble("price"));
                    p.setDiscount(rs.getDouble("discount"));
                    p.setStock(rs.getInt("stock"));

                    products.add(p);
                }
            }

            System.out.println("Products fetched: " + products.size());

        } catch (Exception e) {
            System.out.println("ERROR FETCHING PRODUCTS:");
            e.printStackTrace();
        }

        return products;
    }
}
