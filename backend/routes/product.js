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


//get all product
router.get("/product", async function (req, res, next) {
  try {
    const search = req.query.search || ''
    let sql = 'SELECT a.*, b.file_path FROM `plants` AS a LEFT JOIN (SELECT * FROM plant_image WHERE plant_id > 0) AS b ON a.plant_id = b.plant_id;'
    let cond = []

    if (search.length > 0) {
      sql = 'SELECT a.*, b.file_path FROM `plants` AS a LEFT JOIN (SELECT * FROM plant_image WHERE plant_id > 0) AS b ON a.plant_id = b.plant_id WHERE a.plant_name LIKE ? OR a.plant_info LIKE ?;'
      cond = [`%${search}%`, `%${search}%`]
    }
    const [rows, fields] = await pool.query(sql, cond);
    // console.log(rows[10].plant_id)
    return res.json(rows);
  } catch (err) {
    return res.status(500).json(err)
  }
});

//get by id
router.get("/product/:id", function (req, res, next) {
  // Query data from 3 tables
  const promise1 = pool.query("SELECT * FROM plants WHERE plant_id=?", [
    req.params.id,
  ]);
  const promise2 = pool.query("SELECT * FROM plant_image WHERE plant_id=?", [
    req.params.id,
  ]);

  // Use Promise.all() to make sure that all queries are successful
  Promise.all([promise1, promise2])
    .then((results) => {
      const [plants, plantsFields] = results[0];
      const [plant_image, plant_imageFields] = results[1];
      if(typeof plants[0] === 'undefined'){
       return res.json("ไม่พบข้อมูล")
      }
      // console.log(plants[0])
      // console.log(plant_image[0].file_path)
      res.json({
        plants: plants[0],
        plant_image: plant_image[0].file_path,
        error: null,
      });
    })
    .catch((err) => {
      return res.status(500).json(err);
    });
});



const addPdSchema = Joi.object({
  plant_name: Joi.string().required().min(5),
  plant_info: Joi.string().required().min(20).max(200),
  plant_price: Joi.string().required(),
  plant_type: Joi.string().required(),
})

//add product
router.post("/add/product", upload.array("myImage", 5), async function (req, res, next) {
  try {
    await addPdSchema.validateAsync(req.body, { abortEarly: false })
} catch (err) {
    return res.status(400).send(err)
}

  const file = req.files;
  let pathArray = [];

  if (!file) {
    return res.status(400).json({ message: "Please upload a file" });
  }

  const plant_name = req.body.plant_name;
  const plant_info = req.body.plant_info;
  const plant_price = req.body.plant_price;
  // const plant_image = req.body.plant_image;
  const plant_type = req.body.plant_type;

  // Begin transaction
  const conn = await pool.getConnection();
  await conn.beginTransaction();

  try {
    let results = await conn.query(
      "INSERT INTO plants(plant_name, plant_info, plant_price, plant_type) " +
        "VALUES(?, ?, ?, ?);",
      [plant_name, plant_info, plant_price, plant_type]
    );
    const plant_id = results[0].insertId;

    req.files.forEach((file, index) => {
      let path = [plant_id, file.path.substring(6).replaceAll("\\","/")];
      pathArray.push(path);
    });

    await conn.query(
      "INSERT INTO plant_image(plant_id, file_path) VALUES ?;",
      [pathArray]
    );

    await conn.commit();
    res.send("success!");
  } catch (err) {
    await conn.rollback();
    return res.status(400).json(err);
  } finally {
    conn.release();
  }
}
);

//put product
router.put( "/update/product/:id", isLoggedIn, upload.array("myImage", 5),
  async function (req, res, next) {
    // Your code here
    const file = req.files;
    let pathArray = [];

    if (!file) {
      const error = new Error("Please upload a file");
      error.httpStatusCode = 400;
      next(error);
    }

    const title = req.body.title;
    const content = req.body.content;
    const status = req.body.status;
    const pinned = req.body.pinned;

    const conn = await pool.getConnection();
    await conn.beginTransaction();

    try {
      console.log(content);
      let results = await conn.query(
        "UPDATE blogs SET title=?, content=?, status=?, pinned=? WHERE id=?",
        [title, content, status, pinned, req.params.id]
      );

      if (file.length > 0) {
        file.forEach((file, index) => {
          let path = [req.params.id, file.path.substring(6), 0];
          pathArray.push(path);
        });

        await conn.query(
          "INSERT INTO images(blog_id, file_path, main) VALUES ?;",
          [pathArray]
        );
      }

      await conn.commit();
      res.send("success!");
    } catch (err) {
      await conn.rollback();
      next(err);
    } finally {
      console.log("finally");
      conn.release();
    }
    return;
  }
);

// delete product
router.delete("/delete/product/:id", async (req, res, next) => {
  const plant_id = req.params.id
  console.log(plant_id)
  const conn = await pool.getConnection();
  await conn.beginTransaction();
  try {
      const [row, col] = await conn.query(`DELETE FROM plants WHERE plant_id =?`, [plant_id])
      const [avg, col2] = await conn.query(`DELETE FROM plant_image WHERE plant_id =?`, [plant_id]);

      await conn.commit()
      res.send("Delete Successfully").status(200)
  } catch (err) {
      console.log(err)
      await conn.rollback();
      res.status(404).json(err.message)
  } finally {
      conn.release();
  }
})


exports.router = router;
