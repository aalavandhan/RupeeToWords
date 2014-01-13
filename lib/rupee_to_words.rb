module RupeeToWords
	class CustomArray < Array
		def self.inject(array,initial,&block)
			array.each do |value|
				initial = block.call(initial,value,array.index(value))
			end
			initial
		end
	end
	def pad_with_zeros(times,number)
		"0"*times + number.to_s
	end
	def number_to_unique_string(n)
		unique_strings = {
			 1 => "One",
			 2 => "Two",
			 3 => "Three",
			 4 => "Four",
			 5 => "Five",
			 6 => "Six",
			 7 => "Seven",
			 8 => "Eight",
			 9 => "Nine",
			10 => "Ten",
			11 => "Eleven",
			12 => "Twelve",
			13 => "Thirteen",
			14 => "Fourteen",
			15 => "Fifteen",
			16 => "Sixteen",
			17 => "Seventeen",
			18 => "Eighteen",
			19 => "Nineteen",
			20 => "Twenty",
			30 => "Thirty",
			40 => "Forty",
			50 => "Fifty",
			60 => "Sixty",
			70 => "Seventy",
			80 => "Eighty",
			90 => "Ninety",
			100 => "Hundred",
			1000 => "Thousand",
			100000 => "Lakh",
			10000000 => "Crore"
		}
		!unique_strings[n].nil? ? unique_strings[n]+" " : nil
	end
	def map_part_to_power(number)
	 	map = {
	 		0 => 10000000,
	 		1 => 100000,
	 		2 => 1000,
	 		3 => 100
	 	}
	 	!map[number].nil? ? map[number] : " "
	end
	def break_into_parts(number)
		with_zeros = pad_with_zeros(9-number.to_s.length,number)
		parts =  with_zeros.match(/(\d{2})(\d{2})(\d{2})(\d{1})(\d{2})/).to_a
		parts.shift
		parts
	end
	def part_to_words(part,part_id)
		part_as_number = part.to_i
		units_place = part_as_number % 10
		tens_place = part_as_number - units_place
		(part_as_number != 0) ?
			(
				number_to_unique_string(part_as_number) ||
				number_to_unique_string(tens_place) + 
				number_to_unique_string(units_place)
			) +
			(number_to_unique_string(map_part_to_power(part_id)) || '')
		: ''
	end
	def number_to_words(number)
		number_string = number.to_s
		digits = number_string.length
		if digits<=9 
			parts = break_into_parts(number)
			result = CustomArray.inject(parts,"") do |partial_string,val,key|
				partial_string += part_to_words(val,key)
			end
		else
			result = number_to_unique_string(map_part_to_power(0)) + number_to_words(number_string.slice!(-7,7).to_i)
			result = number_to_words(number_string.to_i) + result
		end
		result
	end
	def pretify(hash)	
		pretified_string = ""	
		pretified_string += !hash[:rupees].to_i.equal?(0) ? "#{hash[:rupees_string]}Rupees " : ""
		pretified_string += !hash[:rupees].to_i.equal?(0) && !hash[:paise].to_i.equal?(0) ? "and " : ""
		pretified_string += !hash[:paise].to_i.equal?(0) ? "#{hash[:paise_string]}Paisa " : ""
		pretified_string += !pretified_string.empty? ? ",only." : ""
	end
	def to_words(number)
		number = number.abs
		rupees = number.to_i
		paise = ((number - number.to_i).round(2)*100).to_i
		total = {
			:rupees => rupees,
			:rupees_string => number_to_words(rupees),
			:paise => paise,
			:paise_string => number_to_words(paise)
		}
		pretify(total)
	end
end