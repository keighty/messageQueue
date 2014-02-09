#Publish/Subscribe

The simplistic queue model has producers publishing messages to a queue and consumers taking messages off a queue.

In the publish/subscribe model, the producer sends messages to an **exchange**, who's only job is to publish messages to queues. In this scenario, the exchange knows to which queue(s) the message should be published according to established rules.

###Types of exchanges
1. **direct**
2. **topic**
3. **headers**
4. **fanout** - broadcasts every message it receives to all the queues it knows

###Exclusive
Create a non-durable queue that will be deleted when the connection is closed:

```
q = ch.queue("", :exclusive => true)
```

###Binding
The relationship between an exchange and a queue is called a **binding**.

###In action
Start three terminals:

1. ```$ ruby -rubygems receive_logs.rb > logs_from_rabbit.log```
2. ```$ ruby -rubygems receive_logs.rb```
3. ```$ ruby -rubygems emit_log.rb```

In the last terminal, add a few more messages:

```
$ ruby -rubygems emit_log.rb this is a longer message
$ ruby -rubygems emit_log.rb this message should be logged in a file AND appear in my terminal window
```

The output in terminal 2:

```
$ ruby -rubygems receive_logs.rb
 [*] Waiting for logs. To exit press CTRL+C
 [x] Hello World!
 [x] this is a longer message
 [x] this message should be logged in a file AND appear in my terminal
```

The output from the log file:

```
$ cat logs_from_rabbit.log
 [*] Waiting for logs. To exit press CTRL+C
 [x] Hello World!
 [x] this is a longer message
 [x] this message should be logged in a file AND appear in my terminal
```