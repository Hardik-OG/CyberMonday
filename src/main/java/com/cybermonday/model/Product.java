package com.cybermonday.model;

public class Product {

    private int id;
    private String name;
    private String description;
    private double price;
    private double discount;
    private int stock;
    private Integer categoryId;
    private String image;

    public Product() {
    }

    public Product(String name, String description, double price,
                   double discount, int stock, Integer categoryId,
                   String image) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.discount = discount;
        this.stock = stock;
        this.categoryId = categoryId;
        this.image = image;
    }

    public Product(int id, String name, String description, double price,
                   double discount, int stock, Integer categoryId,
                   String image) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.discount = discount;
        this.stock = stock;
        this.categoryId = categoryId;
        this.image = image;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}