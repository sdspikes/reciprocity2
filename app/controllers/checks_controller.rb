class ChecksController < ApplicationController
  before_action :set_check, only: [:show, :edit, :update, :destroy]

  skip_before_action :verify_authenticity_token

  # GET /checks
  # GET /checks.json
  def index
    @current_user = current_user
    if (@current_user)
      @checks = Check.all
      @users = @current_user.get_relevant_users
      @activities = Activity.all
      @users_to_activities = @current_user.get_checks_table
    end
  end

  # GET /checks/1
  # GET /checks/1.json
  def show
  end

  # GET /checks/new
  def new
    @check = Check.new
  end

  # GET /checks/1/edit
  def edit
  end

  # POST /checks
  # POST /checks.json
  def create
    new_check_params = {
      activity_id: check_params["activity_id"].to_i,
      checker_id: current_user.id,
      checked_id: check_params["user_id"].to_i
    }

    @check = Check.new(new_check_params)
    respond_to do |format|
      if @check.save
        format.html { redirect_to checks_path, notice: 'Check was successfully created.' }
        format.json { render :show, status: :created, location: @check }
      else
        format.html { render :new }
        format.json { render json: @check.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_check
    new_check_params = {
      activity_id: check_params["activity_id"].to_i,
      checker_id: current_user.id,
      checked_id: check_params["user_id"].to_i
    }

    @check = Check.new(new_check_params)
    respond_to do |format|
      if @check.save
        reciprocated = Check.find_by(activity_id: new_check_params[:activity_id], checked_id: current_user.id, checker_id: new_check_params[:checked_id])
        if reciprocated
          UserMailer.with(user: @check.checker, user2: @check.checked, activity: @check.activity).match_email.deliver_now
          UserMailer.with(user: @check.checked, user2: @check.checker, activity: @check.activity).match_email.deliver_now
        end
        format.json  { render :json => {:check_id => @check.id, reciprocated: !!reciprocated} }
      else
        format.json  { render :json => @check.errors }
      end
    end
  end

  def destroy_check
    check_id = check_params[:check_id]
    @check = Check.find(check_id)
    @check.destroy
    render :json => {:check_id => check_id}
  end


  # PATCH/PUT /checks/1
  # PATCH/PUT /checks/1.json
  def update
    respond_to do |format|
      if @check.update(check_params)
        format.html { redirect_to @check, notice: 'Check was successfully updated.' }
        format.json { render :show, status: :ok, location: @check }
      else
        format.html { render :edit }
        format.json { render json: @check.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checks/1
  # DELETE /checks/1.json
  def destroy
    return if !@check
    @check.destroy
    respond_to do |format|
      format.html { redirect_to checks_url, notice: 'Check was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_check
      @check = Check.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def check_params
      params.permit(:activity_id, :user_id, :check_id)
    end
end
