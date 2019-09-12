class ConnectionTokensController < ApplicationController
  before_action :set_connection_token, only: [:show, :edit, :update, :update_expiration, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /connection_tokens
  # GET /connection_tokens.json
  def index
    @connection_tokens = ConnectionToken.all
  end

  # GET /connection_tokens/1
  # GET /connection_tokens/1.json
  def show
    @connection_token
    @existing_connection = Connection.find_by(requester_id: current_user.id, requestee_id: @connection_token.user_id) && Connection.find_by(requester_id: current_user.id, requestee_id: @connection_token.user_id)
    @existing_request = ConnectionRequest.find_by(requester_id: current_user.id, requestee_id: @connection_token.user_id)
    @incoming_request = ConnectionRequest.find_by(requestee_id: current_user.id, requester_id: @connection_token.user_id)

    @connection_request = ConnectionRequest.new
    @connection = Connection.new
  end

  # # GET /connection_tokens/new
  # def new
  #   # @connection_token = ConnectionToken.new
  #   create
  # end

  # GET /connection_tokens/1/edit
  def edit
  end

  # POST /connection_tokens
  # POST /connection_tokens.json
  def create
    @connection_token_params = params[:connection_token]

    @connection_token = ConnectionToken.new({user: current_user, name: @connection_token_params[:name]})

    respond_to do |format|
      if @connection_token.save
        # format.html { redirect_to connections_path, notice: 'Connection was successfully created.' }
        format.json { render json: @connection_token }
      else
        # format.html { redirect_to connections_path, notice: 'failed.' }
        format.json { render json: @connection_token.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_expiration
    if (params[:activate] == true)
      @connection_token.reactivate
    else
      @connection_token.deactivate
    end
    respond_to do |format|
      if @connection_token.save
        # TODO: this
        @connection_token_json = @connection_token.as_json
        @connection_token_json[:expired] = @connection_token.expired?
        format.json { render json: @connection_token_json, status: :ok }
      else
        format.json { render json: @connection_token.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /connection_tokens/1
  # PATCH/PUT /connection_tokens/1.json
  def update
    respond_to do |format|
      if @connection_token.update(connection_token_params)
        format.json { render json: @connection_token, status: :ok }
        format.html { redirect_to @connection_token, notice: 'Connection token was successfully updated.' }
      else
        format.json { render json: @connection_token.errors, status: :unprocessable_entity }
        format.html { render :edit }
      end
    end
  end

  # DELETE /connection_tokens/1
  # DELETE /connection_tokens/1.json
  def destroy
    @connection_token.destroy
    respond_to do |format|
      # format.html { redirect_to connections_path, notice: 'Connection was successfully destroyed.' }
      format.json { render json: @connection_token }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_connection_token
      @connection_token = ConnectionToken.find_by(token: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def connection_token_params
      params.require(:connection_token).permit(:token, :name, :expires_at, :activate)
    end
end
