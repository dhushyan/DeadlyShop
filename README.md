# 🏍️ DeadlyShop — Motorcycle Accessories E-Commerce

> **Final Year Academic Project** — Full-Stack Java Web App  
> Stack: Java Servlets + JSP · MySQL · JDBC · Apache Tomcat 10+ · Maven

---

## 📁 Project Structure

```
DeadlyShop/
├── pom.xml                          ← Maven build
├── schema.sql                       ← DB schema + sample data
├── db.properties                    ← (reference copy)
│
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   ├── model/               ← POJOs (User, Product, Order, CartItem, …)
│   │   │   ├── dao/                 ← Database layer (UserDAO, ProductDAO, …)
│   │   │   ├── servlet/             ← HTTP controllers
│   │   │   ├── filter/              ← AuthFilter, AdminFilter
│   │   │   └── util/               ← DBUtil, PasswordUtil
│   │   │
│   │   ├── resources/
│   │   │   └── db.properties        ← DB credentials (on classpath)
│   │   │
│   │   └── webapp/
│   │       ├── css/style.css        ← Main stylesheet
│   │       ├── css/admin.css        ← Admin panel styles
│   │       ├── js/app.js            ← Frontend JS + AJAX
│   │       └── WEB-INF/
│   │           ├── web.xml          ← Deployment descriptor
│   │           └── views/           ← JSP pages
│   │               ├── index.jsp
│   │               ├── login.jsp
│   │               ├── register.jsp
│   │               ├── products.jsp
│   │               ├── product_detail.jsp
│   │               ├── cart.jsp
│   │               ├── checkout.jsp
│   │               ├── orders.jsp
│   │               ├── header.jsp
│   │               ├── footer.jsp
│   │               └── admin/
│   │                   ├── dashboard.jsp
│   │                   ├── products.jsp
│   │                   ├── product_form.jsp
│   │                   ├── orders.jsp
│   │                   └── users.jsp
```

---

## ⚙️ Setup Instructions

### 1. Prerequisites

| Tool | Version |
|------|---------|
| Java JDK | 17+ |
| Apache Maven | 3.9+ |
| Apache Tomcat | 10.1+ |
| MySQL | 8.0+ |
| IDE | Eclipse EE / IntelliJ IDEA Ultimate |

---

### 2. Database Setup

```bash
# Open MySQL and run:
mysql -u root -p < schema.sql
```

This creates the `deadlyshop` database with all tables and sample data.

---

### 3. Configure DB Credentials

Edit **`src/main/resources/db.properties`**:

```properties
db.url=jdbc:mysql://localhost:3306/deadlyshop?useSSL=false&serverTimezone=Asia/Kolkata&allowPublicKeyRetrieval=true
db.username=root
db.password=YOUR_MYSQL_PASSWORD
db.driver=com.mysql.cj.jdbc.Driver
```

---

### 4. Build with Maven

```bash
mvn clean package
```

This generates `target/DeadlyShop.war`.

---

### 5. Deploy on Tomcat

```bash
# Option A: Copy WAR to Tomcat webapps
cp target/DeadlyShop.war /path/to/tomcat/webapps/

# Option B: Use Tomcat Manager UI at http://localhost:8080/manager
```

---

### 6. Access the App

| URL | Description |
|-----|-------------|
| `http://localhost:8080/DeadlyShop/home` | Homepage |
| `http://localhost:8080/DeadlyShop/products` | Product listing |
| `http://localhost:8080/DeadlyShop/login` | Login |
| `http://localhost:8080/DeadlyShop/register` | Register |
| `http://localhost:8080/DeadlyShop/cart` | Shopping Cart |
| `http://localhost:8080/DeadlyShop/checkout` | Checkout |
| `http://localhost:8080/DeadlyShop/orders` | Order History |
| `http://localhost:8080/DeadlyShop/admin/dashboard` | Admin Panel |

---

## 🔐 Default Admin Login

| Email | Password |
|-------|----------|
| `admin@deadlyshop.com` | `Admin@123` |

> All demo user passwords: **Admin@123** (BCrypt hashed in DB)

---

## ✅ Features

### Authentication
- BCrypt password hashing (jBCrypt)
- Secure session management (HttpSession)
- Role-based access (user / admin)
- AuthFilter & AdminFilter for route protection
- Login, Register, Logout

### Product System
- Dynamic product listing (single JSP, data from DB)
- Category filtering via query params
- Full-text search (name, brand, description)
- Product detail page with related products
- In-stock / low-stock / out-of-stock indicators

### Cart System
- AJAX add-to-cart (no page reload)
- AJAX remove item
- AJAX quantity update
- Live cart badge counter
- Session + DB synced cart

### Order System
- Full checkout form (shipping + payment)
- Order placed in DB transaction (orders + order_items)
- Cart auto-cleared on order placement
- Order history page with status indicators

### Admin Panel
- Dashboard: product count, order count, user count, total revenue
- Products: Add / Edit / Delete (full CRUD)
- Orders: View all + update status (pending → shipped → delivered)
- Users: View all customers + delete

---

## 🗄️ Database Tables

| Table | Purpose |
|-------|---------|
| `users` | Registered users (role: user / admin) |
| `categories` | Product categories (Helmets, Gloves, etc.) |
| `products` | Product catalog |
| `cart` | Persistent cart per user |
| `orders` | Placed orders |
| `order_items` | Line items per order |

---

## 🧩 Architecture

```
Browser  →  Servlet (Controller)  →  DAO (Data Layer)  →  MySQL
                   ↓
               JSP (View)
```

- **No SQL in JSP** — all DB logic in DAO classes
- **DAO Pattern** — UserDAO, ProductDAO, CartDAO, OrderDAO, CategoryDAO
- **DBUtil** — centralized JDBC connection via `db.properties`
- **Filters** — AuthFilter (user routes), AdminFilter (/admin/*)

---

## 📚 Tech Stack

- Java 17, Jakarta EE 10 (Servlets 6.0, JSP 3.1, JSTL 3.0)
- Apache Tomcat 10.1
- MySQL 8.0 + JDBC
- jBCrypt 0.4
- Maven 3.9
- HTML5, CSS3, Vanilla JavaScript (AJAX fetch API)

---

## 🚀 GitHub / Deployment

```bash
# Initialize git
git init
git add .
git commit -m "Initial commit - DeadlyShop"
git remote add origin https://github.com/YOUR_USERNAME/DeadlyShop.git
git push -u origin main
```

---

*Built as a final year placement project. Demonstrates full-stack Java EE development, DAO pattern, BCrypt security, AJAX interactions, and responsive dark-theme UI.*
