  class ChatsController < ApplicationController
    before_action :set_chat, only: %i[ show ]

    # GET /chats
    def index
      @chats = Chat.where(:application_token => params[:application_id])
    end

    # GET /chats/1
    def show
    end

    # POST /chats
    def create
      @chat_number = 0
      @last_chat = Chat.where(:application_token => params[:application_id]).order("created_at").last
      if @last_chat
        @chat_number = @last_chat.chat_number+1
      end

      @body = {title:params[:title],application_token:params[:application_id],chat_number:@chat_number,messages_count:0}
      
      Publisher.publish({operation:"save_chat",body:@body});
      render json: {"chat_number":@chat_number}, status: :created
    end

    # PATCH/PUT /chats/1
    def update
      @class_params = {application_token:params[:application_id],chat_number:params[:id],title:params[:title]}
      Publisher.publish({operation:"update_chat",body:@class_params});
      render status: :ok, json: {status: "chat updated"}
    end

      def set_chat
        @chat = Chat.find_by!(application_token:params[:application_id],chat_number:params[:id])
      end
  end
