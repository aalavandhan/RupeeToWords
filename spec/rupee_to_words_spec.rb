require_relative "../lib/rupee_to_words.rb"

describe ToWords do
	context "with a whole number" do
		it "should return the number in words" do
			expect(123.to_words).to eq("One hundred and twenty three")
		end
	end

	context "with a floating number" do
		it "should return the number in words" do
			expect(123.to_words).to eq("One hundred and twenty three")
		end
	end
end
