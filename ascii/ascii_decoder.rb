module Ascii
  MAGIC_NUMBER = 33
  MAGIC_DIVISOR = 85

  def self.decode_from_ascii85(code)
    asc = code[2..-3].gsub('z', '!!!!!').delete(' ').delete("\n").delete("\t")
    my_bits = (5 - asc.size % 5) % 5
    my_nums = (asc + 'u' * my_bits).chars.map { |char| char.ord - MAGIC_NUMBER }
    str = ''
    until my_nums.empty?
      a = my_nums.shift(5)
      b = a.map.with_index { |val, i| val * MAGIC_DIVISOR**(4 - i) }.inject(:+).to_s(2).rjust(32, '0').chars
      4.times do
        str += b.shift(8).join.to_i(2).chr
      end
    end
    str[0..-1 - my_bits]
  end

  def self.encode_to_ascii85(string)
    bit = string.chars.map{ |c| c.ord.to_s(2).rjust(8, '0') }
    bits = (4 - bit.size % 4) % 4
    bit += ['0' * 8] * bits
    code = ''
    until bit.empty?
      my_bit = bit.shift(4).join.to_i(2)
      4.downto(0) do |i|
        code += (my_bit / MAGIC_DIVISOR**i + MAGIC_NUMBER).chr
        my_bit %= MAGIC_DIVISOR**i
      end
    end
    '<~' + code[0..-1 - bits].gsub(/(^|(?<=.{5})+)!{5}(?=.)*/, 'z') + '~>'
  end

end