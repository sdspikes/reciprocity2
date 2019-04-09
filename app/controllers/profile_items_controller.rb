class ProfileItemsController < ApplicationController
  before_action :set_profile_item, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /profile_items
  # GET /profile_items.json
  def index
    @profile_items = ProfileItem.all
  end

  # GET /profile_items/1
  # GET /profile_items/1.json
  def show
  end

  # GET /profile_items/new
  def new
    @profile_item = ProfileItem.new
  end

  # GET /profile_items/1/edit
  def edit
  end

  def create_text_profile_item
    data = profile_item_params[:profile_item_data_attributes][:value]
    text_item = TextProfileItem.new(value: data)

    if text_item.save
      render json: text_item
    else
      render json: text_item.errors, status: :unprocessable_entity
    end
  end

  # POST /profile_items
  # POST /profile_items.json
  def create
    params = profile_item_params.to_h
    params[:user_id] = current_user.id
    @profile_item = ProfileItem.new(params)

    respond_to do |format|
      if @profile_item.save
        # format.html { redirect_to @profile_item, notice: 'Profile item was successfully created.' }
        format.json { render json: @profile_item }
      else
        # format.html { render :new }
        format.json { render json: @profile_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profile_items/1
  # PATCH/PUT /profile_items/1.json
  def update
    respond_to do |format|
      if @profile_item.update(profile_item_params)
        # format.html { redirect_to @profile_item, notice: 'Profile item was successfully updated.' }
        format.json { render json: { status: :ok, profile_item: @profile_item } }
        # format.js {}
      else
        # format.html { render :edit }
        format.json { render json: { errors: @profile_item.errors, status: :unprocessable_entity } }
      end
    end
  end

  # DELETE /profile_items/1
  # DELETE /profile_items/1.json
  def destroy
    @profile_item.destroy
    respond_to do |format|
      # format.html { redirect_to profile_items_url, notice: 'Profile item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_item
      @profile_item = ProfileItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_item_params
      params.require(:profile_item).permit(
        :user_id,
        :profile_item_category_id,
        :privacy_group_id,
        :profile_item_data_id,
        :profile_item_data_type,
        profile_item_data_attributes: [:id, :value])
    end
end
