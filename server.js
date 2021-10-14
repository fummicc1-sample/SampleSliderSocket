const http = require("http");
const server = http.createServer();

// socketioの準備
const io = require('socket.io')(server);

// クライアント接続時の処理
io.on('connection', (socket) => {
    console.log("client connected!!")

    // クライアント切断時の処理
    socket.on('disconnect', () => {
        console.log("client disconnected!!")
    });

    socket.on("sliderValue", (obj) => {
        console.log(obj)
        socket.broadcast.emit("sliderValue", obj)
    })
});

server.listen(3000);
