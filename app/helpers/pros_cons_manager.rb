module ProsConsManager

  def create_pros_cons(gear_item_review, pros, cons)
    [pros, cons].flatten.each do |pro_con|
      next if pro_con["text"].blank?

      gear_item_review.pros_cons.create(text: pro_con["text"], is_pro: pro_con["isPro"])
    end
  end
end