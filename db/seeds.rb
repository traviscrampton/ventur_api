# users
u1 = User.create(email: "crampton.travis@gmail.com", first_name: "Travis", last_name: "Crampton", password: "travis12")
u2 = User.create(email: "gabeleoni@gmail.com", first_name: 'Gabe', last_name: 'Leoni', password: "travis12")

# profile infos
profile_info_u1 = u1.build_profile_info( bio:'here is a bio for user 1')
profile_info_u2 = u2.build_profile_info( bio:'here is a bio for user 2')
profile_info_u1.save!
profile_info_u2.save!
profile_info_u1.avatar.attach(io: File.open("#{Rails.root}/public/images/travis_image.png"), filename: "travis_image.png")
profile_info_u2.avatar.attach(io: File.open("#{Rails.root}/public/images/gabe_image.jpg"), filename: "gabe_image.jpg")

# Journals
ju1 = u1.journals.new( title: "World's End By-Cycle",
                       slug: "patagonia-by-cycle",
                       description: "Patagonia, Chile",
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
ju1d = ju1.build_distance(amount: 0)
ju2d = ju2.build_distance(amount: 0)
ju12 = ju12.build_distance(amount: 0)
ju1d.save!
ju2d.save!
ju12.save!


# Chapters
cj1 = ju1.chapters.new( title: "The Initial Push-Off", slug: "chapter-1", description: "First day out in argentina")
c2j1 = ju1.chapters.new( title: "Undeniable Wind", slug: "chapter-1", description: "Second day out in argentina")
cj2 = ju2.chapters.new( title: "Chapter 1", slug: "chapter-1", description: "First day out on the silk road")
cj1.save!
c2j1.save!
cj2.save!
cj1.image.attach(io: File.open("#{Rails.root}/public/images/journal_1_image.png"), filename: "journal_1_image.png")
c2j1.image.attach(io: File.open("#{Rails.root}/public/images/journal_2_image.jpg"), filename: "journal_2_image.jpg")
cj2.image.attach(io: File.open("#{Rails.root}/public/images/journal_1_image.png"), filename: "journal_1_image.png")

# Chapter Distance
cj1d = cj1.build_distance(amount: 78)
cj1d.save!

c2j1d = c2j1.build_distance(amount: 45)
c2j1d.save!

cj2d = cj2.build_distance(amount: 108)
cj2d.save!

# GearItems NOTE: This also creates a gear list
ju1gi1 = ju1.gear_items.create(title: "Patagonia Sweater", price: 10000, product_image: File.open("#{Rails.root}/public/images/travis_image.png") )
ju2gi2 = ju2.gear_items.create(title: "Ortlieb", price: 1000, product_image: File.open("#{Rails.root}/public/images/gabe_image.jpg") )
#
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

Journal.all.each { |j| j.update_total_distance}
