class CompatibilitiesController < ApplicationController
  before_action :set_compatibility, only: [:show, :edit, :update, :destroy]

  # GET /compatibilities
  # GET /compatibilities.json
  def index
    @compatibilities = Compatibility.all
    @compatibilities = @compatibilities.sort_by { |c| c.dealbreaker ? 100 : c.rating.to_i }
  end

  def dealbreakers_index
    @compatibilities = Compatibility.where dealbreaker: true
    render 'index'
  end

  def unrated_index
    @compatibilities = Compatibility.where dealbreaker: false, rating: nil
    render 'index'
  end

  def rated_index
    @compatibilities = Compatibility.where dealbreaker: false
    @compatibilities -= Compatibility.where(dealbreaker: false, rating: nil)
    @compatibilities = @compatibilities.sort_by { |c| - c.rating.to_i }
    render 'index'
  end

  # GET /compatibilities/1
  # GET /compatibilities/1.json
  def show
  end

  # GET /compatibilities/new
  def new
    @compatibility = Compatibility.new
  end

  # GET /compatibilities/1/edit
  def edit
  end

  # POST /compatibilities
  # POST /compatibilities.json
  def create
    @compatibility = Compatibility.new(compatibility_params)

    respond_to do |format|
      if @compatibility.save
        format.html { redirect_to @compatibility, notice: 'Compatibility was successfully created.' }
        format.json { render :show, status: :created, location: @compatibility }
      else
        format.html { render :new }
        format.json { render json: @compatibility.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /compatibilities/1
  # PATCH/PUT /compatibilities/1.json
  def update
    respond_to do |format|
      if @compatibility.update(compatibility_params)
        if request.referrer.include?('match_people')
          format.html { redirect_to request.referrer, notice: 'Compatibility was successfully updated.' }
          format.json { render :show, status: :ok, location: @compatibility }
        else
          format.html { redirect_to @compatibility, notice: 'Compatibility was successfully updated.' }
          format.json { render :show, status: :ok, location: @compatibility }
        end
      else
        format.html { render :edit }
        format.json { render json: @compatibility.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compatibilities/1
  # DELETE /compatibilities/1.json
  def destroy
    @compatibility.destroy
    respond_to do |format|
      format.html { redirect_to compatibilities_url, notice: 'Compatibility was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_compatibility
      @compatibility = Compatibility.find(params[:id])
      last_id = Compatibility.last.id

      id = params[:id].to_i + 1
      @next = nil
      while (!@next && id < last_id) || (@next && @next.dealbreaker) do
        id += 1
        @next = Compatibility.find(id)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def compatibility_params
      params.require(:compatibility).permit(:dealbreaker, :rating, :notes, :match_person_1_id, :match_person_2_id, :introduction_made)
    end
end
