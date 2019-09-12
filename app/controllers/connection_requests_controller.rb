class ConnectionRequestsController < ApplicationController
  before_action :set_connection_request, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /connection_requests
  # GET /connection_requests.json
  def index
    @connection_requests = ConnectionRequest.all
  end

  # GET /connection_requests/1
  # GET /connection_requests/1.json
  def show
  end

  # GET /connection_requests/new
  def new
    @connection_request = ConnectionRequest.new
  end

  # GET /connection_requests/1/edit
  def edit
  end

  # POST /connection_requests
  # POST /connection_requests.json
  def create
    @connection_request = ConnectionRequest.new(connection_request_params)

    respond_to do |format|
      if @connection_request.save
        format.html { redirect_to connections_path, notice: 'Connection request was successfully created.' }
        format.json { render :show, status: :created, location: @connection_request }
      else
        format.html { render :new }
        format.json { render json: @connection_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /connection_requests/1
  # PATCH/PUT /connection_requests/1.json
  def update
    respond_to do |format|
      if @connection_request.update(connection_request_params)
        # format.html { redirect_to @connection_request, notice: 'Connection request was successfully updated.' }
        format.json { render json: @connection_request, status: :ok }
      else
        # format.html { render :edit }
        format.json { render json: @connection_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /connection_requests/1
  # DELETE /connection_requests/1.json
  def destroy
    @connection_request.destroy
    respond_to do |format|
      format.json { render json: @connection_request, status: :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_connection_request
      @connection_request = ConnectionRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def connection_request_params
      params.require(:connection_request).permit(:requester_id, :requestee_id, :source_id, :source_type, :ignored, :accepted)
    end
end
