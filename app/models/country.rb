class Country < ActiveRecord::Base
  has_many :included_countries
  has_many :journals, through: :included_countries
end