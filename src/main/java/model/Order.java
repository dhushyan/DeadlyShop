package model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class Order {
    private int id;
    private int userId;
    private String userName;
    private BigDecimal totalAmount;
    private String status;
    private String shippingName;
    private String shippingPhone;
    private String shippingAddress;
    private String shippingCity;
    private String shippingState;
    private String shippingPincode;
    private String paymentMethod;
    private Timestamp placedAt;
    private List<OrderItem> items;

    public Order() {}

    // Getters & Setters
    public int getId()              { return id; }
    public void setId(int id)       { this.id = id; }

    public int getUserId()              { return userId; }
    public void setUserId(int userId)   { this.userId = userId; }

    public String getUserName()                 { return userName; }
    public void setUserName(String userName)    { this.userName = userName; }

    public BigDecimal getTotalAmount()                  { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount)  { this.totalAmount = totalAmount; }

    public String getStatus()               { return status; }
    public void setStatus(String status)    { this.status = status; }

    public String getShippingName()                 { return shippingName; }
    public void setShippingName(String shippingName){ this.shippingName = shippingName; }

    public String getShippingPhone()                    { return shippingPhone; }
    public void setShippingPhone(String shippingPhone)  { this.shippingPhone = shippingPhone; }

    public String getShippingAddress()                      { return shippingAddress; }
    public void setShippingAddress(String shippingAddress)  { this.shippingAddress = shippingAddress; }

    public String getShippingCity()                 { return shippingCity; }
    public void setShippingCity(String shippingCity){ this.shippingCity = shippingCity; }

    public String getShippingState()                    { return shippingState; }
    public void setShippingState(String shippingState)  { this.shippingState = shippingState; }

    public String getShippingPincode()                      { return shippingPincode; }
    public void setShippingPincode(String shippingPincode)  { this.shippingPincode = shippingPincode; }

    public String getPaymentMethod()                    { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod)  { this.paymentMethod = paymentMethod; }

    public Timestamp getPlacedAt()                  { return placedAt; }
    public void setPlacedAt(Timestamp placedAt)     { this.placedAt = placedAt; }

    public List<OrderItem> getItems()               { return items; }
    public void setItems(List<OrderItem> items)     { this.items = items; }
}
