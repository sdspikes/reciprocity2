class ConnectionsController < ApplicationController
  before_action :set_connection, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /connections
  # GET /connections.json
  def index
    original_connection_tokens = current_user.connection_tokens
    @connection_tokens = original_connection_tokens.as_json.map.with_index do |token, i|
      token[:expired] = original_connection_tokens[i].expired?
      token
    end
    @connection_people = current_user.connection_people
    @request_people = current_user.requesters
    @incoming_requests = current_user.incoming_connection_requests
    @outgoing_connections = current_user.outgoing_connections
    @incoming_connections = current_user.incoming_connections
  end

  def token
    respond_to do |format|
      format.html { redirect_to connections_path, notice: 'hi.' }
    end
  end

  # GET /connections/1
  # GET /connections/1.json
  def show
  end

  # GET /connections/new
  def new
    @connection = Connection.new
  end

  # GET /connections/1/edit
  def edit
  end

  # POST /connections
  # POST /connections.json
  def create
    @connection = Connection.new(connection_params)

    respond_to do |format|
      if @connection.save
        format.json { render json: @connection, status: :created }
        format.html { redirect_to connections_path, notice: 'Connection was successfully created.' }
      else
        # format.html { render :new }
        format.json { render json: @connection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /connections/1
  # PATCH/PUT /connections/1.json
  def update
    respond_to do |format|
      if @connection.update(connection_params)
        format.html { redirect_to @connection, notice: 'Connection was successfully updated.' }
        format.json { render :show, status: :ok, location: @connection }
      else
        format.html { render :edit }
        format.json { render json: @connection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /connections/1
  # DELETE /connections/1.json
  def destroy
    @connection.destroy
    respond_to do |format|
      format.json { render json: @connection }
      format.html { redirect_to connections_url, notice: 'Connection was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_connection
      @connection = Connection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def connection_params
      params.require(:connection).permit(:requestee_id, :requester_id)
    end
end
