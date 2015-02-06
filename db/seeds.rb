# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:  "Example User",
 email: "facebook12636@gmail.com",
 password:              "301464965",
 password_confirmation: "301464965",
 admin: true,
 activated: true,
 activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
   email: email,
   password:              password,
   password_confirmation: password)
end
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

#-------------------------------------------------------------
request = Vacuum.new('GB')
request.configure(
  aws_access_key_id: 'AKIAJDZH3GMBKE3KWUCQ',
  aws_secret_access_key: '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',
  associate_tag: 'tag'
  )

ArrayCategory = ['RAM','VGA','CPU','HDD']
ArrayCategory.each do |category|
  category_obj = Category.create!(name: category)

  params = {
    'SearchIndex' => 'All',
    'Keywords'=> category.downcase,
    'ResponseGroup' => "ItemAttributes,Images,Offers",
    'MerchantId' => 'All'
  }

  raw_products = request.item_search(query: params)
  hashed_products = raw_products.to_h
  return unless hashed_products

  hashed_products['ItemSearchResponse']['Items']['Item'].each do |item|
    if item
      begin

        product = Product.create!(name: item['ItemAttributes']['Title'],
          amount: item['Offers']['Offer']['OfferListing']['Price']['Amount'],
          currencycode: item['Offers']['Offer']['OfferListing']['Price']['CurrencyCode'],
          formattedprice: item['Offers']['Offer']['OfferListing']['Price']['FormattedPrice'],
          image_url: item['MediumImage']['URL'],
          description: 'test',
          status:'test')
        puts 'save successfull !!!'
        product.product_categories.create!(category_id: category_obj.id)
      rescue Exception
        puts Exception.inspect
      end
    end
  end
end







#-------------------------------------------------------------