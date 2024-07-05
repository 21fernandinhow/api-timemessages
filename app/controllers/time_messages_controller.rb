class TimeMessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user
  before_action :set_time_message, only: %i[ show edit update destroy ]

  # GET /time_messages or /time_messages.json
  def index
    Rails.logger.info "Params received: #{params.inspect}"
    @time_messages = @user.time_messages.where("date_to_open <= ?", Date.today)
    render json: @time_messages
  end

  # GET /time_messages/1 or /time_messages/1.json
  def show
    @time_message = TimeMessage.find(params[:id])
    render json: @time_message
  end

  # GET /time_messages/new
  def new
    @time_message = TimeMessage.new
  end

  # GET /time_messages/1/edit
  def edit
  end

  # POST /time_messages or /time_messages.json
  def create
    @time_message = TimeMessage.new(time_message_params)
    @time_message.date_to_open = Date.parse(time_message_params[:date_to_open])

    if @time_message.save
      render json: @time_message, status: :created
    else
      render json: @time_message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /time_messages/1 or /time_messages/1.json
  def update
    if @time_message.update(time_message_params)
      render json: @time_message, status: :ok
    else
      render json: @time_message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /time_messages/1 or /time_messages/1.json
  def destroy
    @time_message.destroy!
    render json: @time_message
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_time_message
      @time_message = @user.time_messages.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def time_message_params
      params.require(:time_message).permit(:content, :date_to_open).merge(user_id: params[:user_id])
    end
end
