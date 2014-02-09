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

List active queues: ```sudo rabbitmqctl list_queues```