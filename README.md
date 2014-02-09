##Learning about message queuing architecture.

###Resources
* [Queue based system architecture](http://www.amazon.com/gp/product/B00HNG8ZFQ/ref=kinw_myk_ro_title)
* [RabbitMQ in Action: Distributed messaging for everyone](http://manning.com/videla/)
* [RabbitMQ.com](http://www.rabbitmq.com/tutorials/tutorial-one-ruby.html)
* [Installation](http://www.rabbitmq.com/install-debian.html)

###RabbitMQ is a message broker.
* A program that sends messages is a **producer**.
* A **queue** is the name for a mailbox.
* A **consumer** is a program that mostly waits to receive messages.

###Features
* High reliability at cost of performance: persistence, delivery acknowledgment (ACK), publisher confirms, high availability
* RabbitMQ supports message acknowledgments. An ack(nowledgement) is sent back from the consumer to tell RabbitMQ that a particular message has been received, processed and that RabbitMQ is free to delete it
* RabbitMQ doesn't allow you to redefine an existing queue with different parameters

###Useful Commands
* list active queues: ```sudo rabbitmqctl list_queues```
* list queues along with unacknowledged messages: ```sudo rabbitmqctl list_queues name messages_ready messages_unacknowledged```

###Enable message acknowledgement
```q.subscribe(:ack => true, :block => true) do...```

###Enable queue persistence for message durability
When RabbitMQ quits or crashes it will forget the queues and messages unless you tell it not to. Two things are required to make sure that messages aren't lost: we need to mark both the queue and messages as durable.

1. Mark the queue as durable
```ch.queue("hello", :durable => true)```
2. Mark the message as durable
```x.publish(msg, :persistent => true)```

Queue durability can only really be ensured if the publishing code is wrapped in a **transaction**.

###Lets be fair
By default, RabbitMQ will dispatch messages equitably to all workers, and will not check first to see if the worker is already busy. You can ask RabbitMQ to only send messages to a worker if it is available to process a message.

Use prefetch() to prevent dispatching a new message to a worker until it has processed and acknowledged the previous one. Instead, RabbitMQ will dispatch it to the next worker that is not still busy.
```
n = 1;
channel.prefetch(n);
```

One possible ramification of prefetching is that the queue can become backed up if all workers are busy with long processes.