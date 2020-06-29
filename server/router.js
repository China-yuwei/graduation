var db = require('../server/mysql')
module.exports = function (app) {
    app.use('*', function (req, res, next) {
        res.header('Access-Control-Allow-Origin', req.headers.origin); //注意这里不能使用 *
        // res.header('Access-Control-Allow-Origin:*');//允许所有来源访问 
        res.header('Access-Control-Allow-Headers', 'Content-Type, Content-Length, Authorization, Accept, X-Requested-With , yourHeaderFeild');
        res.header("X-Powered-By", ' 3.2.1');
        res.header('Access-Control-Allow-Credentials', true); // 允许服务器端发送Cookie数据
        res.header("Content-Type", "application/json;charset=utf-8");
        res.header('Access-Control-Allow-Methods', 'PUT, POST, GET, DELETE, OPTIONS'); //设置方法
        if (req.method == 'OPTIONS') {
            res.sendStatus(200); // 在正常的请求之前，会发送一个验证，是否可以请求。
        } else {
            next();
        }
    });
    var success = {
        'result': '1',
        'msg': 'success',
        'data': null
    }
    var error = {
        'result': '0',
        'msg': 'error',
        'data': '输入参数错误'
    }
    // 用户登录
    app.get('/login/user', function (req, res) {
        let sql = 'SELECT * FROM t_user'
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '连接成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '连接失败';
                res.send(result);
            }
        })
    });
    // 管理员登录
    app.get('/login/admin', function (req, res) {
        let sql = 'SELECT * FROM t_admin'
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '连接成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '连接失败';
                res.send(result);
            }
        })
    });
    // 用户注册
    app.get('/register', function (req, res, next) {
        let tel = req.query.userPhone;
        let pwd = req.query.userPassword;
        let sql = `INSERT INTO t_user(user_phone,user_password) VALUES ('${tel}','${pwd}')`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '注册成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '注册失败';
                res.send(result)
            }
        })
    });
    // 修改用户名
    app.get('/modify/userName', function (req, res, next) {
        let name = req.query.userName;
        let id = req.query.userId;
        let sql = `UPDATE t_user SET user_name='${name}' WHERE user_id='${id}' `;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '用户名修改成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '用户名修改失败';
                res.send(result)
            }
        })
    });
    // 修改用户性别
    app.get('/modify/userSex', function (req, res, next) {
        let sex = req.query.userSex;
        let id = req.query.userId;
        let sql = `UPDATE t_user SET user_sex='${sex}' WHERE user_id='${id}' `;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '性别修改成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '性别修改失败';
                res.send(result)
            }
        })
    });
    // 修改用户头像
    app.get('/modify/userHeadImg', function (req, res, next) {
        let src = req.query.userHeadImg;
        let id = req.query.userId;
        let sql = `UPDATE t_user SET user_headImg='${src}' WHERE user_id='${id}' `;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '头像修改成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '头像修改失败';
                res.send(result)
            }
        })
    });
    // 设置用户权限
    app.get('/modify/userType', function (req, res, next) {
        let type = req.query.userType;
        let id = req.query.userId;
        let sql = `UPDATE t_user SET user_type='${type}' WHERE user_id=${id} `;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '用户权限修改成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '用户权限修改失败';
                res.send(result)
            }
        })
    });
    // 修改用户密码
    app.get('/modify/userPassword', function (req, res, next) {
        let pwd = req.query.userPassword;
        let id = req.query.userId;
        let sql = `UPDATE t_user SET user_password=${pwd} WHERE user_id=${id} `;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '密码修改成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '密码修改失败';
                res.send(result)
            }
        })
    });
    // 查询用户地址
    app.get('/set/address', function (req, res) {
        let id = req.query.userId
        let sql = `SELECT * FROM t_user_address WHERE user_id=${id}`
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '查询成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '查询失败';
                res.send(result);
            }
        })
    });
    // 新增用户地址
    app.get('/add/userAddress', function (req, res, next) {
        let provence = req.query.userProvence;
        let house = req.query.userHouse
        let id = req.query.userId;
        let name = req.query.userName;
        let phone = req.query.userPhone;
        let sql = `INSERT INTO t_user_address(user_id,address_user,address_phone,address_provence,address_house) VALUES (${id},"${name}","${phone}","${provence}","${house}")`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '新增用户地址成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '新增用户地址失败';
                res.send(result)
            }
        })
    });
    // 删除用户地址
    app.get('/del/userAddress', function (req, res, next) {
        let id = req.query.addressId;
        let sql = `delete from t_user_address where address_id=${id}`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '地址删除成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '地址删除失败';
                res.send(result)
            }
        })
    });
    // 修改用户地址
    app.get('/modify/userAddress', function (req, res, next) {
        let provence = req.query.userProvence;
        let house = req.query.userHouse
        let name = req.query.userName;
        let phone = req.query.userPhone;
        let id = req.query.addressId;
        let sql = `UPDATE t_user_address SET address_user='${name}',address_phone='${phone}',address_provence='${provence}',address_house='${house}' WHERE address_id=${id} `;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '地址修改成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '地址修改失败';
                res.send(result)
            }
        })
    });
    // 茶叶品种分类接口
    app.get('/goods/class', function (req, res) {
        let sql = 'SELECT * FROM t_goods_class'
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '连接成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '连接失败';
                res.send(result);
            }
        })
    });
    // 热搜商品接口
    app.get('/home/search', function (req, res) {
        let sql = 'SELECT * FROM t_home_search'
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '连接成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '连接失败';
                res.send(result);
            }
        })
    });
    // 最近搜索商品接口
    app.get('/home/nearSearch', function (req, res) {
        let id = req.query.userId;
        let sql = `SELECT * FROM t_home_search WHERE user_id=${id}`
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '连接成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '连接失败';
                res.send(result);
            }
        })
    });
    // 搜索商品接口
    app.get('/home/to/search', function (req, res, next) {
        let id = req.query.userId;
        let keyword = req.query.inputKeyword;
        let sql = `INSERT INTO t_home_search(user_id,search_keyword) VALUES (${id},"${keyword}")`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '搜索成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '搜索失败';
                res.send(result)
            }
        })
    });
    // 搜索商品接口
    app.get('/home/toSearch', function (req, res, next) {
        let keyword = req.query.inputKeyword;
        let sql = `SELECT * FROM t_goods WHERE g_name LIKE '%${keyword}%' OR g_introduce LIKE '%${keyword}%' OR class_name LIKE '%${keyword}%'`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '连接成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '连接失败';
                res.send(result);
            }
        })
    });
    // 清空最近搜索
    app.get('/del/nearSearch', function (req, res, next) {
        let id = req.query.userId;
        let sql = `delete from t_home_search where user_id=${id}`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '最近搜索清空成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '最近搜索清空失败';
                res.send(result)
            }
        })
    });
    // 我的工具箱
    app.get('/my/tool', function (req, res) {
        let sql = 'SELECT * FROM t_tool'
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '连接成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '连接失败';
                res.send(result);
            }
        })
    });
    // 我的内容
    app.get('/my/content', function (req, res) {
        let sql = 'SELECT * FROM t_my_content'
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '连接成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '连接失败';
                res.send(result);
            }
        })
    });
    // 我的收藏
    app.get('/my/favorites', function (req, res) {
        let id = req.query.userId
        let sql = `SELECT * FROM t_favorites WHERE user_id=${id}`
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '查询成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '查询失败';
                res.send(result);
            }
        })
    });
    // 添加收藏
    app.get('/add/my/favorites', function (req, res, next) {
        let id = req.query.userId;
        let gid = req.query.goodsId;
        let price = req.query.goodsPrice;
        let name = req.query.goodsName;
        let src = req.query.goodsSrc;
        let sql = `INSERT INTO t_favorites(user_id,g_id,g_name,g_price,g_src) VALUES (${id},${gid},"${name}","${price}","${src}")`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '添加收藏成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '添加收藏失败';
                res.send(result)
            }
        })
    });
    // 删除我的收藏
    app.get('/del/my/favorites', function (req, res, next) {
        let id = req.query.favoritesId;
        let sql = `delete from t_favorites where f_id=${id}`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '我的收藏删除成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '我的收藏删除失败';
                res.send(result)
            }
        })
    });
    // 我的关注
    app.get('/my/follow', function (req, res) {
        let id = req.query.userId
        let sql = `SELECT * FROM t_follow WHERE user_id=${id}`
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '查询成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '查询失败';
                res.send(result);
            }
        })
    });
    // 删除我的关注
    app.get('/del/my/follow', function (req, res, next) {
        let id = req.query.favoritesId;
        let sql = `delete from t_follow where f_id=${id}`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '我的收藏删除成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '我的收藏删除失败';
                res.send(result)
            }
        })
    });
    // 添加关注
    app.get('/add/my/follow', function (req, res, next) {
        let uId = req.query.userId;
        let name = req.query.shopName;
        let sId = req.query.shopId;
        let icon = req.query.shopIcon;
        let bg = req.query.shopBg;
        let bga = req.query.shopBga;
        let bgb = req.query.shopBgb;
        let bgc = req.query.shopBgc;
        let sql = `INSERT INTO t_follow(user_id,shop_id,shop_name,shop_icon,s_bg,s_bga,s_bgb,s_bgc) VALUES (${uId},${sId},"${name}","${icon}","${bg}","${bga}","${bgb}","${bgc}")`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '添加关注成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '添加关注失败';
                res.send(result)
            }
        })
    });
    // 我的积分
    app.get('/my/integral', function (req, res) {
        let id = req.query.userId
        let sql = `SELECT * FROM t_integral WHERE user_id=${id}`
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '查询成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '查询失败';
                res.send(result);
            }
        })
    });
    // 增加积分
    app.get('/add/my/integral', function (req, res, next) {
        let name = req.query.integralName;
        let iId = req.query.integralId
        let id = req.query.userId;
        let time = req.query.integralTime;
        let num = req.query.integralNum
        let sql = `INSERT INTO t_integral(user_id,i_id,i_name,i_num,i_time) VALUES (${id},${iId},"${name}",${num},"${time}")`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '增加积分成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '增加积分失败';
                res.send(result)
            }
        })
    });
    // 我的足迹
    app.get('/my/footprint', function (req, res) {
        let id = req.query.userId
        let sql = `SELECT * FROM t_footprint WHERE user_id=${id}`
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '查询成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '查询失败';
                res.send(result);
            }
        })
    });
    // 增加我的足迹
    app.get('/add/my/footprint', function (req, res, next) {
        let id = req.query.userId;
        let gId = req.query.goodId;
        let name = req.query.goodName;
        let price = req.query.goodPrice;
        let src = req.query.goodSrc;
        let time = req.query.fTime;
        let sql = `INSERT INTO t_footprint(user_id,g_id,g_name,g_price,g_src,f_time) VALUES (${id},${gId},"${name}","${price}","${src}","${time}")`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '增加我的足迹成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '增加我的足迹失败';
                res.send(result)
            }
        })
    });
    // 清空我的足迹
    app.get('/del/my/footprint', function (req, res, next) {
        let id = req.query.userId;
        let sql = `delete from t_footprint where user_id=${id}`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '我的足迹删除成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '我的足迹删除失败';
                res.send(result)
            }
        })
    });
    // 我的订单
    app.get('/my/order', function (req, res) {
        let id = req.query.userId
        let sql = `SELECT * FROM t_order WHERE user_id=${id}`
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '查询成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '查询失败';
                res.send(result);
            }
        })
    });
    // 确认订单
    app.get('/my/order/confirm', function (req, res) {
        let id = req.query.scId
        let sql = `SELECT * FROM t_order WHERE sc_id=${id}`
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '查询成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '查询失败';
                res.send(result);
            }
        })
    });
    // 添加订单
    app.get('/add/my/order', function (req, res) {
        let uId = req.query.userId;
        let gId = req.query.goodId;
        let sId = req.query.shopId;
        let sName = req.query.shopName;
        let gName = req.query.goodName;
        let gSrc = req.query.goodSrc;
        let gP = req.query.goodPrice;
        let num = req.query.scNum;
        let time = req.query.oTime;
        let type = req.query.oType;
        let scId = req.query.scId;
        let sql = `INSERT INTO t_order(user_id,shop_id,shop_name,g_id,g_name,g_price,g_num,g_src,o_time,o_type,sc_id) VALUES (${uId},${sId},"${sName}",${gId},"${gName}","${gP}",${num},"${gSrc}","${time}","${type}",${scId})`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '添加订单成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '添加订单失败';
                res.send(result)
            }
        })
    });
    // 订单地址
    app.get('/modify/my/order/address', function (req, res, next) {
        let id = req.query.orderId;
        let aid = req.query.addressId;
        let sql = `UPDATE t_order SET address_id=${aid} WHERE o_id=${id}`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '地址修改成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '地址修改失败';
                res.send(result)
            }
        })
    });
    // 提交订单
    app.get('/my/order/confirm/submit', function (req, res, next) {
        let id = req.query.orderId;
        let env = req.query.orderE;
        let inte = req.query.orderI;
        let cou = req.query.orderC;
        let total = req.query.orderT;
        let sql = `UPDATE t_order SET o_evenlope="${env}",o_integral=${inte},o_coupon=${cou},o_total="${total}" WHERE o_id=${id}`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '提交订单成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '提交订单失败';
                res.send(result)
            }
        })
    });
    // 提交订单
    app.get('/my/order/submit', function (req, res) {
        let id = req.query.oId
        let sql = `SELECT * FROM t_order WHERE o_id=${id}`
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '查询成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '查询失败';
                res.send(result);
            }
        })
    });
    // 我的红包
    app.get('/my/envelope', function (req, res) {
        let id = req.query.userId
        let sql = `SELECT * FROM t_envelope WHERE user_id=${id}`
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '查询成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '查询失败';
                res.send(result);
            }
        })
    });
    // 增加红包
    app.get('/add/my/envelope', function (req, res, next) {
        let name = req.query.envelopeName;
        let type = req.query.envelopeType;
        let id = req.query.userId;
        let time = req.query.envelopeTime;
        let num = req.query.envelopeNum
        let sql = `INSERT INTO t_envelope(user_id,e_name,e_money,e_type,e_time) VALUES (${id},"${name}","${num}","${type}","${time}")`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '增加红包成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '增加红包失败';
                res.send(result)
            }
        })
    });
    // 我的优惠券
    app.get('/my/coupon', function (req, res) {
        let id = req.query.userId
        let sql = `SELECT * FROM t_coupon WHERE user_id=${id}`
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '查询成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '查询失败';
                res.send(result);
            }
        })
    });
    // 分类——小类别
    app.get('/goods/class/child', function (req, res) {
        let sql = `SELECT * FROM t_g_class_child `
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '查询成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '查询失败';
                res.send(result);
            }
        })
    });
    // 首页内容接口
    app.get('/home/list', function (req, res) {
        let sql = 'SELECT * FROM t_home_list'
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '连接成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '连接失败';
                res.send(result);
            }
        })
    });
    // 商品接口
    app.get('/goods', function (req, res) {
        let sql = 'SELECT * FROM t_goods'
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '连接成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '连接失败';
                res.send(result);
            }
        })
    });
    // 店铺接口
    app.get('/shops', function (req, res) {
        let sql = 'SELECT * FROM t_shops'
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '连接成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '连接失败';
                res.send(result);
            }
        })
    });
    // 店铺轮播图接口
    app.get('/shops/swiper', function (req, res) {
        let sId = req.query.shopId
        let sql = `SELECT * FROM t_shops WHERE shop_id=${sId}`
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '连接成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '连接失败';
                res.send(result);
            }
        })
    });
    // 关注店铺，粉丝数增加    取消关注，粉丝数减少
    app.get('/add/shops/person', function (req, res, next) {
        let sId = req.query.shopId;
        let num = req.query.shopPerson;
        let sql = `UPDATE t_shops SET s_person=${num} WHERE shop_id=${sId}`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '店铺粉丝数增加成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '店铺粉丝数增加失败';
                res.send(result)
            }
        })
    })
    // 我的购物车
    app.get('/shopping/car', function (req, res) {
        let id = req.query.userId
        let sql = `SELECT * FROM t_shopping_car WHERE user_id=${id}`
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '连接成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '连接失败';
                res.send(result);
            }
        })
    });
    // 添加购物车
    app.get('/add/shopping/car', function (req, res) {
        let uId = req.query.userId;
        let gId = req.query.goodId;
        let sId = req.query.shopId;
        let sName = req.query.shopName;
        let gName = req.query.goodName;
        let gI = req.query.goodIntroduce;
        let gSrc = req.query.goodSrc;
        let gP = req.query.goodPrice;
        let num = req.query.scNum;
        let sql = `INSERT INTO t_shopping_car(user_id,g_id,shop_id,s_name,g_name,g_introduce,g_src,g_price,sc_num) VALUES (${uId},${gId},${sId},"${sName}","${gName}","${gI}","${gSrc}","${gP}",${num})`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '添加购物车成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '添加购物车失败';
                res.send(result)
            }
        })
    });
    // 删除购物车
    app.get('/del/shopping/car', function (req, res, next) {
        let id = req.query.scId;
        let sql = `delete from t_shopping_car where sc_id=${id}`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '删除购物车成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '删除购物车失败';
                res.send(result)
            }
        })
    });
    // 发现
    app.get('/find', function (req, res) {
        let sql = `SELECT * FROM t_find`
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '查询成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '查询失败';
                res.send(result);
            }
        })
    });
    // 消息
    app.get('/find/info', function (req, res) {
        let id = req.query.userId;
        let sql = `SELECT * FROM t_find_info where user_id=${id}`
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '查询成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '查询失败';
                res.send(result);
            }
        })
    });
    // 清除未读消息
    app.get('/del/find/info', function (req, res, next) {
        let id = req.query.fiId;
        let status = req.query.fiStatus;
        let num = req.query.fiPerson;
        let time = req.query.fiSTime;
        let sql = `UPDATE t_find_info SET fi_status='${status}',fi_person=${num},fi_s_time='${time}' WHERE fi_id=${id}`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '清除成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '清除失败';
                res.send(result)
            }
        })
    });
    // 清空我的浏览
    app.get('/del/find/info/all', function (req, res, next) {
        let id = req.query.fiId;
        let sql = `delete from t_find_info where fi_id=${id}`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '我的浏览删除成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '我的浏览删除失败';
                res.send(result)
            }
        })
    });
    // 评论
    app.get('/find/commentary', function (req, res) {
        let sql = `SELECT * FROM t_commentary`
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '查询成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '查询失败';
                res.send(result);
            }
        })
    });
    // 管理员工具箱
    app.get('/admin/tool', function (req, res) {
        let sql = 'SELECT * FROM t_admin_tool'
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '连接成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '连接失败';
                res.send(result);
            }
        })
    });
    // 下架商品
    app.get('/del/goods', function (req, res, next) {
        let id = req.query.goodsId;
        let sql = `delete from t_goods where g_id=${id}`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '商品下架成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '商品下架失败';
                res.send(result)
            }
        })
    });
    // 上架商品
    app.get('/add/goods', function (req, res, next) {
        let id = req.query.classId;
        let cid = req.query.CId;
        let sid = req.query.shopId;
        let cname = req.query.className;
        let name = req.query.goodsName;
        let introduce = req.query.goodsIntroduce;
        let src = req.query.goodsSrc;
        let price = req.query.goodsPrice;
        let discount = req.query.goodsDiscount;
        let integral = req.query.goodsIntegral;
        let num = req.query.goodsNum;
        let gnum = req.query.goodsBuyNum;
        let sql = `INSERT INTO t_goods(class_id,c_id,shop_id,class_name,g_name,g_introduce,g_src,g_price,g_discount,g_integral,g_num,g_buy_num) VALUES (${id},${cid},${sid},"${cname}","${name}","${introduce}","${src}","${price}","${discount}",${integral},${num},${gnum})`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '商品上架成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '商品上架失败';
                res.send(result)
            }
        })
    });
    // 编辑商品
    app.get('/edit/goods', function (req, res, next) {
        let id = req.query.goodsId;
        let name = req.query.goodsName;
        let introduce = req.query.goodsIntroduce;
        let src = req.query.goodsSrc;
        let price = req.query.goodsPrice;
        let discount = req.query.goodsDiscount;
        let integral = req.query.goodsIntegral;
        let num = req.query.goodsNum;
        let sql = `UPDATE t_goods SET g_name='${name}',g_introduce='${introduce}',g_src='${src}',g_price='${price}',g_discount='${discount}',g_integral='${integral}',g_num='${num}' WHERE g_id=${id} `;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '商品信息更新成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '商品信息更新失败';
                res.send(result)
            }
        })
    });
    // 删除店铺
    app.get('/del/shops', function (req, res, next) {
        let id = req.query.shopsId;
        let sql = `delete from t_shops where shop_id=${id}`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '删除店铺成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '删除店铺失败';
                res.send(result)
            }
        })
    });
    // 添加店铺
    app.get('/add/shops', function (req, res, next) {
        let name = req.query.shopsName;
        let icon = req.query.shopsIcon;
        let phone = req.query.shopsPhone;
        let address = req.query.shopsAddress;
        let time = req.query.shopsTime;
        let bg = req.query.shopsBg;
        let introduce = req.query.shopsIntroduce;
        let run = req.query.shopsRun;
        let title = req.query.shopsTitle;
        let sql = `INSERT INTO t_shops(s_name,s_icon,s_phone,s_address,s_time,s_bg,s_introduce,s_run,s_title) VALUES ("${name}","${icon}","${phone}","${address}","${time}","${bg}","${introduce}","${run}","${title}")`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '添加店铺成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '添加店铺失败';
                res.send(result)
            }
        })
    });
    // 编辑店铺
    app.get('/edit/shops', function (req, res, next) {
        let id = req.query.shopsId;
        let name = req.query.shopsName;
        let icon = req.query.shopsIcon;
        let phone = req.query.shopsPhone;
        let address = req.query.shopsAddress;
        let time = req.query.shopsTime;
        let bg = req.query.shopsBg;
        let introduce = req.query.shopsIntroduce;
        let run = req.query.shopsRun;
        let title = req.query.shopsTitle;
        let sql = `UPDATE t_shops SET s_name='${name}',s_icon='${icon}',s_phone='${phone}',s_address='${address}',s_time='${time}',s_bg='${bg}',s_introduce='${introduce}',s_run='${run}',s_title='${title}' WHERE shop_id=${id} `;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '店铺信息更新成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '店铺信息更新失败';
                res.send(result)
            }
        })
    });
    // 管理员查看发现
    app.get('/admin/find/info', function (req, res) {
        let sql = `SELECT * FROM t_find_info`
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '查询成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '查询失败';
                res.send(result);
            }
        })
    });
    // 删除发现
    app.get('/admin/del/find/info', function (req, res, next) {
        let id = req.query.findId;
        let sql = `delete from t_find_info where fi_id=${id}`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '删除发现成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '删除发现失败';
                res.send(result)
            }
        })
    });
    // 新增发现
    app.get('/admin/add/find/info', function (req, res, next) {
        let id = req.query.userId;
        let fid = req.query.fiId;
        let name = req.query.fiName;
        let srca = req.query.fiSrca;
        let srcb = req.query.fiSrcb;
        let srcc = req.query.fiSrcc;
        let time = req.query.fiTime;
        let status = req.query.fiStatus;
        let type = req.query.fiType;
        let content = req.query.fiContent;
        let person = req.query.fiPerson;
        let sql = `INSERT INTO t_find_info(find_id,user_id,fi_name,fi_src,fi_srcb,fi_srcc,fi_s_time,fi_status,fi_type,fi_content,fi_person) VALUES (${fid},${id},"${name}","${srca}","${srcb}","${srcc}","${time}","${status}","${type}","${content}",${person})`;
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.data = '新增发现成功';
                res.send(result);
            } else {
                let result = error;
                result.data = '新增发现失败';
                res.send(result)
            }
        })
    });
    // 所有订单
    app.get('/admin/order', function (req, res) {
        let sql = `SELECT * FROM t_order`
        db.connection(sql, [], function (err, data) {
            if (data) {
                let result = success;
                result.msg = '查询成功';
                result.data = data;
                res.send(result);
            } else {
                let result = error;
                result.msg = '查询失败';
                res.send(result);
            }
        })
    });

    return app
}