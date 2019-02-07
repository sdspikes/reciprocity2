class ProfilesController < ApplicationController
  before_action :set_profile_user, only: [:show, :edit, :update, :destroy]

  # GET /profiles
  # GET /profiles.json
  def index
    @checks = Check.all
    @new_check = Check.new
    @users = User.all
    @activities = Activity.all
    @current_user = current_user
    @users_to_activities = (@current_user && @current_user.get_checks_table) || {}
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile_items = @profile_user.profile_items
    @activities = current_user.get_checks_for(@profile_user.id)
    p @activities
  end

  # GET /profiles/new
  def new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
  end

  # POST /profiles/1/update_checks
  # POST /profiles.json
  def update_checks
    puts "here"
    update_params = params.permit(:id, desired_activities: [:user_id, checks: [ :p1, :p2, :p3]])
    p update_params
    # desired_activities = update_params[:desired_activities]
    # p desired_activities.class
    # checked = desired_activities[:user_id]
    # activities = desired_activities[:checks]

    # p activities.class
    # p checked.class
    # activities.each do |activity_id, checks|
    #   # p j[:original]
    #   p checks.class
    #   p checks
    #   # checks.each do |c|
    #   #   p c
    #   # end
    #   # original = checks[:original]
    #   # new_check = checks[:new]
    #   # p original
    #   # p new_check
    # end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
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
