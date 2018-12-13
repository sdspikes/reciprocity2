class ProfilesController < ApplicationController
  before_action :set_profile_user, only: [:show, :edit, :update, :destroy]

  # GET /profile_item_categories
  # GET /profile_item_categories.json
  def index
    @profiles = User.all.map { |u| u.profile_items }
  end

  # GET /profile_item_categories/1
  # GET /profile_item_categories/1.json
  def show
    @profile_items = @profile_user.profile_items
  end

  # GET /profile_item_categories/new
  def new
  end

  # GET /profile_item_categories/1/edit
  def edit
  end

  # POST /profile_item_categories
  # POST /profile_item_categories.json
  def create
  end

  # PATCH/PUT /profile_item_categories/1
  # PATCH/PUT /profile_item_categories/1.json
  def update
  end

  # DELETE /profile_item_categories/1
  # DELETE /profile_item_categories/1.json
  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_user

      @profile_user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_item_category_params
      params.require(:profile_item_category).permit(:title, :description)
    end
end
