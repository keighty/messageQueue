#Basic queue

###Sending a message
1. open the socket connection (specify a hostname if sending to a different machine: ``` conn = Bunny.new(:hostname => "ip address of host")```)
2. create a channel
3. declare a queue (idempotent -- it will only be created if it doesn't exist already)
4. publish a message to the queue
5. close the connection

###Receiving a message
The receiver side of the socket remains open until explicitly closed.

1. open a socket connection
2. create a channel
3. declare the queue from which you will take messages (should be the same as the sender)
4. provide a callback that will be executed when messages are pushed to the consumer (asynchronous) (blocks the calling thread from exiting)

The consumer will remain open until it receives an exit signal (include ```delivery_info.consumer.cancel``` in the block to exit after receiving a message)
