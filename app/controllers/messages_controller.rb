class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show update ]

  # GET /messages
  def index
    @chat     = Chat.find_by!(:chat_number => params[:chat_id],:application_token => params[:application_id])
    @messages = Message.where(:chats_id => @chat.id)

    if params[:message].present?
      render status: :ok, json: {messages:  @messages.search(params[:message]) }
    else
     @messages
    end
  end

  # GET /messages/1
  def show
  end

  # POST /messages  
  def create
    @message_number = 0
    @chat = Chat.where(:chat_number => params[:chat_id],:application_token => params[:application_id]).order("created_at").last
    @last_message = Message.where(:chats_id => @chat.id).order("created_at").last
    if @last_message
      @message_number = @last_message.message_number+1
    end

    @body = {
              message_chat_number:params[:chat_id],
              chat_id:@chat.id,
              application_token:params[:application_id],
              messages_count:@chat.messages_count+1,
              message: params[:message],
              message_number:@message_number
            }
  
    Publisher.publish({operation:"save_message",body:@body});
    render json: {"message_number":@message_number}, status: :created
  end

  # PATCH/PUT /messages/1
  def update
    @body = {application_token:params[:application_id],chat_number:params[:chat_id],message_number:params[:id],message:params[:message]}
    
    Publisher.publish({operation:"update_message",body:@body});
    render status: :ok, json: {status: "message updated"}
  end

  private
    def set_message
      @chat    = Chat.find_by!(:chat_number => params[:chat_id],:application_token => params[:application_id])
      @message = Message.find_by!(:chats_id => @chat.id,:message_number => params[:id])
    end

    def message_params
      params.require(:message).permit(:chat_number, :message, :message_number)
    end
end
