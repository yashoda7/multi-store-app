const express=require("express");
const Vendor = require("../models/vendor");
const vendorRouter=express.Router();
const bcryptjs = require("bcryptjs");
const jwt=require('jsonwebtoken');
vendorRouter.post("/api/vendor/signup",async (req,res)=>{
    try{
        const{fullName,email,password}=req.body;
        const existingEmail = await Vendor.findOne({ email }); 
        if(existingEmail){
            return res.status(400).json({msg:"vendor user with same email already exist "});
        }
        else{
            //generate the salt with the cost of the 10;
            const salt=await bcryptjs.genSalt(10);
            //hash the password using the generated salt
            const hashedPassword=await bcryptjs.hash(password,salt);
           var vendor= new Vendor({fullName,email,password:hashedPassword});
           vendor=await vendor.save();
  console.log("Body:", req.body);
        //    res.json({msg:"Accounted created sucessfully.."});
        res.json(vendor);
        }

    }
    catch(error){
        res.status(500).json({ error: error.message }); 
    }
});
vendorRouter.post("/api/vendor/signin",async(req,res) =>{
    try{
        const{email,password}=req.body;
        const existingVenoder = await Vendor.findOne({ email }); 
        if(!existingVenoder){
            return res.status(400).json({msg:"vendor is not created account"});
        }
        else{
            const isMatch=await bcryptjs.compare(password,existingVenoder.password);
            if(!isMatch){
                res.status(400).json({msg:"Incorrect password"});
            }
            else{
                const token=jwt.sign({id:existingVenoder._id},"passwordKey");
                const {password,...vendorWithoutPassword}=existingVenoder._doc;
                // res.json(token,...userWithoutPassword);
                res.status(200).json({
                    token,
                    vendor:vendorWithoutPassword,
                  });
                  

                res.status(200);
            }
        }
    }
    catch(error){
        res.status(500).json(e.message);
    }
})
module.exports=vendorRouter;