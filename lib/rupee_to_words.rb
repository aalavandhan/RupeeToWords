module ToWords
  def to_words
    number = self
    parts = break_into_parts(number)
    parts.inject("") do |partial_string, val|
      partial_string += part_to_words(val, parts.index(val)) if val.to_i != 0
    end
  end

private
  #pw(5,1) -> "00001"
  def pad_with_zeros(times,number)
    "0"*times + number.to_s
  end

  def number_to_unique_string(n)
    {
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
    }[n] rescue nil
  end

  #map broken part to number string
  def map_part_to_denomination(number)
    {
      0 => 10000000,
      1 => 100000,
      2 => 1000,
      3 => 100,
      4 => nil
    }[number] rescue nil
  end

  #breaks number into parts 123 -> ["00", "00", "00", "1", "17"]
  def break_into_parts(number)
    with_zeros = pad_with_zeros(9 - number.to_s.length, number)
    parts =  with_zeros.match(/(\d{2})(\d{2})(\d{2})(\d{1})(\d{2})/).to_a
    parts.shift
    parts
  end

  def part_to_words(part, part_id)
    digits = part.split('')
    (
      number_to_unique_string(part.to_i) ||
      ( number_to_unique_string(part.to_i - digits.last.to_i) + number_to_unique_string(digits.last.to_i) )
    ) +
    ( number_to_unique_string(map_part_to_denomination(part_id)) || '' )
  end
end

Numeric.send(:include, ToWords)
