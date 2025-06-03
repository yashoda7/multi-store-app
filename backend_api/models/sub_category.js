const mongoose=require("mongoose");
const subcategorySchema=mongoose.Schema({
    categoryid:{
        type:String,
        required:true,
    },
    categoryName:{
        type:String,
        required:true,
    },
    image:{
        type:String,
        required:true,

    },
    subcategoryName:{
        type:String,
        required:true,
    }
});
const subCategory=mongoose.model("SubCategory",subcategorySchema);
module.exports=subCategory;