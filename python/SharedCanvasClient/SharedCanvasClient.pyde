'''
 * Shared Drawing Canvas (Client) 
 * by Alexander R. Galloway. 
 * Processingpy version : Jonathan Feinberg
 *  Python mode with socket lib : Sinbrive 2020 
'''

import socket

s=None

def setup():
    global c
    size(450, 255)
    background(204)
    stroke(0)
    frameRate(5)  # Slow it down a little
    # Connect to the server's IP address and port
    initClient()

def draw():
    global s
    if mousePressed == True:
        # Draw our line
        stroke(255)
        line(pmouseX, pmouseY, mouseX, mouseY)
        # Send mouse coords to other person
        s.send(str(pmouseX) + ";" +
            str(pmouseY) + ";" +
            str(mouseX) + ";" +
            str(mouseY)+ "\n")
        
    # Receive data from server
    try:
        input = s.recv(1024)
    except socket.error, e:
        pass
    else :
        input = input[:input.find("\n")]  # Only up to the newline
        data = [int(coord)
                for coord in input.split(";")]  # Split values into list
        # Draw line using received coords
        stroke(0)
        line(data[0], data[1], data[2], data[3])
                
def initClient():
    global s
    HOST = 'localhost' 
    PORT = 12345
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM) # socket.AF_INET, socket.SOCK_STREAM
    s.connect((HOST,PORT))
    s.setblocking(0)  # make it non-blocking


def keyPressed():
    global s
    if key=='r':
        s.close()
        println("closed")
        exit()
