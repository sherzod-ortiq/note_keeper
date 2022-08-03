require 'rails_helper'

RSpec.describe ::Api::V1::NotesController, type: :controller do

	before(:all) do
		@note = create(:note) # using factory_bot_rails
	end
	
	after(:all) do
		@note.destroy
	end

	describe "POST #create" do

		context "when note name and description are empty" do
			let (:note) {Note.new} # let block is run only when the variable is called, before(:each) block is run whenever exaple is run
	
			it "should not be saved" do
				post :create, params: {note: {name: note.name, description: note.description}}, format: :json
				expect(response.body["errors"].present?).to be(true)
			end
	
		end
	
		context "when note name and description are not empty" do
			let (:note) {Note.new(name: "Name2", description:"Description2")}
				
			it "should be saved" do
				post :create, params: {note: {name: note.name, description: note.description}}, format: :json
				expect(response.body["errors"].present?).to be(false)
			end
		end
		
	end

	describe "PATCH #update" do
  
		context "when note name is not empty" do
			it "should be different" do
				old_name = @note.name
				patch :update, params: {id: @note.id, note: {name: "Name3"}}, format: :json
				@note.reload
				expect(@note.name).not_to eql(old_name)
			end
		end
  
	end

end
