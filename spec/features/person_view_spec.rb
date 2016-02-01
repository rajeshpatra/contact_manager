require 'rails_helper'

describe 'the person view', type: :feature do

	let(:person) { Person.create(first_name: 'Rajesh', last_name: 'Patra') }

	before(:each) do
		person.phone_numbers.create(number: '555-1234')
		person.phone_numbers.create(number: '555-5678')
		visit person_path(person)
	end

	it 'shows the phone numbers' do
		person.phone_numbers.each do |phone|
			expect(page).to have_content(phone.number)
		end
	end

	it 'has a link to add phone number' do
		expect(page).to have_link('Add phone number', href: new_phone_number_path(person_id: person.id))
	end

	it 'adds a new phone number' do
		page.click_link('Add phone number')
		page.fill_in('Number', with: '555-8888')
		page.click_button('Create Phone Number')
		expect(current_path).to eq(person_path(person))
	end
end