package model;

import java.math.BigDecimal;

public class CartItem {
    private int id;
    private int userId;
    private int productId;
    private String productName;
    private BigDecimal unitPrice;
    private String imageUrl;
    private int quantity;

    public CartItem() {}

    // Getters & Setters
    public int getId()              { return id; }
    public void setId(int id)       { this.id = id; }

    public int getUserId()              { return userId; }
    public void setUserId(int userId)   { this.userId = userId; }

    public int getProductId()               { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProductName()                  { return productName; }
    public void setProductName(String productName)  { this.productName = productName; }

    public BigDecimal getUnitPrice()                { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice)  { this.unitPrice = unitPrice; }

    public String getImageUrl()             { return imageUrl; }
    public void setImageUrl(String imageUrl){ this.imageUrl = imageUrl; }

    public int getQuantity()                { return quantity; }
    public void setQuantity(int quantity)   { this.quantity = quantity; }

    public BigDecimal getSubtotal() {
        return unitPrice.multiply(BigDecimal.valueOf(quantity));
    }
}
