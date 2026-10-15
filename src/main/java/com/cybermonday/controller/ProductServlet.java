
package com.cybermonday.controller;

import java.io.IOException;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cybermonday.dao.ProductDAO;
import com.cybermonday.model.Product;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("ProductServlet called!");

        ProductDAO dao = new ProductDAO();
        List<Product> products = dao.getAllProducts();

        System.out.println("Products sent to JSP: " + products.size());

        request.setAttribute("products", products);

        request.getRequestDispatcher("/products.jsp")
                .forward(request, response);
    }
}
