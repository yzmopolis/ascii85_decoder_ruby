module Ascii
  MAGIC_NUMBER = 33
  MAGIC_DIVISOR = 85

  def self.decode_from_ascii(block)
    "not ready"
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


# puts Ascii.decode_from_ascii("<~Bkq,~>")
puts Ascii.encode_to_ascii85('bitchin')