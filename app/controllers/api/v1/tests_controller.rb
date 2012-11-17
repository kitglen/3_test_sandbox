class Api::V1::TestsController < ApplicationController
  resource_description do
    name 'V1::Tests'
    short 'V1::Tests'
    path '/v1/tests.json'
    version '1'
    formats ['json']
    param :id, String, :desc => "V1::Test ID", :required => false
    param :test, Hash, :desc => "V1::Test's parameters for all methods" do
    
      param :id, String, :required => false,
            :desc => "Id"
    
      param :name, String, :required => false,
            :desc => "Name"
    
    end
    description <<-DOC
      V1::Tests.
    DOC
  end
  respond_to :json
  
  protect_from_forgery :except => [:create, :update, :destroy]
  
  # GET /tests.json
  api :GET, "/v1/tests.json", "Show all tests based on a query scope"
  def index
    scope = params[:scope] || 'all'
    reject_as_unauthorized and return unless authorized_for_scope?(scope)
    @tests = scope_named(scope)
    respond_with @tests
  end

  # GET /tests/1.json
  api :GET, "/v1/tests/:id.json", "Show test"
  def show
    reject_as_unauthorized and return unless can_read?
    
    @test = scope_for_read_finder.find(params[:id])
    
    respond_with @test
  end

  # GET /tests/new.json
  api :GET, "/v1/tests/new.json", "Instantiate a new test"
  def new
    @test = V1::Test.new
    respond_with @test
  end

  # POST /tests.json
  api :POST, "/v1/tests.json", "Create a new test"
  def create
    reject_as_unauthorized and return unless can_create?
    @test = scope_for_create_finder.new(params[:test], as: :"#{current_user_role} on create")
    @test.save
    respond_with @test
  end

  # PUT /tests/1.json
  api :PUT, "/v1/tests/:id.json", "Update an existing test"
  def update
    reject_as_unauthorized and return unless can_update?
    
    @test = scope_for_update_finder.find(params[:id])
    
    @test.update_attributes(params[:test], as: :"#{current_user_role} on update")
    respond_with @test
  end

  # DELETE /tests/1.json
  api :DELETE, "/v1/tests/:id.json", "Delete an existing test"
  def destroy
    reject_as_unauthorized and return unless can_delete?
    
    @test = scope_for_delete_finder.find(params[:id])
    
    @test.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
  
protected
  def scope_named(name)
    scope = 'all' unless ::V1::Test.respond_to?(name)
    if name == 'all'
      
      scope = ::V1::Test.all
      scope = scope.skip(params[:offset].to_i) if params[:offset]
      scope = scope.limit(params[:limit].to_i) if params[:limit]
      
    elsif name == 'count'
      scope = ::V1::Test.count
    else
      scope = ::V1::Test.send(name, (params[:query] || {}), {}, params[:offset], params[:limit])
    end
    scope
  end

  # Overriding respond_with to perform field level authorization for reading fields.
  def respond_with(*resources, &block)
    replacement = nil
    resources.each do |resource|
      if resource.respond_to?(:each)
        replacement = []
        resource.each do |instance| 
          replacement << scrubbed_instance(instance)
        end
      elsif resource.respond_to?(:attributes)
        replacement = scrubbed_instance(resource)
      else
        replacement = resource
      end
    end

    super(replacement, :location => nil)
  end

  def scrubbed_instance(instance)
    instance.attributes.select{|attribute| ['id', 'name'].include?(attribute) }.each do |attribute, value|
      instance.send("#{attribute}=", nil) unless authorized_to_read_field?(attribute)
    end
    instance
  end

  
    def can_read?
      
        true
      
    end

    def scope_for_read_finder
      
        ::V1::Test
      
    end
  
    def can_create?
      
        true
      
    end

    def scope_for_create_finder
      
        ::V1::Test
      
    end
  
    def can_update?
      
        true
      
    end

    def scope_for_update_finder
      
        ::V1::Test
      
    end
  
    def can_delete?
      
        true
      
    end

    def scope_for_delete_finder
      
        ::V1::Test
      
    end
  

  def authorized_for_scope?(scope_name)
    
      true
    
  end

  def authorized_to_read_field?(field_name)
    
      true
    
  end

  include Api::V1::Custom::TestsController
end
