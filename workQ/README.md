#Work Q
A **work queue** distributes time-consuming tasks among multiple workers. Aka a "Task Queue", it is used to avoid doing a resource-intensive task immediately and having to wait for it to complete. This is particularly useful for web tasks that may take longer than the typical HTTP request.

* encapsulate a task as a message and push it to a queue
* an available worker (from a pool of possible workers) pops the task and executes the job

###Create a worker that simulates a long task
Use a "sleep method":
```
# imitate some work
sleep body.count(".").to_i
```

###Create a task that takes a command line argument
```
msg  = ARGV.empty? ? "Hello World!" : ARGV.join(" ")
q.publish(msg, :persistent => true)
puts " [x] Published #{msg}"
```

#Many hands make light work
Start three terminals:

1. start a worker process ```ruby -rubygems worker.rb```
2. start a worker process ```ruby -rubygems worker.rb```
3. run new_task.rb with varying numbers of '.':

```
shell3$ ruby -rubygems new_task.rb First message.
shell3$ ruby -rubygems new_task.rb Second message..
shell3$ ruby -rubygems new_task.rb Third message...
shell3$ ruby -rubygems new_task.rb Fourth message....
shell3$ ruby -rubygems new_task.rb Fifth message.....
```

Check the output in the other two terminals:

```bash
$ ruby -rubygems worker.rb
 [x] Received First message.
 [x] Done
 [x] Received Third message...
 [x] Done
 [x] Received Fifth message.....
 [x] Done
```

```bash
$ ruby -rubygems worker.rb
[x] Received Second message..
[x] Done
[x] Received Fourth message....
[x] Done
```

Message acknowledgments are turned off by default. Turn them on using ```:manual_ack => true```