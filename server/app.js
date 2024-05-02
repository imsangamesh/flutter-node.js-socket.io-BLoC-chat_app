const express = require("express");
const { createServer } = require("http");
const { Server } = require("socket.io");

const app = express();
const httpServer = createServer(app);
const io = new Server(httpServer);

io.on("connection", (socket) => {
  socket.join("anonymous_chat_room"); // joining all clients
  console.log("Backend connected");

  // listening on `message_event`
  socket.on("chat_room", (data) => {
    console.log(data);
    io.to("anonymous_chat_room").emit("chat_room", data);
  });
});

io.on("disconnect", (socket) => {
  console.log("Backend disconnected");
});

httpServer.listen(3000);
