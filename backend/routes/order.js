const express = require("express");
const pool = require("../config");
const Joi = require("joi");
const bcrypt = require("bcrypt");
const { generateToken } = require("../utils/token");
const { isLoggedIn } = require("../middlewares");
const { emit } = require("process");
const path = require("path");
const fs = require("fs");
const multer = require("multer");

router = express.Router();

// SET STORAGE
const storage = multer.diskStorage({
  destination: function (req, file, callback) {
    callback(null, "./static/uploads");
  },
  filename: function (req, file, callback) {
    callback(
      null,
      file.fieldname + "-" + Date.now() + path.extname(file.originalname)
    );
  },
});
const upload = multer({ storage: storage });

// get item หน้าเช็ค order
router.get("/allorder", async function (req, res, next) {

  const conn = await pool.getConnection();
  await conn.beginTransaction();

  try {
    const [row, col] = await conn.query(
      "SELECT * FROM `order` JOIN order_image USING (order_id) JOIN users JOIN customer USING (id) JOIN cart USING (cart_id) JOIN cart_item USING (cart_id) JOIN plants USING (plant_id) JOIN plant_image USING (plant_id)"
    );

    await conn.commit();
    res.send(row)
    // console.log(row)
  } catch (err) {
    console.log(err);
    await conn.rollback();
    res.status(404).json(err.message);
  } finally {
    conn.release();
  }
});




// confirm to order by cart id หน้าเช็ค cart
router.post('/confirm/order', upload.array("myImage", 5), async function (req, res, next) {
  const file = req.files;
  let pathArray = [];
  console.log(file)

  if (!file) {
    return res.status(400).json({ message: "Please upload a file" });
  }

  const cartId = req.body.cartId
  const cusId = req.body.cusId
  const address = req.body.address
  console.log(cusId)
  console.log(cartId)
  console.log(address)

    // Begin transaction
    const conn = await pool.getConnection();
    await conn.beginTransaction();

  try {
    let results = await conn.query(
      "INSERT INTO `order`(address, status, customer_id, cart_id) " +
        "VALUES(?, ?, ?, ?);",
      [address, 'approved_bill', cusId, cartId]
    );
    const order_id = results[0].insertId;

    req.files.forEach((file, index) => {
      let path = [order_id, file.path.substring(6).replaceAll("\\","/")];
      pathArray.push(path);
    });

    await conn.query(
      "INSERT INTO `order_image`(order_id, file_path) VALUES ?;",
      [pathArray]
    );

    await conn.commit();
    res.status(200).send("Add Order Success");
    } catch (err) {
    await conn.rollback();
    return res.status(400).json(err);
    } finally {
      conn.release();
    }
});


exports.router = router;
