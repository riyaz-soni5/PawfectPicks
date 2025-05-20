package com.Pawfect.Model;

public class Product {
    private int id;
    private String name;
    private int price;
    private int rating;
    private String description;
    private String category;
    private String stockStatus;
    private String categoryName;
    
    private String base64Image;
    
    private int totalSales;




    
    private int categoryId;
    
    
    public int getTotalSales() {
        return totalSales;
    }

    public void setTotalSales(int totalSales) {
        this.totalSales = totalSales;
    }



    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public String getBase64Image() {
        return base64Image;
    }

    public void setBase64Image(String base64Image) {
        this.base64Image = base64Image;
    }
    
    public String getCategory() {
        return category;
    }
    
    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    
    public int getCategoryId() {
        return categoryId;
    }
    
    public String getStockStatus() {
        return stockStatus;
    }


    public String getDescription() {
        return description;
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

    public int getPrice() {
        return price;
    }
    public void setPrice(int price) {
        this.price = price;
    }

    public int getRating() {
        return rating;
    }
    public void setRating(int rating) {
        this.rating = rating;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public void setCategory(String category) {
        this.category = category;
    }
    public void setStockStatus(String stockStatus) {
        this.stockStatus = stockStatus;
    }
    
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    
}


