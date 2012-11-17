class V1::Test
  include Mongoid::Document

  # Include modules for extensions.
  

  store_in collection: :'Test'

  

  # Field definitions
  
  field :id, type: String
  
  field :name, type: String
  

  # Relationship definitions
  
  
  

  # Simple validations
  

    # Default scopes for System Admin
  attr_accessible :name, as: :"System Admin"
  # Default accessible scopes when nothing is defined
  attr_accessible :name, as: :"Unauthenticated Default on create"
  attr_accessible :name, as: :"Unauthenticated Default on update"


    # Scopes for data access
  class << self
    def exact_match(attributes={}, user_attributes={}, offset = nil, limit = nil)
                  scope = self.all
                  attributes.each_pair do |name, value|
                    scope = scope.where(name => value)
                  end

                      scope = scope.order_by("id ASC")

                    scope = scope.offset(offset.to_i) if offset
                    scope = scope.limit(limit.to_i) if limit

 scope
end

def count_exact_match(attributes={}, user_attributes={}, offset = nil, limit = nil)
                  scope = self.all
                  attributes.each_pair do |name, value|
                    scope = scope.where(name => value)
                  end

                    scope = scope.count

 scope
end
  end


  

  def serializable_hash(options={})
    super(options.merge(only: [:id, :name]))
  end

  # Add lifecycle hook methods to model lifecycle
# model type: mongoid

# Define lifecycle hook methods





  include V1::Custom::Test
end