require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items } 
    it { should have_many :items} 
  end

  describe 'class methods' do
    it 'has unique items' do
      kroagur = Supermarket.create!(name: 'Kroagur', location: 'Ohio')
      kingsloops = Supermarket.create!(name: 'King Sloopers', location: 'Colorado')

      item1a = Item.create!(name: 'cheese', price: 3)
      item1b = Item.create!(name: 'onion', price: 2)
      item1c = Item.create!(name: 'pepper', price: 1)
      item2a = Item.create!(name: 'rice', price: 4)
      item2b = Item.create!(name: 'couscous', price: 2)
      item2c = Item.create!(name: 'quinoa', price: 3)

      steve = kroagur.customers.create!(name: 'Steve')
      sally = kroagur.customers.create!(name: 'Sally')

      CustomerItem.create!(customer_id: steve.id, item_id: item1a.id)
      CustomerItem.create!(customer_id: steve.id, item_id: item1b.id)
      CustomerItem.create!(customer_id: sally.id, item_id: item2a.id)
      CustomerItem.create!(customer_id: sally.id, item_id: item2b.id)
      CustomerItem.create!(customer_id: sally.id, item_id: item1a.id)

      expect(kroagur.unique_items).to eq([item1a, item1b, item2a, item2b])
    end
  end
end