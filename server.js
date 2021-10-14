const http = require("http");
const server = http.createServer((req, res) => {
});

// socketioの準備
const io = require('socket.io')(server);

// クライアント接続時の処理
io.on('connection', (socket) => {
    console.log("client connected!!")

    // クライアント切断時の処理
    socket.on('disconnect', () => {
        console.log("client disconnected!!")
    });

    socket.on("changeSlider", (obj) => {
        console.log(obj)
        const value = obj[0]
        console.log(typeof value)
        if (typeof value === "number") {
            io.sockets.emit("changeSlider", obj[0])
        }        
    })
});

server.listen(8080);
