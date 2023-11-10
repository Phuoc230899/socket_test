const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
const { Server } = require("socket.io");
const io = new Server(server);
const messages = []


io.on('connection', (socket) => {
  // const username = socket.handshake.query.username
  // const room = socket.handshake.query.room

  socket.on('message', (data) => {
    const message = {
      message: data.message,
      senderUsername: data.sender,
      sentAt: Date.now()
    }
    messages.push(message)
    io.sockets.emit("msg",message);
    io.to(data.roomID).emit('message', message)

  })

  socket.on('subscribe',function(room){  
    try{
      console.log('[socket]','join room :',room)
      socket.join(room);
      socket.to(room).emit('user joined', socket.id);
    }catch(e){
      console.log('[error]','join room :',e);
      socket.emit('error','couldnt perform requested action');
    }
  })

  socket.on('unsubscribe',function(room){  
    try{
      console.log('[socket]','leave room :', room);
      socket.leave(room);
      socket.to(room).emit('user left', socket.id);
    }catch(e){
      console.log('[error]','leave room :', e);
      socket.emit('error','couldnt perform requested action');
    }
  })
});





server.listen(3000, () => {
  console.log('listening on *:3000');
});