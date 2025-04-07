const express=require('express');
const User=require("../models/user");
const authRouter=express.Router();
const bcryptjs=require('bcryptjs');
const jwt=require('jsonwebtoken');
authRouter.post("/api/signup",async (req,res)=>{
    try{
        const{fullName,email,password}=req.body;
        const existingEmail = await User.findOne({ email }); 
        if(existingEmail){
            return res.status(400).json({msg:"user with same email already exist "});
        }
        else{
            //generate the salt with the cost of the 10;
            const salt=await bcryptjs.genSalt(10);
            //hash the password using the generated salt
            const hashedPassword=await bcryptjs.hash(password,salt);
           var user= new User({fullName,email,password:hashedPassword});
           user=await user.save();
  console.log("Body:", req.body);
           res.json({msg:"Accounted created sucessfully.."});
        }

    }
    catch(error){
        res.status(500).json({ error: error.message }); 
    }
});
//sign in api
authRouter.post("/api/signin",async(req,res) =>{
    try{
        const{email,password}=req.body;
        const existingUser = await User.findOne({ email }); 
        if(!existingUser){
            return res.status(400).json({msg:"user is not created account"});
        }
        else{
            const isMatch=await bcryptjs.compare(password,existingUser.password);
            if(!isMatch){
                res.status(400).json({msg:"Incorrect password"});
            }
            else{
                const token=jwt.sign({id:existingUser._id},"passwordKey");
                const {password,...userWithoutPassword}=existingUser._doc;
                // res.json(token,...userWithoutPassword);
                res.status(200).json({
                    token,
                    user: userWithoutPassword,
                  });
                  

                res.status(200);
            }
        }
    }
    catch(error){
        res.status(500).json(e.message);
    }
})
module.exports=authRouter;