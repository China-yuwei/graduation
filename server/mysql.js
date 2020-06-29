var mysql = require('mysql');
module.exports = {
    config: {
        host: 'localhost',
        user: 'root',
        password: 'root',
        port: '3306',
        database: 'tea',
    },
    connection: function (sql, sqlArr, callback) {
        var pool = mysql.createPool(this.config);
        pool.getConnection(function (err, connect) {
            if (err) {
                console.log(err);
                return err;
            }
            //查询
            connect.query(sql, sqlArr, callback);
            console.log("数据库连接成功");
            connect.release(); //返回连接池
        })
    }
}