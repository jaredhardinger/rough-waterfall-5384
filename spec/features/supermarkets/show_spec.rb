require 'rails_helper'

RSpec.describe 'Supermarket Show Page' do
    it "displays the name of the supermarket and has a 'view all items' link that
    takes you to the supermarkets index page" do
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

        visit "/supermarkets/#{kroagur.id}"

        expect(page).to have_content(kroagur.name)
        
        within("#item-index-link") do 
            expect(page).to have_link("view all items")

            click_link("view all items")
        end
        expect(current_path).to eq("/supermarkets/#{kroagur.id}/items")
    end
end