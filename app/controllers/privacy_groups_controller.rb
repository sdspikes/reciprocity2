class PrivacyGroupsController < ApplicationController
  before_action :set_privacy_group, only: [:show, :edit, :update, :destroy]

  # GET /privacy_groups
  # GET /privacy_groups.json
  def index
    @privacy_groups = PrivacyGroup.all
  end

  # GET /privacy_groups/1
  # GET /privacy_groups/1.json
  def show
    @privacy_group_members = PrivacyGroupMember.where(privacy_group_id: @privacy_group.id)
  end

  # GET /privacy_groups/new
  def new
    @privacy_group = PrivacyGroup.new
  end

  # GET /privacy_groups/1/edit
  def edit
  end

  # POST /privacy_groups
  # POST /privacy_groups.json
  def create
    @privacy_group = PrivacyGroup.new(privacy_group_params)

    respond_to do |format|
      if @privacy_group.save
        format.html { redirect_to @privacy_group, notice: 'Privacy group was successfully created.' }
        format.json { render :show, status: :created, location: @privacy_group }
      else
        format.html { render :new }
        format.json { render json: @privacy_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /privacy_groups/1
  # PATCH/PUT /privacy_groups/1.json
  def update
    respond_to do |format|
      if @privacy_group.update(privacy_group_params)
        format.html { redirect_to @privacy_group, notice: 'Privacy group was successfully updated.' }
        format.json { render :show, status: :ok, location: @privacy_group }
      else
        format.html { render :edit }
        format.json { render json: @privacy_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /privacy_groups/1
  # DELETE /privacy_groups/1.json
  def destroy
    @privacy_group.destroy
    respond_to do |format|
      format.html { redirect_to privacy_groups_url, notice: 'Privacy group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_privacy_group
      @privacy_group = PrivacyGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def privacy_group_params
      params.require(:privacy_group).permit(:name, :owner_id)
    end
end
