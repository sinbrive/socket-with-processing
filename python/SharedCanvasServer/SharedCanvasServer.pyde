'''
 * Shared Drawing Canvas (Server) 
 * by Alexander R. Galloway. 
 * Processingpy version : Jonathan Feinberg
 *  Python mode with socket lib : Sinbrive 2020 
'''

import socket

sData=None

s=None

def setup():
    size(450, 255)
    background(204)
    stroke(0)
    frameRate(5)  # Slow it down a little
    initServer()  # Start a simple server on a port

def draw():
    global sData
    if mousePressed == True:
        # Draw our line
        stroke(255)
        line(pmouseX, pmouseY, mouseX, mouseY)
        # Send mouse coords to other person
        sData.send(str(pmouseX) + ";" +
            str(pmouseY) + ";" +
            str(mouseX) + ";" +
            str(mouseY)+ "\n")
    # Receive data from client    
    try:
        input = sData.recv(1024)
    except socket.error, e:
        pass
    else :     
        input = input[:input.find("\n")]  # Only up to the newline
        data = [int(coord)
                for coord in input.split(";")]  # Split values into list
        # Draw line using received coords
        # println(data)
        stroke(0)
        line(data[0], data[1], data[2], data[3])
        
    
def initServer():
    global sData        
    HOST = ''   
    PORT = 12345             
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.bind((HOST, PORT))
    s.listen(1)         
    sData, senderAddress = s.accept()
    println (str(senderAddress[0])+","+ str(senderAddress[1]))
    sData.setblocking(0)  # make it non-blocking

def keyPressed():
    global sData, s
    if key=='r':
        sData.close()
        s.close()
        println("closed")
        exit()
        

    
