require 'securerandom'

class ApplicationsController < ApplicationController
  before_action :set_application, only: %i[ show update]

  # GET /applications
  def index
    # @applications =  $redis.get("applications")
    #   if @applications.present?
    #     @applications = Application.all
    #     $redis.set("applications", @applications)
    #   end
    @applications = Application.all
  end
  # GET /applications/1
  def show
  end

  # POST /applications
  def create
    token = SecureRandom.hex
    @class_params = {name:params[:name], token:token,chats_count:0}
    Publisher.publish({operation:"save_app",body:@class_params});
    render json: { token: token }, status: :created
  end

  # PATCH/PUT /applications/1
  def update
    @class_params = {token:params[:id],name:params[:name]}
    Publisher.publish({operation:"update_app",body:@class_params});
    render status: :created, json: {application: "updated"}
  end

  private
    def set_application
      @application = Application.find_by!(token:params[:id])
    end
end
