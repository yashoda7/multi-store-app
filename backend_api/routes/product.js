const express=require("express");
const Product=require("../models/product");
const { populate } = require("dotenv");
const productRouter=express.Router();
productRouter.post("/api/add-product",async(req,res) =>{
    try{
        const{productName,productPrice,quantity,description,category,vendorId,fullName,subCategory,images}=req.body;
        const product=new Product({productName,productPrice,quantity,description,category,vendorId,fullName,subCategory,images});
        await product.save();
        res.status(200).json({product});
    }
    catch(e){
        res.status(400).json({error:e.message});
    }
});
productRouter.get("/api/popular-products",async(req,res) =>{
    try{
        const products=await Product.find({popular:true});
        if(!products || products.length==0){
            return res.status(400).json({msg:"products not found"});
        }
        else{
            res.status(200).json({products});
        }
    }
    catch(e){
        res.status(400).json({error:e.message});
    }

});
productRouter.get("/api/recommended-products",async(req,res) =>{
    try{
        const products=await Product.find({recommend:true});
        if(!products || products.length==0){
            return res.status(400).json({msg:" recommended products not found"});
        }
        else{
            res.status(200).send(products);
        }
    }
    catch(e){
        res.status(400).json({error:e.message});
    }
});
// new route for retrievwing products by category
productRouter.get("/api/products-by-category/:category",async(req,res) => {
        try {
            const {category}=req.params;
            const products=await Product.find({category,popular:true});
            if(!products || products.length==0){
                return res.status(404).json({msg:"Products not found"});
            }
            else{
                return res.status(200).json(products);
            }
        } catch (error) {
            res.status(500).json({error:e.message});
            
        }
    }
)
module.exports=productRouter;