const express = require("express");
const pool = require("../config");
const Joi = require("joi");
const bcrypt = require("bcrypt");
const { generateToken } = require("../utils/token");
const { isLoggedIn } = require("../middlewares");
const { emit } = require("process");

router = express.Router();

//get user
router.get("/user/manage", isLoggedIn, async (req, res, next) => {
  // req.user ถูก save ข้อมูล user จาก database ใน middleware function "isLoggedIn"
  const conn = await pool.getConnection();
  await conn.beginTransaction();

  try {
    const [rows, fields] = await conn.query(
        'SELECT * FROM `users` WHERE `id` = ?',
        [req.user.id]
      ) 
      await conn.commit()
    //   console.log({ user: rows[0], error: null })
      return res.json({ user: rows[0], error: null })
  } catch (err) {
    await conn.rollback();
    return res.status(500).json(err);
  } finally {
    console.log("finally");
    conn.release();
  }
});

//update profile
router.put("/user/updateProfile", isLoggedIn, async (req, res, next) => {
    // req.user ถูก save ข้อมูล user จาก database ใน middleware function "isLoggedIn"

    const first_name = req.body.first_name
    const last_name = req.body.last_name
    const mobile = req.body.mobile
    const email = req.body.email

    const conn = await pool.getConnection();
    await conn.beginTransaction();

    try {
      const [rows, fields] = await conn.query(
          'UPDATE `users` SET first_name=?, last_name=?, mobile=?, email=? WHERE `id` = ?',
          [first_name, last_name, mobile, email, req.user.id]
        )  
        await conn.commit()
      //   console.log({ user: rows[0], error: null })
        return res.json({
          first_name: first_name,
          last_name: last_name,
          mobile: mobile,
          email: email,
        })
    } catch (err) {
      await conn.rollback();
      return res.status(500).json(err);
    } finally {
      console.log("finally");
      conn.release();
    }
  });

exports.router = router;
