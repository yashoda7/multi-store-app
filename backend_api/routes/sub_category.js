const express = require("express");
const SubCategory = require("../models/sub_category");
const subCategoryRouter = express.Router();

// POST Route
subCategoryRouter.post("/api/subCategories", async (req, res) => {
    try {
        // const { categoryid, categoryName, image, subCategoryName } = req.body;
        const {categoryid, categoryName, image, subcategoryName} = req.body;
        const newSubCategory = new SubCategory({ categoryid, categoryName, image, subcategoryName });
        await newSubCategory.save();
        res.status(200).send(newSubCategory);
    } catch (e) {
        res.status(400).json({ error: e.message });
    }
});

// GET All Subcategories
subCategoryRouter.get("/api/subCategories", async (req, res) => {
    try {
        const subcategories = await SubCategory.find();
        return res.status(200).json(subcategories);
    } catch (e) {
        res.status(400).json({ error: e.message });
    }
});

// GET Subcategories by Category Name
subCategoryRouter.get("/api/category/:categoryName/subcategories", async (req, res) => {
    try {
        const { categoryName } = req.params;
        const subcategories = await SubCategory.find({ categoryName });
        if (!subcategories || subcategories.length === 0) {
            return res.status(404).json({ msg: "Subcategories not found" });
        }
        return res.status(200).json(subcategories);
    } catch (e) {
        res.status(400).json({ error: e.message });
    }
});

module.exports = subCategoryRouter;
