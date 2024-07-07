# app/controllers/time_messages_controller.rb
class TimeMessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user
  before_action :set_time_message, only: %i[ show edit update destroy ]

  # GET /users/:email/time_messages
  def index
    @time_messages = @user.time_messages.where("date_to_open <= ?", Date.today)
    render json: @time_messages
  end

  # GET /users/:email/time_messages/:id
  def show
    @time_message = TimeMessage.find(params[:id])
    render json: @time_message
  end

  # POST /users/:email/time_messages
  def create
    @time_message = TimeMessage.new(time_message_params)
    @time_message.date_to_open = Date.parse(time_message_params[:date_to_open])

    if @time_message.save
      render json: @time_message, status: :created
    else
      render json: @time_message.errors, status: :unprocessable_entity
    end
  end

  # PUT /users/:email/time_messages/:id
  def update
    if @time_message.update(time_message_params)
      render json: @time_message, status: :ok
    else
      render json: @time_message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/:email/time_messages/:id
  def destroy
    @time_message.destroy!
    render json: @time_message
  end

  private
  def set_user
    Rails.logger.info "Params received: #{params.inspect}"
    @user = User.find_by(email: params[:user_email])
    unless @user
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def set_time_message
    @time_message = @user.time_messages.find(params[:id])
  end

  def time_message_params
    params.require(:time_message).permit(:content, :date_to_open).merge(user_email: params[:user_email])
  end  
end
