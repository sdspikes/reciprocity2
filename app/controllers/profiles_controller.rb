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
    if (current_user == @profile_user)
      privacy_groups = current_user.privacy_groups.map(&:serializable_hash).each {|group| group['type'] = 'PrivacyGroup'}
      privacy_presets = PrivacyPreset.all.map(&:serializable_hash).each {|preset| preset['type'] = 'PrivacyPreset'}

      @privacy_settings = privacy_groups + privacy_presets
    end
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
