const express=require("express");
const orderRouter=express.Router();
const Order = require("../models/order");
// post route for creating Router
orderRouter.post("/api/orders",async(req,res) =>{
    try{
        const {
            fullName,
            email,
            state,
            city,
            locality,
            productName,
            productPrice,
            quantity,
            category,
            image,
            buyerId,
            vendorId,
            
        } =req.body;
        createdAt=new Date().getMilliseconds();
        const order=new Order({
            fullName,
            email,
            state,
            city,
            locality,
            productName,
            productPrice,
            quantity,
            category,
            image,
            buyerId,
            vendorId,
            createdAt
        });
        await order.save();
        return res.status(201).json(order);
    }
    catch(error){
        res.status(500).json({error});
        
    }
});
// get route for fetching items based on buyerid
orderRouter.get("/api/orders/:buyerId",async(req,res) => {
    try{
        const{buyerId} =req.params;
        const orders=await Order.find({buyerId});
        // if no orders found return 404 status
        if(orders.length ==0){
            return res.status(404).json({msg:"NO orders found this buyer"});
        }
        return res.status(200).json(orders);

    }
    catch(e){
        res.status(500).json({error:e.message});
    }


});
module.exports=orderRouter;