class JobsWorker
    include Sneakers::Worker
    from_queue "jobs"
  
    def work(job)
     @parsed_job = JSON.parse(job)
     
     @operation = @parsed_job["operation"] 
     body       = @parsed_job["body"]

     if @operation == "save_app"
          save_app(body)
     elsif @operation == "update_app"
          update_app(body)
     elsif(@operation == "save_chat")
          save_chat(body)
    elsif(@operation == "update_chat")
          update_chat(body)
    elsif(@operation == "save_message")
          save_message(body)
    elsif(@operation == "update_message")
          update_message(body)
    end
      

      logger.info("Recieved the following job: #{job}")
      ack!
    end  


    def save_app(body)
      @application = Application.new(body)
      @application.save
    end

    def update_app(body)
      Application.find_by!(token:body["token"]).update(name: body["name"])
    end

    def save_chat(body)
      @application = Application.find_by!(token:body["application_token"])
      @application.update_attribute(:chats_count,@application.chats_count+1)
      body["applications_id"] = @application.id
      @chat = Chat.new(body)
      @chat.save
    end

    def update_chat(body)
      Chat.find_by!(application_token:body["application_token"],chat_number:body["chat_number"]).update_attribute(:title,body["title"])
    end

    def save_message(body)
      @chat = Chat.find_by!(application_token:body["application_token"],chat_number:body["message_chat_number"]).update_attribute(:messages_count,body["messages_count"])
      @message = Message.new(message: body["message"],message_chat_number:body["message_chat_number"], message_number:body["message_number"],chats_id:body["chat_id"])
      @message.save
    end

    def update_message(body)
      @chat = Chat.find_by!(application_token:body["application_token"],chat_number:body["chat_number"])
      @message = Message.find_by!(chats_id:@chat.id,message_number:body["message_number"]).update_attribute(:message,body["message"])
    end

  end
  