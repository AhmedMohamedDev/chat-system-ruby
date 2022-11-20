### Disclaimer

``` This is my first time to use Ruby,Docker,ElasticSearch,Redis,RabbitMQ So excuse me if it's not perfect ``` **😅**

### Run
`docker-compose up`

### DataBase Structure
**type:** MYSQL
**RelationShips**
  - Applications Has Many Chats
  - Chat Has Many Messages
 
 **indices**
  - application_token
  - chat_number
  - message_number
  
### RabitMq

``RabbitMQ is a message broker: it accepts and forwards messages. You can think about it as a post office: when you put the mail that you want posting in a post box, you can be sure that the letter carrier will eventually deliver the mail to your recipient. In this analogy, RabbitMQ is a post box, a post office, and a letter carrier,
The queue system make sure to priortize and getting the task done which make it very effective for scalability.

- Producer sends messages to the "hello" queue. The consumer receives messages from that queue.
- We use Our JobWorker For dealing with our queue system, alon with using sneakers gem
``

![python-one-overall](https://user-images.githubusercontent.com/54902463/202885762-d4a1160c-7eee-4873-baa8-5c7a4170803c.png)

- In our code this is the job of **JobWorker**


### ElasticSearch

`` Elasticsearch is an opensource JSON-based search engine that allows us to search indexed data quickly and with options that are not provided by classic data stores.``

- In our message Model we indexed our data so we can searh within specific chat messages

### Redis
- Redis is an in-memory data structure store, used as a distributed, in-memory key–value database, cache and message broker, with optional durability.
**I could have used redis for showing data if it's indexed and update the key using after_save method, Unfortunately I faced a little bug and I didn't have the time to do it but here is my methodology any way :**
``` 
@applications =  $redis.get("applications")
if @applications.present?
  @applications = Application.all
 $redis.set("applications", @applications)
end
```
