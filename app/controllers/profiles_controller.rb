class ProfilesController < ApplicationController
  before_action :set_profile_user, only: [:show, :edit, :update, :destroy]

  skip_before_action :verify_authenticity_token

  # GET /profile_item_categories
  # GET /profile_item_categories.json
  def index
    @checks = Check.all
    @new_check = Check.new
    @users = User.all
    @activities = Activity.all
    @current_user = current_user
    @users_to_activities = (@current_user && @current_user.get_checks_table) || {}
  end

  # GET /profile_item_categories/1
  # GET /profile_item_categories/1.json
  def show
    @profile_items = ProfileItem.get_viewable(@profile_user, current_user)
    @item_data = @profile_items.map{|item| item.profile_item_data }
    @categories = ProfileItemCategory.all
#     TODO(sdspkes): hide basic items if not filled in or not allowed due to privacy
    @basic_profile_items = {
      age: @profile_user.age,
      bio: @profile_user.bio,
      gender: @profile_user.gender,
      current_relationships: @profile_user.current_relationships,
      relationship_style: @profile_user.relationship_style
    }
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

  def update_item
    # p [current_user.id, params[:field], params[:value]]
    if params[:field] == "bio"
      current_user.update!(bio: params[:value])
    elsif params[:field] == "gender"
      current_user.update!(gender: params[:value])
    elsif params[:field] == "current_relationships"
      current_user.update!(current_relationships: params[:value])
    elsif params[:field] == "relationship_style"
      current_user.update!(relationship_style: params[:value])
    end
      #     age: @profile_user.age,
      # bio: @profile_user.bio,
      # gender: @profile_user.gender,
      # current_relationships: @profile_user.current_relationships,
      # relationship_style: @profile_user.relationship_style

    # field = params[:field]
    # value = params[:value]
    # category = ProfileItemCategory.find(name: field)
    # if category
    #   response = ProfileItem.find(user: current_user, profile_item_category: category)
    #   if response
    #     response.value = value
    #     response.save!
    #   else
    #     ProfileItemResponse.create(user: current_user, value: value, profile_item_category: category)
    #   end

    #   head :ok
    # else
    #   be sad
    # end

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
