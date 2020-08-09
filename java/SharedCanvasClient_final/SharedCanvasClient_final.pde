/**
 * Shared Drawing Canvas (Client) 
 * by Alexander R. Galloway. 
 * using java net lib : Sinbrive 2020 
 */
import java.net.*;
import java.io.*;

Socket client = null; 
DataInputStream in = null;  // or BufferedReader in
DataOutputStream out = null; // or PrintWriter out

String input;
int data[];
int PORT = 12345;
String IP="127.0.0.1";


void setup() 
{
  size(450, 255);
  background(204);
  stroke(0);
  frameRate(10); // Slow it down a little
  // Connect to the server's IP address and port
  try
  { 
    client = new Socket(IP, PORT); 

    println("Connected"); 

    //client.setSoTimeout(0);

    in = new DataInputStream( 
      new BufferedInputStream(client.getInputStream())); 

    // sends output to the socket 
    out    = new DataOutputStream(client.getOutputStream());

  } 
  catch(IOException e) 
  { 
    System.out.println(e);
  }
}

void draw() 
{
  try {

    if (mousePressed==true) {
      // Draw our line
      stroke(255);
      line(pmouseX, pmouseY, mouseX, mouseY);
      // Send mouse coords to other person
      String s=pmouseX + " " + pmouseY + " " + mouseX + " " + mouseY + "\n";
      out.writeUTF(s); // .getBytes()
    }
    // Receive data from server
    if (in.available()>0) {
      input = in.readUTF(); 
      println(input);
      input = input.substring(0, input.indexOf("\n")); // Only up to the newline
      data = int(split(input, ' ')); // Split values into an array
      // Draw line using received coords
      stroke(0);
      line(data[0], data[1], data[2], data[3]);
    }
  } 
  catch(IOException e) 
  { 
    println(e.getMessage());
  }
}
