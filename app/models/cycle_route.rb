class CycleRoute < ActiveRecord::Base
  belongs_to :routable, polymorphic: true
end