class ConnectionTokensController < ApplicationController
  before_action :set_connection_token, only: [:show, :edit, :update, :destroy]

  # GET /connection_tokens
  # GET /connection_tokens.json
  def index
    @connection_tokens = ConnectionToken.all
  end

  # GET /connection_tokens/1
  # GET /connection_tokens/1.json
  def show
    @connection_token 
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
  def new
    @connection_token = ConnectionToken.new({user: current_user})

    respond_to do |format|
      if @connection_token.save
        format.html { redirect_to connections_path, notice: 'Connection was successfully created.' }
        # format.json { render :show, status: :created, location: @connection_token }
      else
        format.html { redirect_to connections_path, notice: 'failed.' }
        # format.html { render :new }
        # format.json { render json: @connection_token.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /connection_tokens/1
  # PATCH/PUT /connection_tokens/1.json
  def update
    respond_to do |format|
      if @connection_token.update(connection_token_params)
        format.html { redirect_to @connection, notice: 'Connection was successfully updated.' }
        format.json { render :show, status: :ok, location: @connection_token }
      else
        format.html { render :edit }
        format.json { render json: @connection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /connection_tokens/1
  # DELETE /connection_tokens/1.json
  def destroy
    @connection_token.destroy
    respond_to do |format|
      format.html { redirect_to connections_path, notice: 'Connection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_connection_token
      p "*"*100
      p params[:id]
      @connection_token = ConnectionToken.find_by(token: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def connection_token_params
      params.require(:connection_token).permit(:token)
    end
end
