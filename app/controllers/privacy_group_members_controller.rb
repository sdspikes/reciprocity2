class PrivacyGroupMembersController < ApplicationController
  before_action :set_privacy_group_member, only: [:show, :edit, :update, :destroy, :destroy_member]

  skip_before_action :verify_authenticity_token

  # GET /privacy_group_members
  # GET /privacy_group_members.json
  def index
    @privacy_group_members = PrivacyGroupMember.all
  end

  # GET /privacy_group_members/1
  # GET /privacy_group_members/1.json
  def show
  end

  # GET /privacy_group_members/new
  def new
    @privacy_group_member = PrivacyGroupMember.new
  end

  # GET /privacy_group_members/1/edit
  def edit
  end

  # POST /privacy_group_members
  # POST /privacy_group_members.json
  def create
    @privacy_group_member = PrivacyGroupMember.new(privacy_group_member_params)

    respond_to do |format|
      if @privacy_group_member.save
        format.html { redirect_to @privacy_group_member, notice: 'Privacy group member was successfully created.' }
        format.json { render :show, status: :created, location: @privacy_group_member }
      else
        format.html { render :new }
        format.json { render json: @privacy_group_member.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_member
    @privacy_group_member = PrivacyGroupMember.new(privacy_group_member_params)

    respond_to do |format|
      if @privacy_group_member.save
        format.html { redirect_to @privacy_group_member, notice: 'Privacy group member was successfully created.' }
        format.json { render :show, status: :created, location: @privacy_group_member }
      else
        format.html { render :new }
        format.json { render json: @privacy_group_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /privacy_group_members/1
  # PATCH/PUT /privacy_group_members/1.json
  def update
    respond_to do |format|
      if @privacy_group_member.update(privacy_group_member_params)
        format.html { redirect_to @privacy_group_member, notice: 'Privacy group member was successfully updated.' }
        format.json { render :show, status: :ok, location: @privacy_group_member }
      else
        format.html { render :edit }
        format.json { render json: @privacy_group_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /privacy_group_members/1
  # DELETE /privacy_group_members/1.json
  def destroy
    @privacy_group_member.destroy
    respond_to do |format|
      format.html { redirect_to privacy_group_members_url, notice: 'Privacy group member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_member
    id = @privacy_group_member.id
    @privacy_group_member.destroy
    respond_to do |format|
      format.json { render json: {id: id} }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_privacy_group_member
      @privacy_group_member = PrivacyGroupMember.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def privacy_group_member_params
      params.require(:privacy_group_member).permit(:privacy_group_id, :user_id)
    end
end
