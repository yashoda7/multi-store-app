const mongoose=require("mongoose");
const bannerSchema=mongoose.Schema({
    image:{
        type:String,
        required:true,
    }
});
const Banners=mongoose.model("Banner",bannerSchema);
module.exports=Banners;