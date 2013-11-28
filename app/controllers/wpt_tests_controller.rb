class WptTestsController < ApplicationController
  before_action :set_wpt_test, only: [:show, :edit, :update, :destroy]

  # GET /wpt_tests
  # GET /wpt_tests.json
  def index
    @wpt_tests = WptTest.all
  end

  # GET /wpt_tests/1
  # GET /wpt_tests/1.json
  def show
  end

  # GET /wpt_tests/new
  def new
    @wpt_test = WptTest.new
  end

  # GET /wpt_tests/1/edit
  def edit
  end

  # POST /wpt_tests
  # POST /wpt_tests.json
  def create
    @wpt_test = WptTest.new(wpt_test_params)

    respond_to do |format|
      if @wpt_test.save
        format.html { redirect_to @wpt_test, notice: 'Wpt test was successfully created.' }
        format.json { render action: 'show', status: :created, location: @wpt_test }
      else
        format.html { render action: 'new' }
        format.json { render json: @wpt_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wpt_tests/1
  # PATCH/PUT /wpt_tests/1.json
  def update
    respond_to do |format|
      if @wpt_test.update(wpt_test_params)
        format.html { redirect_to @wpt_test, notice: 'Wpt test was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @wpt_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wpt_tests/1
  # DELETE /wpt_tests/1.json
  def destroy
    @wpt_test.destroy
    respond_to do |format|
      format.html { redirect_to wpt_tests_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wpt_test
      @wpt_test = WptTest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wpt_test_params
      params.require(:wpt_test).permit(:test_id, :xml)
    end
end
