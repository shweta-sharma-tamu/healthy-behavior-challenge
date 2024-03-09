# frozen_string_literal: true

When('I click on link {string} of {string}') do |button, element|
	
	follow button
end

Then('I should be redirected to view task table page for {string}') do |element|
	pending
end

When('I log {string} for {string}') do |value, entry|
	pending
end

Then('I should see {string} logged for {string}') do |value, entry|
	pending
end

