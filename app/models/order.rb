class Order
  include Mongoid::Document
  field :code, type: String
  field :data, type: DateTime
  field :custumer, type: String
  field :status, type: String
  field :shipping_cost, type: Float
  field :total, type: Float
  embeds_many :items

  validates :items, presence: true



end