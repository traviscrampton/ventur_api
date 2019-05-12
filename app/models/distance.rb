# == Schema Information
#
# Table name: distances
#
#  id                :integer          not null, primary key
#  distanceable_id   :integer
#  distanceable_type :string
#  amount            :decimal(8, 2)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Distance < ActiveRecord::Base
  validates_presence_of :distanceable, :kilometer_amount, :mile_amount
  belongs_to :distanceable, polymorphic: true

  enum distance_type: [:kilometer, :mile]

  def amount
    attribute = distance_type + "_amount"
    self.send(attribute).to_i
  end

  def self.new_distance_params(type, amount)
    case type
    when "kilometer"
      self.kilometer_primary_params(amount)
    when "mile"
      self.mile_primary_params(amount)
    else
      {}
    end
  end

  def persist_distance_amount(amount)
    case distance_type
    when "kilometer"
      persist_kilometer_primary(amount)
    when "mile"
      persist_mile_primary(amount)
    else
      return
    end
  end

  def kilometer_primary_params(amount)
    miles = amount / 1.6

    { kilometer_amount: amount, mile_amount: miles }
  end

  def mile_primary_params(amount)
    kilometers = amount * 1.6

    { mile_amount: amount, kilometer_amount: kilometers }
  end

  private

  def persist_kilometer_primary(amount)
    params = self.kilometer_primary_params(amount)

    self.update(params)
  end

  def persist_mile_primary(amount)
    params = self.mile_primary_params(amount)

    self.update(params)
  end
end
