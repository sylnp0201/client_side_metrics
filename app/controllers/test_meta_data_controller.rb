class TestMetaDataController < ApplicationController
  before_action :set_test_meta_datum, only: [:show, :edit, :update, :destroy]

  # GET /test_meta_data
  # GET /test_meta_data.json
  def index
    @test_meta_data = TestMetaDatum.all
  end

  # GET /test_meta_data/1
  # GET /test_meta_data/1.json
  def show
  end

  # GET /test_meta_data/new
  def new
    @test_meta_datum = TestMetaDatum.new
  end

  # GET /test_meta_data/1/edit
  def edit
  end

  # POST /test_meta_data
  # POST /test_meta_data.json
  def create
    @test_meta_datum = TestMetaDatum.new(test_meta_datum_params)

    respond_to do |format|
      if @test_meta_datum.save
        format.html { redirect_to @test_meta_datum, notice: 'Test meta datum was successfully created.' }
        format.json { render action: 'show', status: :created, location: @test_meta_datum }
      else
        format.html { render action: 'new' }
        format.json { render json: @test_meta_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /test_meta_data/1
  # PATCH/PUT /test_meta_data/1.json
  def update
    respond_to do |format|
      if @test_meta_datum.update(test_meta_datum_params)
        format.html { redirect_to @test_meta_datum, notice: 'Test meta datum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @test_meta_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_meta_data/1
  # DELETE /test_meta_data/1.json
  def destroy
    @test_meta_datum.destroy
    respond_to do |format|
      format.html { redirect_to test_meta_data_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_meta_datum
      @test_meta_datum = TestMetaDatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_meta_datum_params
      params.require(:test_meta_datum).permit(:test_id, :summary, :test_url, :page, :location, :browser, :connectivity, :ran_at, :runs, :first_view_id, :repeat_view_id)
    end
end
