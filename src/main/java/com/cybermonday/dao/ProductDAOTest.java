
package com.cybermonday.dao;

import java.util.*;

import com.cybermonday.model.Product;

public class ProductDAOTest {
    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
        List<Product> products = dao.getAllProducts();

        System.out.println("Total products: " + products.size());

        for (Product p : products) {
            System.out.println(
                    p.getId() + " | " +
                            p.getName() + " | ₹" +
                            p.getPrice()
            );
        }
    }
}
