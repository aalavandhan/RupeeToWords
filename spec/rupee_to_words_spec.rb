require_relative "../lib/rupee_to_words.rb"

describe RupeeToWords do
	class Test
		extend RupeeToWords
	end
	context do
		it "should convert 10 to Ten Rupees only" do
			Test.to_words(10).should eq("Ten Rupees ,only.")
		end
		it "should convert 100.1 to Hundred Rupees and thirty five paisa only" do
			Test.to_words(100.1).should eq("One Hundred Rupees and Ten Paisa ,only.")
		end
		it "should convert 1,12,33,02,344 to Hundred and twelve crore thiry three lakh two thousand three hundred and forty four only" do
			Test.to_words(1123302344).should eq("One Hundred Twelve Crore Thirty Three Lakh Two Thousand Three Hundred Forty Four Rupees ,only.")
		end	
	end
end