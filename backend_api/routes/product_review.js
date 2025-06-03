const expres=require("express");
const ProductReview=require("../models/product_review");
const productReviewRouter=expres.Router();
productReviewRouter.post("/api/product-review",async (req,res) =>{
    try{
        const {buyerId,email,fullName,productId,rating,review} =req.body;
        const reviews=new ProductReview({buyerId,email,fullName,productId,rating,review});
        await reviews.save();
        res.status(200).send(reviews);
    }
    catch(e){
        res.status(400).json({error:e.message});
    }
});
productReviewRouter.get("api/product-reviews",(req,res)=>{
    try{
        const reviews=ProductReview.find();
    return res.status(200).json(reviews);
    }
    catch(e){
        res.status(400).json({error:e.message});
    }
    

});
module.exports=productReviewRouter;