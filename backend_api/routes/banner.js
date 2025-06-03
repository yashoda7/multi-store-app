const express=require("express");
const Banner=require("../models/baner");
const bannerRouter=express.Router();
bannerRouter.post('/api/banner',async(req,res) =>{
    try{
        const {image}=req.body;
        const banner=new Banner({image});
        await banner.save();
        return res.status(200).send(banner);
       }
    catch(e){
        res.status(400).json({error:e.message});
        }
});
bannerRouter.get("/api/banner",async (req,res) =>{
    try{
        const bannerall=await Banner.find();
        res.status(200).send(bannerall);
    }
    catch(e){
        res.status(400).json({error:e.message});
    }

});
module.exports=bannerRouter;