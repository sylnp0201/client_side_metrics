class TestViewDataController < ApplicationController
  before_action :set_test_view_datum, only: [:show, :edit, :update, :destroy]

  # GET /test_view_data
  # GET /test_view_data.json
  def index
    @test_view_data = TestViewDatum.all
  end

  # GET /test_view_data/1
  # GET /test_view_data/1.json
  def show
  end

  # GET /test_view_data/new
  def new
    @test_view_datum = TestViewDatum.new
  end

  # GET /test_view_data/1/edit
  def edit
  end

  # POST /test_view_data
  # POST /test_view_data.json
  def create
    @test_view_datum = TestViewDatum.new(test_view_datum_params)

    respond_to do |format|
      if @test_view_datum.save
        format.html { redirect_to @test_view_datum, notice: 'Test view datum was successfully created.' }
        format.json { render action: 'show', status: :created, location: @test_view_datum }
      else
        format.html { render action: 'new' }
        format.json { render json: @test_view_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /test_view_data/1
  # PATCH/PUT /test_view_data/1.json
  def update
    respond_to do |format|
      if @test_view_datum.update(test_view_datum_params)
        format.html { redirect_to @test_view_datum, notice: 'Test view datum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @test_view_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_view_data/1
  # DELETE /test_view_data/1.json
  def destroy
    @test_view_datum.destroy
    respond_to do |format|
      format.html { redirect_to test_view_data_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_view_datum
      @test_view_datum = TestViewDatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_view_datum_params
      params.require(:test_view_datum).permit(:load_time, :first_byte, :start_render, :bytes_in, :bytes_in_doc, :requests, :requests_doc, :fully_loaded, :doc_time, :dom_elements, :title_time)
    end
end
