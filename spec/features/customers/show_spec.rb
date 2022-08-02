require 'rails_helper'

RSpec.describe 'Customer Show Page' do
    it 'displays a list of its items and the name of the supermarket that it belongs to' do
        kroagur = Supermarket.create!(name: 'Kroagur', location: 'Ohio')
        kingsloops = Supermarket.create!(name: 'King Sloopers', location: 'Colorado')

        item1a = Item.create!(name: 'cheese', price: 3)
        item1b = Item.create!(name: 'onion', price: 2)
        item1c = Item.create!(name: 'pepper', price: 1)
        item2a = Item.create!(name: 'rice', price: 4)
        item2b = Item.create!(name: 'couscous', price: 2)
        item2c = Item.create!(name: 'quinoa', price: 3)

        steve = kroagur.customers.create!(name: 'Steve')
        sally = kingsloops.customers.create!(name: 'Sally')

        CustomerItem.create!(customer_id: steve.id, item_id: item1a.id)
        CustomerItem.create!(customer_id: steve.id, item_id: item1b.id)
        CustomerItem.create!(customer_id: sally.id, item_id: item2a.id)
        CustomerItem.create!(customer_id: sally.id, item_id: item2b.id)

        visit "/customers/#{steve.id}"

        expect(page).to have_content(kroagur.name)
        expect(page).to_not have_content(kingsloops.name)

        within("#item-#{item1a.id}") do
            expect(page).to have_content(item1a.name)
            expect(page).to_not have_content(item2a.name)
        end
       
        within("#item-#{item1b.id}") do
            expect(page).to have_content(item1b.name)
            expect(page).to_not have_content(item2b.name)
        end

        expect(page).to_not have_content(item1c.name)
        expect(page).to_not have_content(item2c.name)
    end
end