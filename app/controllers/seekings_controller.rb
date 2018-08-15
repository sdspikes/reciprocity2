class SeekingsController < ApplicationController
  before_action :set_seeking, only: [:show, :edit, :update, :destroy]

  # GET /seekings
  # GET /seekings.json
  def index
    @seekings = Seeking.all
  end

  # GET /seekings/1
  # GET /seekings/1.json
  def show
  end

  # GET /seekings/new
  def new
    @seeking = Seeking.new
  end

  # GET /seekings/1/edit
  def edit
  end

  # POST /seekings
  # POST /seekings.json
  def create
    @seeking = Seeking.new(seeking_params)

    respond_to do |format|
      if @seeking.save
        format.html { redirect_to @seeking, notice: 'Seeking was successfully created.' }
        format.json { render :show, status: :created, location: @seeking }
      else
        format.html { render :new }
        format.json { render json: @seeking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seekings/1
  # PATCH/PUT /seekings/1.json
  def update
    respond_to do |format|
      if @seeking.update(seeking_params)
        format.html { redirect_to @seeking, notice: 'Seeking was successfully updated.' }
        format.json { render :show, status: :ok, location: @seeking }
      else
        format.html { render :edit }
        format.json { render json: @seeking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seekings/1
  # DELETE /seekings/1.json
  def destroy
    @seeking.destroy
    respond_to do |format|
      format.html { redirect_to seekings_url, notice: 'Seeking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seeking
      @seeking = Seeking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seeking_params
      params.require(:seeking).permit(:gender_id, :match_person_id)
    end
end
