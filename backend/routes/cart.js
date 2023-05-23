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


//get cart_id, customer_id หน้าเช็ค manage product
router.get("/cusId", async function (req, res, next) {
  try {
    const [rows, fields] = await pool.query(
      "SELECT customer_id  FROM `customer` LEFT JOIN users using(id) where users.id = customer.id"
    );
    // const [rows2, fields2] = await pool.query("SELECT customer_id, cart_id  FROM `customer` LEFT JOIN cart using(customer_id) where customer.id = customer.id")

    console.log(rows);
    // console.log('555 '+ rows2[0].cat)
    return res.json({ cusId: rows[0], error: null });
  } catch (err) {
    return res.status(500).json(err);
  }
});


//add item to cart by customer id order ด้วย หน้าเช็ค manage PD
router.post("/addPD/tocart/:cusId", async function (req, res, next) {
  const conn = await pool.getConnection();
  await conn.beginTransaction();

  const cusId = req.params.cusId;
  const item = req.body.cart;
  const totalPrice = req.body.totalPrice;
  try {
    let cart = await conn.query(
      "INSERT INTO cart(cart_date, total_price ,customer_id)" +
        "VALUES(CURRENT_TIMESTAMP, ?, ?);",
      [totalPrice, cusId]
    );

    const cartId = cart[0].insertId;
    // console.log("hhhhh " + cartId);
    for (let i = 0; i < item.length; i++) {
      let productPrice = req.body.cart[i].plant_price;
      let orderAmount = req.body.cart[i].quantity;
      let total_unit_Price =
        req.body.cart[i].plant_price * req.body.cart[i].quantity;
      let productId = req.body.cart[i].plant_id;



      let cart_item = await conn.query(
        "INSERT INTO cart_item(unit_price, amount, total_unit_price, plant_id, cart_id)" +
          "VALUES(?, ?, ?, ?, ?);",
        [productPrice, orderAmount, total_unit_Price, productId, cartId]
      );

      // let order = await conn.query(
      //   "INSERT INTO `order` (customer_id, cart_id)" + 
      //   "VALUES(?, ?);",
      //   [cusId, cartId]
      // );

      let select_cartId = await conn.query(
        "SELECT cart_id FROM cart_item join cart using (cart_id) where cart_id = ?",
        [cartId]
      );
      console.log({
        select_cartId: select_cartId[0],
        // remainproduct: changeOrder[0][i].product_amount - changeOrder[0][i].order_amount
      });
    }
    await conn.commit();
    res.json({
      cartId: cartId,
    });
    console.log(cartId);
  } catch (err) {
    await conn.rollback();
    return res.status(400).json(err);
  } finally {
    conn.release();
  }
});

//get all cart
// router.get("/product/:id", function (req, res, next) {
//   // Query data from 3 tables
//   const promise1 = pool.query("SELECT * FROM plants WHERE plant_id=?", [
//     req.params.id,
//   ]);
//   const promise2 = pool.query("SELECT * FROM plant_image WHERE plant_id=?", [
//     req.params.id,
//   ]);

//   // Use Promise.all() to make sure that all queries are successful
//   Promise.all([promise1, promise2])
//     .then((results) => {
//       const [plants, plantsFields] = results[0];
//       const [plant_image, plant_imageFields] = results[1];
//       if(typeof plants[0] === 'undefined'){
//        return res.json("ไม่พบข้อมูล")
//       }
//       // console.log(plants[0])
//       // console.log(plant_image[0].file_path)
//       res.json({
//         plants: plants[0],
//         plant_image: plant_image[0].file_path,
//         error: null,
//       });
//     })
//     .catch((err) => {
//       return res.status(500).json(err);
//     });
// });


//get cart by cart id หน้าเช็ค cart
router.get("/itemsInCart/:cartId", async (req, res, next) => {
  const conn = await pool.getConnection();
  await conn.beginTransaction();

  const cartId = req.params.cartId;
  try {
    const [row, col] = await conn.query(
      `SELECT * FROM cart JOIN cart_item USING (cart_id) 
      JOIN customer USING (customer_id) 
      JOIN plants USING (plant_id) 
      JOIN plant_image USING (plant_id)WHERE cart_id = ?`,
      [cartId]
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

//put item
// router.put("/blogs/:id", upload.array("myImage", 5), async function (req, res, next) {
//     // Your code here
//     const file = req.files;
//     let pathArray = [];

//     if (!file) {
//       const error = new Error("Please upload a file");
//       error.httpStatusCode = 400;
//       next(error);
//     }

//     const title = req.body.title;
//     const content = req.body.content;
//     const status = req.body.status;
//     const pinned = req.body.pinned;

//     const conn = await pool.getConnection();
//     await conn.beginTransaction();

//     try {
//       console.log(content);
//       let results = await conn.query(
//         "UPDATE blogs SET title=?, content=?, status=?, pinned=? WHERE id=?",
//         [title, content, status, pinned, req.params.id]
//       );

//       if (file.length > 0) {
//         file.forEach((file, index) => {
//           let path = [req.params.id, file.path.substring(6), 0];
//           pathArray.push(path);
//         });

//         await conn.query(
//           "INSERT INTO images(blog_id, file_path, main) VALUES ?;",
//           [pathArray]
//         );
//       }

//       await conn.commit();
//       res.send("success!");
//     } catch (err) {
//       await conn.rollback();
//       next(err);
//     } finally {
//       console.log("finally");
//       conn.release();
//     }
//     return;
//   }
// );

// delete item
// router.delete("/deleteItem/:itemNo/:cartId", isLoggedIn, async (req, res, next) => {
//   const conn = await pool.getConnection();
//   await conn.beginTransaction();
//   try {
//       const [deleteItem, col] = await conn.query(`DELETE FROM cart_item WHERE item_no = ?`, [req.params.itemNo]);
//       const [sumPrice, col2] = await conn.query(`SELECT sum(price) as total FROM ebook JOIN cart_item USING (ebook_id) WHERE cart_id =?`, [req.params.cartId]);
//       console.log(sumPrice)
//       const [updateTotalPrice, col3] = await conn.query(`UPDATE cart SET total_price=? WHERE cart_id=?`, [sumPrice[0].total, req.params.cartId])
//       await conn.commit()
//       res.send("Delete item Successfully").status(200);
//   } catch (err) {
//       console.log(err)
//       await conn.rollback();
//       res.status(404).json(err.message)
//   } finally {
//       conn.release();
//   }
// })



exports.router = router;
