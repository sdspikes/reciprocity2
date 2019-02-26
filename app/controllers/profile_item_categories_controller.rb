class ProfileItemCategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /profile_item_categories
  # GET /profile_item_categories.json
  def index
    @profile_item_categories = ProfileItemCategory.all
  end

  # GET /profile_item_categories/1
  # GET /profile_item_categories/1.json
  def show
  end

  # GET /profile_item_categories/new
  def new
    @profile_item_category = ProfileItemCategory.new
  end

  # GET /profile_item_categories/1/edit
  def edit
  end

  def get_options
    id = params[:id]

    options = ProfileItemResponse.where(profile_item_category_id: id)
    render json: {options: options}
  end


  # POST /profile_item_categories
  # POST /profile_item_categories.json
  def create
    @profile_item_category = ProfileItemCategory.new(profile_item_category_params)

    respond_to do |format|
      if @profile_item_category.save
        format.html { redirect_to @profile_item_category, notice: 'Profile item category was successfully created.' }
        format.json { render :show, status: :created, location: @profile_item_category }
      else
        format.html { render :new }
        format.json { render json: @profile_item_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profile_item_categories/1
  # PATCH/PUT /profile_item_categories/1.json
  def update
    respond_to do |format|
      if @profile_item_category.update(profile_item_category_params)
        format.html { redirect_to @profile_item_category, notice: 'Profile item category was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile_item_category }
      else
        format.html { render :edit }
        format.json { render json: @profile_item_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profile_item_categories/1
  # DELETE /profile_item_categories/1.json
  def destroy
    @profile_item_category.destroy
    respond_to do |format|
      format.html { redirect_to profile_item_categories_url, notice: 'Profile item category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_item_category
      @profile_item_category = ProfileItemCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_item_category_params
      params.require(:profile_item_category).permit(:title, :description)
    end
end
