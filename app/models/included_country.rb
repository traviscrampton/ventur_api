class IncludedCountry < ActiveRecord::Base
  belongs_to :country
  belongs_to :journal
end