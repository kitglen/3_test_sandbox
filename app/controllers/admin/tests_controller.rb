class Admin::TestsController < ApplicationController
  before_filter :authenticate_admin!
  layout 'admin'

  # GET /tests
  # GET /tests.json
  def index
    @tests = V1::Test.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tests }
    end
  end

  # GET /tests/1
  # GET /tests/1.json
  def show
    
    @test = V1::Test.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @test }
    end
  end

  # GET /tests/new
  # GET /tests/new.json
  def new
    @test = V1::Test.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @test }
    end
  end

  # GET /tests/1/edit
  def edit
    
    @test = V1::Test.find(params[:id])
    
  end

  # POST /tests
  # POST /tests.json
  def create
    @test = V1::Test.new(params[:test], as: :"System Admin")
    respond_to do |format|
      if @test.save
        format.html { redirect_to admin_test_url(@test), notice: 'test was successfully created.' }
        format.json { render json: @test, status: :created, location: admin_test_url(@test) }
      else
        format.html { render action: "new" }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tests/1
  # PUT /tests/1.json
  def update
    
    @test = V1::Test.find(params[:id])
    
    @test.update_attributes(params[:test], as: :"System Admin")
    respond_to do |format|
      if @test.save
        format.html { redirect_to admin_test_url(@test), notice: 'test was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    
    @test = V1::Test.find(params[:id])
    
    @test.destroy

    respond_to do |format|
      format.html { redirect_to admin_tests_url }
      format.json { head :no_content }
    end
  end
end