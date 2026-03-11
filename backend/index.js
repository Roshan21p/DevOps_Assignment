// importing express modules
const express = require("express");

// importing cors modules
const cors = require("cors");

// importing axios modules
const axios = require("axios");

// creating express app
const app = express();

// using cors middleware
app.use(cors());

// using express json middleware if needed to parse json data in request body
app.use(express.json());

const PORT = 3000;

app.get("/", (req, res) => {
  res.status(200).json({ message: "The server is running!" });
});

app.get("/api/phones", async (req, res) => {
  try {
    const response = await axios.get(
      "https://dummyjson.com/products/category/smartphones?limit=5",
    );
    res.json(response.data.products);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch products" });
  }
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
