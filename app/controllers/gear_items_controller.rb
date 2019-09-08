class GearItemsController < ApplicationController

  def item_search
    @gear_items = if params[:name].blank?
                    []
                  else  
                    GearItem.where("name ilike ?", "%#{params[:name]}%").limit(5)
                  end

    render "gear_items/item_search.json"
  end
end