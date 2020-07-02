namespace :dev do
  desc "Configura ambientes de desenvolvimento "
  task setup: :environment do


   puts 'Cadastrando Produtos...'

   100.times do |p|
    Product.create!(
      sku: "teste0"+(p+1).to_s,
      name: Faker::Lorem.sentence(4),
      description: Faker::Lorem.sentence(3, supplemental: true, random_words_to_add: 6),
      price: Faker::Number.decimal(2),
      promotional_price: Faker::Number.decimal(2),
      qty: Faker::Number.between(0, 99)
      )

  end
  puts 'Produtos Cadastrados com sucesso!'



  puts  'Criando Pedidos...'

  100.times do |i|
      #debugger
      statuses = ['new','canceled','approved','shipped','delivered']
      sku = "teste0"+(i+rand(1..100)).to_s
      Order.create!(
        code: "pedido-"+(i+1).to_s,
        data: Faker::Time.between(DateTime.now - 30, DateTime.now),
        custumer: Faker::Name.name,
        status: statuses.sample,
        shipping_cost: Faker::Number.decimal(2),
        items: [{"sku": sku,"qty": 2, "price":100.00}],
        total:  Faker::Number.decimal(2)
        )
    end
    puts 'Pediso Criados com sucesso!'

  end

end

