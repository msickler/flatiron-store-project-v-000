class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def add_item(item)
    if line_item = self.line_items.find_by(item_id: item)
      line_item.quantity += 1
    else
      line_item = self.line_items.build(item_id: item)
    end
    line_item
  end

  def checkout
    self.line_items.each do |line_item|
      line_item.item.inventory -= line_item.quantity
      line_item.item.save
      
    end
    self.status = 'submitted'
    self.line_items = []
    user = self.user
    user.remove_cart
  end

  def total
    self.line_items.map { |li| li.item.price * li.quantity}.sum
  end
end
