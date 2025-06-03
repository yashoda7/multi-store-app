const express=require("express");
// const  category=require("../models/category");
const Category = require("../models/category");
const categoryRouter=express.Router();
categoryRouter.post("/api/categories",async(req,res) =>{
    try{
        const {name,image,banner}=req.body;
        const newCategory=new Category({name,image,banner});
        await newCategory.save();
        res.status(200).send(newCategory);
    }
    catch(e){
        res.status(400).json({error:e.message});
    }
});
categoryRouter.get("/api/categories",async (req,res) =>{
    try{
        // const categoryall=await category.find();
        const categoryall = await Category.find();  
        res.status(200).json(categoryall);
    }
    catch(e){
        res.status(400).json({error:e.message});
    }

});
module.exports=categoryRouter;