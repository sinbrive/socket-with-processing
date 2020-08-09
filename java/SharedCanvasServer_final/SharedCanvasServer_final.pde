/**
 * Shared Drawing Canvas (Server) 
 * by Alexander R. Galloway. 
 * using java net lib : Sinbrive 2020 
 */

import java.net.*;
import java.io.*;

Socket socket   = null; 
ServerSocket server = null; 
DataInputStream in = null;  //  BufferedReader in
DataOutputStream out = null; //  PrintWriter out
int PORT = 12345;

String input;
int data[];

void setup() {
  size(450, 255);
  background(204);
  stroke(0);
  frameRate(10); // Slow it down a little
  try { 
    server = new ServerSocket(PORT); 
    println("Server started");

    println("Waiting for a client ..."); 

    socket = server.accept(); 
    println("Client accepted"); 
 
    in = new DataInputStream( 
      new BufferedInputStream(socket.getInputStream()));

    // sends output to the socket 
    out = new DataOutputStream(socket.getOutputStream());

}
  catch (IOException e) { 
    println(e);
  }
}

void draw() {
  try {
    if ( mousePressed==true) {
      // Draw our line
      stroke(255);
      line(pmouseX, pmouseY, mouseX, mouseY);
      // Send mouse coords to other person
      String s=pmouseX + " " + pmouseY + " " + mouseX + " " + mouseY + "\n";
      out.writeUTF(s);
      out.flush();
    }
    // Receive data from client
    if (in.available()>0) {
      input = in.readUTF(); 
      input = input.substring(0, input.indexOf("\n")); // Only up to the newline
      println(input);    
      data = int(split(input, ' ')); // Split values into an array
      // Draw line using received coords
      stroke(0);
      line(data[0], data[1], data[2], data[3]);
    }
  } 
  catch(IOException e) { 
    println(e);
  }
}
