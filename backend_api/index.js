//importing the express module
const express=require('express');
//importing mongoose
require('dotenv').config();
const mongoose=require('mongoose');
const authRouter=require("./routes/auth");
const bannerRouter=require("./routes/banner");
const categoryRouter=require("./routes/category");
const subCategoryRouter=require("./routes/sub_category");
const productRouter=require("./routes/product");
const productReviewRouter=require("./routes/product_review");
const vendorRouter=require("./routes/vendor");
const orderRouter=require("./routes/order");
//defined the port number the server will listen on
const PORT =3000;
//creating the instance of a express application
//because it gives us the starting point

const app=express();
// middleware- to register routes or to mount routes
//database url
const cors = require("cors");
app.use(cors());
const db=process.env.db;
mongoose.connect(db) .then(()=>{
    console.log("connected sucessfully");
});
app.use(express.json());
app.use(authRouter);
app.use(bannerRouter);
app.use(categoryRouter);
app.use(subCategoryRouter);
app.use(productRouter);
app.use(productReviewRouter);
app.use(vendorRouter);
// app.use(express.json());
app.use(orderRouter);



//start the server and listen on the specified port
app.listen(PORT,"0.0.0.0",function(){
    // log the number
    console.log(`server is running on port ${PORT}`)
});
