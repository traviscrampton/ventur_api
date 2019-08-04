require 'csv'
# users
u1 = User.create(email: "crampton.travis@gmail.com", first_name: "Travis", last_name: "Crampton", password: "travis12")
u2 = User.create(email: "gabeleoni@gmail.com", first_name: 'Gabe', last_name: 'Leoni', password: "travis12")
StravaAuth.create(user_id: u1.id)
StravaAuth.create(user_id: u2.id)

# profile info
u1.avatar.attach(io: File.open("#{Rails.root}/public/images/travis_image.png"), filename: "travis_image.png")
u2.avatar.attach(io: File.open("#{Rails.root}/public/images/gabe_image.jpg"), filename: "gabe_image.jpg")

# Journals
ju1 = u1.journals.new( title: "Ol Zealand",
                       slug: "ol-zealand",
                       description: "New Zealand",
											 status: 1)
ju12 = u1.journals.new( title: "Himalayan Bikepacking",
                       slug: "bike-climbing-in-nepal",
                       description: "Nepal",
											 status: 1
											)
ju2 = u2.journals.new( title: "Shogun",
                       slug: "shogun",
                       description: "Japan",
											 status: 2)



ju1.save!
ju2.save!
ju12.save!
ju1.banner_image.attach(io: File.open("#{Rails.root}/public/images/patagonia.jpg"), filename: "patagonia.jpg" )
ju12.banner_image.attach(io: File.open("#{Rails.root}/public/images/himalayas.jpg"), filename: "himalayas.jpg" )
ju2.banner_image.attach(io: File.open("#{Rails.root}/public/images/japan.jpeg"), filename: "japan.jpeg" )
ju1d = ju1.build_distance(kilometer_amount: 0, mile_amount: 0)
ju2d = ju2.build_distance(kilometer_amount: 0, mile_amount: 0)
ju12 = ju12.build_distance(kilometer_amount: 0, mile_amount: 0)
ju1d.save!
ju2d.save!
ju12.save!


# Chapters
cj1 = ju1.chapters.new( title: "The Initial Push-Off", slug: "chapter-1", description: "On the open road", published: true)
c2j1 = ju1.chapters.new( title: "Undeniable Wind", slug: "chapter-1", description: "Second day out in argentina")
ju1.chapters.create( title: "Chapter 3", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 4", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 5", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 6", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 7", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 8", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 9", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 10", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 11", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 12", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 13", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 14", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 15", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 16", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 17", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 18", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 19", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 20", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 21", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 22", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 23", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 24", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 25", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 26", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 27", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 28", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 29", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 30", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 31", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 32", slug: "chapter-1", description: "Second day out in argentina")
# ju1.chapters.create( title: "Chapter 33", slug: "chapter-1", description: "Second day out in argentina")

cj2 = ju2.chapters.new( title: "Chapter 1", slug: "chapter-1", description: "First day out on the silk road", published: true)
cj1.save!
c2j1.save!
cj2.save!
cj1.banner_image.attach(io: File.open("#{Rails.root}/public/images/journal_1_image.png"), filename: "journal_1_image.png")
c2j1.banner_image.attach(io: File.open("#{Rails.root}/public/images/journal_2_image.jpg"), filename: "journal_2_image.jpg")
cj2.banner_image.attach(io: File.open("#{Rails.root}/public/images/journal_1_image.png"), filename: "journal_1_image.png")

# Chapter Distance
cj1d = cj1.build_distance(kilometer_amount: 78, mile_amount: 78 * 0.6)
cj1d.save!

c2j1d = c2j1.build_distance(kilometer_amount: 45,  mile_amount: 45 * 0.6)
c2j1d.save!

cj2d = cj2.build_distance(kilometer_amount: 108,  mile_amount: 108 * 0.6)
cj2d.save!

cj1.blog_images.attach(io: File.open("#{Rails.root}/public/images/abel_tasman.jpg"), filename: "abel_tasman")
cj1.blog_images.attach(io: File.open("#{Rails.root}/public/images/openraod8.jpg"), filename: "openraod8")
cj1.blog_images.attach(io: File.open("#{Rails.root}/public/images/crownrange4.jpg"), filename: "crownrange")
cj1.blog_images.attach(io: File.open("#{Rails.root}/public/images/facebooker7.jpg"), filename: "facebooker7")
cj1.blog_images.attach(io: File.open("#{Rails.root}/public/images/westcoastal.jpg"), filename: "westcoastal")
cj1.blog_images.attach(io: File.open("#{Rails.root}/public/images/victorybuurs18.jpg"), filename: "victorybuurs")

chapter_1_blog_entries = [
    {
      content: "We took the initial path far from where we had ever thought I didn't think it was going to be an adventure worth sticking around for but here we are anyway",
      styles: "",
      type: "text"
    },
    {
      id: cj1.blog_images.first.id,
      filename: "abel_tasman",
      uri: Rails.application.routes.url_helpers.url_for(cj1.blog_images.first),
      type: "image",
      localUri: "none",
      aspectRatio: 1,
      caption: "Abel tasman, so hot right now"
    },
    {
      content: "Do not ask what you can do for your country, as your country doesn't wan't to do it for you.",
      style: "QUOTE",
      type: "text"
    },
    {
      id: cj1.blog_images.second.id,
      filename: "abel_tasman",
      uri: Rails.application.routes.url_helpers.url_for(cj1.blog_images.second),
      type: "image",
      localUri: "none",
      aspectRatio: 1,
      caption: "The crown range was a big ol bitch, but not in a sexist type of way"
    },
    {
      id: cj1.blog_images.third.id,
      filename: "abel_tasman",
      uri: Rails.application.routes.url_helpers.url_for(cj1.blog_images.third),
      type: "image",
      localUri: "none",
      aspectRatio: 1,
      caption: "Abel tasman, so hot right now"
    },
    {
      content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus urna. Sodales neque sodales ut etiam. Tincidunt ornare massa eget egestas purus. Morbi tristique senectus et netus et malesuada fames ac. At ultrices mi tempus imperdiet nulla malesuada pellentesque elit eget. Adipiscing at in tellus integer feugiat scelerisque varius. Viverra adipiscing at in tellus integer. Amet nisl suscipit adipiscing bibendum est ultricies integer quis. Adipiscing elit pellentesque habitant morbi tristique senectus. Ut venenatis tellus in metus vulputate eu. In arcu cursus euismod quis viverra.

Nec feugiat in fermentum posuere urna nec tincidunt praesent semper. Tristique senectus et netus et. Malesuada fames ac turpis egestas sed. Augue mauris augue neque gravida in fermentum et sollicitudin ac. Urna molestie at elementum eu facilisis. Placerat duis ultricies lacus sed turpis tincidunt. Aenean et tortor at risus viverra adipiscing at. Sed arcu non odio euismod lacinia at quis risus sed. Tellus orci ac auctor augue mauris augue neque. Aliquam id diam maecenas ultricies. Adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus. Vel pretium lectus quam id leo. Integer feugiat scelerisque varius morbi. Enim ut tellus elementum sagittis vitae. Elementum pulvinar etiam non quam lacus suspendisse. Faucibus scelerisque eleifend donec pretium vulputate sapien.

Proin fermentum leo vel orci porta. At tempor commodo ullamcorper a lacus vestibulum. Amet luctus venenatis lectus magna fringilla urna porttitor. Netus et malesuada fames ac. Consectetur purus ut faucibus pulvinar elementum integer enim. Euismod elementum nisi quis eleifend quam adipiscing vitae. Scelerisque varius morbi enim nunc faucibus a pellentesque sit. Nunc eget lorem dolor sed viverra. Id semper risus in hendrerit gravida. Volutpat blandit aliquam etiam erat velit. Interdum consectetur libero id faucibus nisl. Dui id ornare arcu odio ut. Eget arcu dictum varius duis. Consectetur a erat nam at lectus. Massa enim nec dui nunc. Ipsum suspendisse ultrices gravida dictum fusce ut placerat orci. Faucibus interdum posuere lorem ipsum dolor sit amet consectetur.

Etiam erat velit scelerisque in dictum non consectetur a. Adipiscing commodo elit at imperdiet dui accumsan sit amet nulla. Est pellentesque elit ullamcorper dignissim cras tincidunt lobortis. Metus vulputate eu scelerisque felis imperdiet. In nisl nisi scelerisque eu ultrices. Aliquet nec ullamcorper sit amet risus nullam eget. Sit amet luctus venenatis lectus magna fringilla urna porttitor rhoncus. Nunc non blandit massa enim nec. Molestie ac feugiat sed lectus vestibulum mattis ullamcorper. Mauris a diam maecenas sed enim ut sem viverra aliquet. Justo laoreet sit amet cursus sit. Metus dictum at tempor commodo ullamcorper a lacus. Elit duis tristique sollicitudin nibh sit amet commodo nulla.

Arcu non sodales neque sodales. Suspendisse in est ante in nibh mauris cursus mattis. Et leo duis ut diam. A condimentum vitae sapien pellentesque habitant morbi tristique. Gravida in fermentum et sollicitudin ac orci. Pulvinar elementum integer enim neque volutpat ac tincidunt. Purus gravida quis blandit turpis cursus in. Quis eleifend quam adipiscing vitae proin sagittis. Urna nec tincidunt praesent semper feugiat nibh sed. Risus viverra adipiscing at in tellus integer feugiat scelerisque varius. Dictum at tempor commodo ullamcorper a lacus vestibulum. Nibh sed pulvinar proin gravida. Tellus integer feugiat scelerisque varius morbi enim. Sed ullamcorper morbi tincidunt ornare. At augue eget arcu dictum. A iaculis at erat pellentesque.",
      type: "text",
      styles: ""      
    },
    {
      id: cj1.blog_images[3].id,
      filename: "facebooker7",
      uri: Rails.application.routes.url_helpers.url_for(cj1.blog_images[3]),
      type: "image",
      localUri: "none",
      aspectRatio: 1,
      caption: "Crown Royal"
    },
    {
      id: cj1.blog_images[4].id,
      filename: "westcoastal",
      uri: Rails.application.routes.url_helpers.url_for(cj1.blog_images[4]),
      type: "image",
      localUri: "none",
      aspectRatio: 1,
      caption: "Sometimes life on the road makes you give a big caption, that's a big caption if i have ever seen one and I am wondering if there will be a limit to how big these captions will be able to get because it seems like they are just gonna be getting bigger and bigger and bigger and bigger."
    },
    {
      text: "When it's all said and done, it will be said and then it will be done",
      styles: "H1",
      type: "text"
    },
    {
      id: cj1.blog_images[5].id,
      filename: "vicotrybuurs",
      uri: Rails.application.routes.url_helpers.url_for(cj1.blog_images[5]),
      type: "image",
      localUri: "none",
      aspectRatio: 1,
      caption: "WHATS DONE"
    }
  ]

cj1.update(content: chapter_1_blog_entries.to_json )  



# GearItems NOTE: This also creates a gear list
ju1gi1 = ju1.gear_items.create(title: "Patagonia Sweater", user_id: u1.id, price: 10000)
ju2gi2 = Journal.third.gear_items.create(title: "Ortlieb", user_id: u1.id, price: 1000 )
ju1gi1.product_image.attach(io: File.open("#{Rails.root}/public/images/travis_image.png"), filename: "travsproduct")
ju2gi2.product_image.attach(io: File.open("#{Rails.root}/public/images/gabe_image.jpg"), filename: 'patagucci') 

# Following
u1.followings.create(followed: u2) # user 1 follows user 2
u2.followings.create(followed: u1) # user 2 follows user 1
#
#
# Favorites | u1.favorites.map(&:favoriteables)
u1.favorites.create( favoriteable: ju1 )
u2.favorites.create( favoriteable: cj2 )
# Tags
tag1 = Tag.create(title: "Argentina")
tag2 = Tag.create(title: "Silk Road")

#Taggings
ju1.taggings.create(tag: tag1 )

ActiveRecord::Base.transaction do
  p 'begin creating the editor blobs'
  Chapter.all.each do |chapter|
    EditorBlob.create(blobable_type: chapter.class.to_s,
                      blobable_id: chapter.id,
                      draft_content: chapter.content,
                      final_content: chapter.content)
    p "success creating chaper #{chapter.id}'s blob"
    chapter.create_distance(kilometer_amount: 108,  mile_amount: 108 * 0.6)

  end
  p 'all done porting editor_blobs'
end

ActiveRecord::Base.transaction do
  p 'begin porting over the images'
  Chapter.all.each do |chapter|
    p "looking for images for chapter #{chapter.id}"
    chapter.blog_images.each do |blog_image|
      blog_image.update(name: 'images',
                        record_type: chapter.editor_blob.class.to_s,
                        record_id: chapter.editor_blob.id)
      p "blob image #{blog_image.id}
        now beings to #{blog_image.record_type}"
    end
  end
  p 'all done porting images'
end

comment_1 = Comment.create(commentable_type: "Chapter", commentable_id: c2j1.id, user_id: User.last.id, content: "Wow looks like an awesome trip, where else are you going to go")
comment_2 = Comment.create(commentable_type: "Comment", commentable_id: comment_1.id, user_id: User.first.id, content: "We are headed to Europe after this should be a good time!")
comment_3 = Comment.create(commentable_type: "Chapter", commentable_id: c2j1.id, user_id: User.first.id, content: "Anybody want to donate to my go fund me!?")

ActiveRecord::Base.transaction do
  CSV.foreach('db/data/countries.csv', headers: true) do |row|
    country = Country.create(country_code: row[0], latitude: row[1], longitude: row[2], name: row[3].lstrip)
    p "created #{country.name} #{country.country_code}"
  end
end 

nepal = Country.find_by_name("Nepal")
new_zealand = Country.find_by_name("New Zealand")
japan = Country.find_by_name("Japan")

p "#{nepal.name} , #{new_zealand.name}, #{japan.name}"

IncludedCountry.create(journal_id: Journal.first.id, country_id: new_zealand.id)
IncludedCountry.create(journal_id: Journal.second.id, country_id: japan.id)
IncludedCountry.create(journal_id: Journal.third.id, country_id: nepal.id)

Journal.all.each do |journal|
  journal.update_total_distance
  journal.create_editor_blob
  country = journal.countries.first
  journal.create_cycle_route(latitude: country.latitude, longitude: country.longitude, longitude_delta: 20.0, latitude_delta: 20.0)
  journal.chapters.each do |chapter|
    chapter.create_cycle_route(latitude: country.latitude, longitude: country.longitude, longitude_delta: 20.0, latitude_delta: 20.0, polylines: "[\"\",\"v{|_Fgiqi`@zgFwgA??htEwgAftEoo@|zFa`BvzF_`BhaHa`BxoPyiGdzFgxB`zFixBrfFwhDxyFqpCd`HopCvlGyhDrlGixBdyFgxBrrEqpCzxCwgApeC_`B`_Ba`BzkAwgAzkAoo@le@ygAxkAoo@le@gWxkAoo@px@oo@xkAoo@px@qo@px@wgArx@wgAdRgWdRoo@dRiW?gW?gW?gW?oo@?wgA?qo@?oo@ke@gWeR?sx@?qx@????vgA?hxB?vgA?xgA?vgA?vgA?no@je@no@dRhW?fW???????????????????????gW?iW?oo@?_`B?oo@?ixB?wgA?ixBfRgxBje@yhDje@_aEpx@aaEnx@aaEpx@aaEpx@iyEtkAiyEnx@_aEnx@yhDtkAyhDtkAwhDrkAyhDrkAqpCrkAgxBrkAqpClx@whDv~AyhDlx@yhDt~AwhDlx@yhDnkAyhDnkAwhDlx@aaEnkAaaEjx@yhDlkAopCjx@ixBbRopCde@ygAfe@_`Bde@gxBjx@ixBhx@_`Bde@qpChx@_`Bhx@a`Bhx@_`BjkAwgAfx@ygAfx@oo@jkAoo@hkAoo@l~Aoo@hkAiWh~AgWlqBgWldC?ldCgWjdCgWhdCgWhwC?fdC?ddC?djD?dpE?`pE?|uF?xhG?tuF?nhG?hhG?fuF?dbF?`bF?ztFvgAnzG``BhzGvgAdzGfxB|yG``BxyGfxBvfGhxBrfGfxB~mEppC|mEnpCxmEppC|zDxhDtmEpqFvzDxiGtzDhzHrzDhzHfmErrIlzDxjJx_FbcKfzDxjJdzDj{KbzDh{KtlErsLrlEj{KnlE`cKvyDrrItyD`cK|fDhzHftCziGd|A~`EriAhxBpiAno@fd@fW|v@?fd@?fd@?fd@?fd@?rQ?fd@???rQ?rQ?rQ?fd@?fd@gWfd@?fd@gWfd@?pQgWrQ?rQ??gW??rQ???????rQ???pQgW?fW??\",\"nqgrF_q}k`@tnBwgA??`|AixBliAwgA`|AgxBjiAa`B~{A_`B~{AixBbaC_`Bz{AgxB|{Aa`BlnBwgAz{AwgAjnBqo@x{Aoo@|`C?z`CgWjsC?zeD?hxD?vjE?reD?`xD?~wD?|wD?xwD?feDfWdjExgAbeDvgA|iEvgA~dD~_BjwD``BtiEfxBjrChxB`wDfxB`wDhxBjiEfxBxvDhxBxvDfxB`iEhxBrvDnpCddDxhDbdDppC`dDnpC|cDppC|cDnpCpqChxBnqCnpClqC``BjqCfxBvlBhxBtlB~_BvlB``BjzA~_BjzAvgAhzAvgArlBxgA`hAfWfzAno@fzAno@v~Bno@fzApo@tu@no@~gAno@lc@fW??fQ?????\",\"\"]")
  end
end






