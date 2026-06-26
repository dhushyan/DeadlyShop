package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Product {
    private int id;
    private int categoryId;
    private String categoryName;
    private String name;
    private String description;
    private BigDecimal price;
    private int stock;
    private String imageUrl;
    private String brand;
    private double rating;
    private Timestamp createdAt;

    public Product() {}

    // Getters & Setters
    public int getId()                  { return id; }
    public void setId(int id)           { this.id = id; }

    public int getCategoryId()              { return categoryId; }
    public void setCategoryId(int categoryId){ this.categoryId = categoryId; }

    public String getCategoryName()                 { return categoryName; }
    public void setCategoryName(String categoryName){ this.categoryName = categoryName; }

    public String getName()             { return name; }
    public void setName(String name)    { this.name = name; }

    public String getDescription()                  { return description; }
    public void setDescription(String description)  { this.description = description; }

    public BigDecimal getPrice()                { return price; }
    public void setPrice(BigDecimal price)      { this.price = price; }

    public int getStock()               { return stock; }
    public void setStock(int stock)     { this.stock = stock; }

    public String getImageUrl()             { return imageUrl; }
    public void setImageUrl(String imageUrl){ this.imageUrl = imageUrl; }

    public String getBrand()            { return brand; }
    public void setBrand(String brand)  { this.brand = brand; }

    public double getRating()               { return rating; }
    public void setRating(double rating)    { this.rating = rating; }

    public Timestamp getCreatedAt()                { return createdAt; }
    public void setCreatedAt(Timestamp createdAt)  { this.createdAt = createdAt; }

    public boolean isInStock() { return stock > 0; }
}
