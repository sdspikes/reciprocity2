class MatchPeopleController < ApplicationController
  before_action :set_match_person, only: [:show, :edit, :update, :destroy]

  # GET /match_people
  # GET /match_people.json
  def index
    @match_people = MatchPerson.all
  end

  # GET /match_people/1
  # GET /match_people/1.json
  def show
    @compatibilities = @match_person.outgoing_compatibilities + @match_person.incoming_compatibilities
    @compatibilities = @compatibilities.sort_by{|c| c.rating ? c.rating : -1 * c.get_other_person(@match_person).gender_id}
  end

  # GET /match_people/new
  def new
    @match_person = MatchPerson.new
  end

  # GET /match_people/1/edit
  def edit
  end

  # POST /match_people
  # POST /match_people.json
  def create
    @match_person = MatchPerson.new(match_person_params)

    respond_to do |format|
      if @match_person.save
        format.html { redirect_to @match_person, notice: 'Match person was successfully created.' }
        format.json { render :show, status: :created, location: @match_person }
      else
        format.html { render :new }
        format.json { render json: @match_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /match_people/1
  # PATCH/PUT /match_people/1.json
  def update
    respond_to do |format|
      if @match_person.update(match_person_params)
        format.html { redirect_to @match_person, notice: 'Match person was successfully updated.' }
        format.json { render :show, status: :ok, location: @match_person }
      else
        format.html { render :edit }
        format.json { render json: @match_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /match_people/1
  # DELETE /match_people/1.json
  def destroy
    @match_person.destroy
    respond_to do |format|
      format.html { redirect_to match_people_url, notice: 'Match person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match_person
      @match_person = MatchPerson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_person_params
      params.require(:match_person).permit(:name, :email, :okc, :fb, :li, :age, :acceptable_range, :occupation, :location, :gender_id, :openness, :identities, :current_partners, :situation, :kids, :ask_first, :keep_dating, :only_strong_match, :num_matches, :important, :disappointments, :date_activities, :murphyjitsu, :incompatible, :continue_matching, :anything_else, :notes)
    end
end
