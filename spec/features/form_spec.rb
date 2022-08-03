require 'rails_helper'

RSpec.feature "Forms", type: :feature, js: true do

	before(:all) do
		options = Selenium::WebDriver::Firefox::Options.new
		options.add_argument('--headless') # For proper launch of firefox browser in container.
		@driver = Selenium::WebDriver.for :firefox, options: options
		@wait = Selenium::WebDriver::Wait.new(timeout: 20) # seconds
	end

	after(:all) do
		@driver.quit
	end

	describe "GET #read" do

		context "when loaded root page first time" do
	
			it "should have title" do
				@driver.navigate.to "http://localhost:3000"
				# Sor some reason selenium web driver is fully loading web page only after actions like taking screenshot or running:
				# @driver.manage.window.resize_to(300, 600) or @driver.manage.window.move_to(300, 400).
				# There could be other methods wich can help to load page properly in order tests to past successfully.
				# Workaround for now is taking screenshots.
				@driver.save_screenshot("./spec/fixtures/selenium_screenshots/screenshot1.png")
				title = @wait.until { @driver.find_element(name: 'title') }
				expect(title.text).to eql("Note keeper")
			end

		end

	end

	describe "POST #create" do

		context "when invalid" do

			it "should have error message" do
				@driver.navigate.to "http://localhost:3000"
				@driver.save_screenshot("./spec/fixtures/selenium_screenshots/screenshot2.png")
				note_name = @wait.until { @driver.find_element(name: "name") }
				note_description = @driver.find_element(name: "description")
				note_name.send_keys "name1"
				note_description.send_keys ""
				note_name.submit
				note_error = @wait.until { @driver.find_element(id: "note-error") }
				@driver.save_screenshot("./spec/fixtures/selenium_screenshots/screenshot3.png")
				expect(note_error.text).to eql("Error has occured")
			end

		end

		context "when valid" do
	
			it "should not have error message" do
				@driver.navigate.to "http://localhost:3000"
				@driver.save_screenshot("./spec/fixtures/selenium_screenshots/screenshot4.png")
				note_name = @wait.until { @driver.find_element(name: "name") }
				note_description = @driver.find_element(name: "description")
				note_name.send_keys "name1"
				note_description.send_keys "description1"
				note_name.submit
				@driver.save_screenshot("./spec/fixtures/selenium_screenshots/screenshot5.png")
				note_error = @driver.find_element(id: "note-error")
				expect(note_error.text).to eql("")
			end

		end

	end

	describe "PATCH #update" do

		context "when invalid" do

			it "should have error message" do
				@driver.navigate.to "http://localhost:3000"
				@driver.save_screenshot("./spec/fixtures/selenium_screenshots/screenshot6.png")
				notes = @wait.until { @driver.find_elements(class: "note") }
				note = notes[0]
				edit_button = note.find_element(class: "edit-button")
				edit_button.click
				submit_button = edit_button
				note_name = note.find_element(name: "name")
				note_description = note.find_element(name: "description")
				note_name.send_keys "name1"
				note_description.send_keys ""
				submit_button.click
				@driver.save_screenshot("./spec/fixtures/selenium_screenshots/screenshot7.png")
				note_error = @driver.find_element(id: "note-error")
				expect(note_error.text).to eql("")
			end

		end

		context "when valid" do

			it "should not have error message" do
				@driver.navigate.to "http://localhost:3000"
				@driver.save_screenshot("./spec/fixtures/selenium_screenshots/screenshot8.png")
				notes = @wait.until { @driver.find_elements(class: "note") }
				note = notes[0]
				edit_button = note.find_element(class: "edit-button")
				edit_button.click
				submit_button = edit_button
				note_name = note.find_element(name: "name")
				note_description = note.find_element(name: "description")
				note_name.send_keys "name1"
				note_description.send_keys "description1"
				submit_button.click
				@driver.save_screenshot("./spec/fixtures/selenium_screenshots/screenshot9.png")
				note_error = @driver.find_element(id: "note-error")
				expect(note_error.text).to eql("")
			end

		end

	end

	describe "DELETE #delete" do

		it "should delete" do
			@driver.navigate.to "http://localhost:3000"
			@driver.save_screenshot("./spec/fixtures/selenium_screenshots/screenshot10.png")
			@wait.until { @driver.find_elements(class: "note") }
			notes = @driver.find_elements(class: "note")
			note = notes[0]
			note_count_before = notes.count
			delete_button = note.find_element(class: "delete-button")
			delete_button.click
			notes = @wait.until { @driver.find_elements(class: "note") }
			note_count_after = notes.count
			@driver.save_screenshot("./spec/fixtures/selenium_screenshots/screenshot11.png")
			expect(note_count_before).to eql(note_count_after + 1)
		end

	end
			
end
