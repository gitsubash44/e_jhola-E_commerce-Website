<%@page import="com.e_jhola.controller.ProductController"%>
<%@page import="com.e_jhola.model.Product"%>
<%@page import="com.e_jhola.dbcontroller.Connection"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
ProductController productController = new ProductController(Connection.getConnection());
List<Product> productList = productController.getAllLatestProducts();
List<Product> topDeals = productController.getDiscountedProducts();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="CSS/style.css"/>
<title>About us</title>
<%@include file="Elements/css._js.jsp"%>
<style>

 
/* Global Styles */
 
body {
    font-family: Arial, sans-serif;
}
 

 
/* About Section */
 
.about {
    background: rgb(224, 251, 222);
    background: linear-gradient(360deg, rgb(245, 255, 245) 0%, rgb(173, 252, 163) 100%);
    padding: 100px 0 20px 0;
    text-align: center;
}
 
.about h1 {
    font-size: 2.5rem;
    margin-bottom: 8px;
    color: black;
}
 
.about p {
    font-size: 1rem;
    color: #323030;
    max-width: 800px;
    margin: 0 auto;
}
 
.about-info {
    margin: 2rem 2rem;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: left;
}
 
.about-img {
    width: 20rem;
    height: 20rem;
 
}
 
.about-img img {
    width: 100%;
    height: 100%;
    border-radius: 5px;
    object-fit: contain;
}
 
.about-info p {
    font-size: 1.3rem;
    margin: 0 2rem;
    text-align: justify;
}
 
.button {
    border: none;
    outline: 0;
    padding: 10px;
    margin: 2rem;
    font-size: 1rem;
    color: white;
    background-color: #40b736;
    text-align: center;
    cursor: pointer;
    width: 15rem;
    border-radius: 4px;
}
 
.button:hover {
    background-color: #1f9405;
    color: white;
    text-decoration: none;
}
 
/* Team Section */
 
.team {
    padding: 30px 0;
    text-align: center;
}
 
.team h1 {
    font-size: 2.5rem;
    margin-bottom: 20px;
    color: black;
}
 
.team-cards {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 15px;
    margin-top: 20px;
}
 
.Box {
    background-color: white;
    border-radius: 6px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.5);
    overflow: hidden;
    transition: transform 0.2s, box-shadow 0.2s;
    width: 18rem;
    height: 28rem;
    margin-top: 10px;
}
 
.Box:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 12px rgba(0, 0, 0, 0.5);
}
 
.card-img {
    width: 18rem;
    height: 12rem;
}
 
.card-img img {
    width: 100%;
    height: 100%;
    object-fit: fill;
}
 
.card-info button {
    margin: 2rem 1rem;
}
 
.card-name {
    font-size: 2rem;
    margin: 10px 0;
}
 
.card-role {
    font-size: 1rem;
    color: #888;
    margin: 5px 0;
}
 
.card-email {
    font-size: 1rem;
    color: #555;
}
 
 
@media (max-width: 768px) {
  
 
    .logo {
        text-align: center;
    }
 
   
 
    .about h1 {
        font-size: 2rem;
    }
 
    .about p {
        font-size: 0.9rem;
    }
 
    .about-info {
        flex-direction: column;
        text-align: center;
    }
 
    .about-img {
        width: 60%;
        height: 60%;
        margin-bottom: 1rem;
    }
 
    .about-info p {
        margin: 1rem 2rem;
    }
 
    .about-info button {
        margin: 1rem 2rem;
        width: 10rem;
    }
 
    .team {
        margin: 0 1rem;
    }
}
.About-us {
	width: 100%;
	text-align: center;
	background-color: #ccc;
	margin-top: 3px;
	margin-bottom: 3px;
}



img {
	border-radius: 50%;
}

p {
	font-size: 20px;
	color: black;
}

h3 {
	text-shadow:
}

.social a {
	padding: 20px;
	  text-align: center;
	  text-decoration: none;
	  margin: 5px 2px;
	  background: #3B5998;
      color: white;
	  border-radius: 8px;
	 font-size: 50px;
}
</style>
</head>
<body>
	<div>
		<%@include file="Elements/navbar.jsp"%>
	</div>


	<section class="about">
        <h1>About Us</h1>
        <p style="font-weight: bold">
          E-jhola "Unbox the future electronics".
          </p>
        <div class="about-info">
            <div class="about-img">
                <img src="images/ejola.png" alt="Geeksforgeeks">
            </div>
            <div>
          <p>
					Welcome to E-Jhola, your one-stop destination for all your
					electronic needs! At E-Jhola, we're passionate about providing
					top-quality electronics at unbeatable prices, delivered right to
					your doorstep. Whether you're looking for the latest smartphones,
					cutting-edge laptops, or innovative home appliances, we've got you
					covered. Our journey began with a simple idea: to make purchasing
					electronics convenient, affordable, and enjoyable for everyone. We
					understand that navigating the world of electronics can sometimes
					be overwhelming, which is why we've curated a carefully selected
					range of products from trusted brands, ensuring that you get only
					the best. But we're more than just an online store. We're a team of
					tech enthusiasts dedicated to helping you find the perfect gadgets
					to fit your lifestyle. Whether you're a tech-savvy professional or
					a casual user, our knowledgeable customer service team is here to
					assist you every step of the way. What sets us apart is our
					commitment to customer satisfaction. From our hassle-free shopping
					experience to our fast and reliable delivery service, we strive to
					exceed your expectations at every turn. Your trust is our top
					priority, and we'll go above and beyond to ensure that you're
					satisfied with your purchase.<br> 
					So why choose E-Jhola?
					Because we're more than just a retailer.  we're your trusted
					partner in the world of electronics. Join us on our journey as we
					continue to redefine the way you shop for technology. Thank you for
					choosing E-Jhola. We look forward to serving you!
				</p>
               
            </div>
        </div>
    </section>
 
    <section class="team">
        <h1>Meet Our Team</h1>
        <div class="team-cards">
           
            <!-- Cards here -->
            <!-- Card 1 -->
           
            <div class="Box">
                <div class="card-img">
                    <img src="images/profile_pic.jpg" alt="User 1">
                </div>
                <div class="card-info">
                    <h2 class="card-name">Subash Dhami</h2>
                    <p class="card-role">CEO and Founder</p>
                    <p class="card-email">dhamisubash866@gmail.com</p>
                    <a class="button" href="Tel:+977-9862451644" class="fas fa-phone-alt"> <i class="fas fa-phone" style="padding: 6px;" ></i>Contect</a>
                </div>
            </div>
 
            <!-- Card 2 -->
           
            <div class="Box">
                <div class="card-img">
                    <img src="images/profile_pic.jpg" alt="User 1">
                </div>
                <div class="card-info">
                    <h2 class="card-name">Subash Dhami</h2>
                    <p class="card-role">Co-Founder</p>
                    <p class="card-email">dhamisubash866@gmail.com</p>
                    <a class="button" href="Tel:+977-9862451644" class="fas fa-phone-alt"> <i class="fas fa-phone" style="padding: 6px;" ></i>Contect</a>
                </div>
            </div>
           
            <!-- Card 3 -->
           
            <div class="Box">
                <div class="card-img">
                    <img src="images/profile_pic.jpg" alt="User 1">
                </div>
                <div class="card-info">
                    <h2 class="card-name">Subash Dhami</h2>
                    <p class="card-role">Co-Founder</p>
                    <p class="card-email">dhamisubash866@gmail.com</p>
                    <a class="button" href="Tel:+977-9862451644" class="fas fa-phone-alt"> <i class="fas fa-phone" style="padding: 6px;" ></i>Contect</a>
                </div>
            </div>
            <!-- Card 3 -->
           
            <div class="Box">
                <div class="card-img">
                    <img src="images/profile_pic.jpg" alt="User 1">
                </div>
                <div class="card-info">
                    <h2 class="card-name">Subash Dhami</h2>
                    <p class="card-role">Co-Founder</p>
                    <p class="card-email">dhamisubash866@gmail.com</p>
                    <a class="button" href="Tel:+977-9862451644" class="fas fa-phone-alt"> <i class="fas fa-phone" style="padding: 6px;" ></i>Contect</a>
                </div>
            </div>
            <!-- Card 3 -->
           
            <div class="Box">
                <div class="card-img">
                    <img src="images/profile_pic.jpg" alt="User 1">
                </div>
                <div class="card-info">
                    <h2 class="card-name">Subash Dhami</h2>
                    <p class="card-role">Co-Founder</p>
                    <p class="card-email">dhamisubash866@gmail.com</p>
                    <a class="button" href="Tel:+977-9862451644" class="fas fa-phone-alt"> <i class="fas fa-phone" style="padding: 6px;" ></i>Contect</a>
                </div>
            </div>
           
           
        </div>
    </section>
		
	
	<%@include file="Elements/Footer.jsp"%>
</body>
</html>