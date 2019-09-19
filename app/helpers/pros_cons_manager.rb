module ProsConsManager

  def create_pros_cons(gear_item_review, pros, cons)
    [pros, cons].flatten.each do |pro_con|
      next if !pro_con["id"].nil?
      next if pro_con["text"].blank?

      gear_item_review.pros_cons.create(text: pro_con["text"], is_pro: pro_con["isPro"])
    end
  end

  def remove_pros_cons(gear_item_review, pros, cons)
    delete_ids = []
    initial_pros_cons = gear_item_review.pros_cons.map(&:id)
    payload_pros_cons = [pros, cons].flatten.map do |pro_con|
      return pro_con["id"]
    end
    

    initial_pros_cons.each do |p_pro_con|
      if !payload_pros_cons.include?(p_pro_con)
        delete_ids.push(p_pro_con)
      end
    end

    delete_ids.each do |d_id|
      ProsCon.find(d_id).delete
    end
  end

  def update_pros_cons(gear_item_review, pros, cons)
    [pros, cons].flatten.each do |pro_con|
      next if pro_con["id"].nil?

      ProsCon.find(pro_con["id"]).update(text: pro_con["text"], is_pro: pro_con["isPro"])
    end
  end
end