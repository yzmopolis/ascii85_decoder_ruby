module Ascii
  def Ascii.decode_from_ascii(code)
    puts "decode"
  end
  def Ascii.encode_to_ascii85(str)
    puts "code"
  end
end

Ascii.encode_to_ascii85("ika")
Ascii.decode_from_ascii("<~Bkq,~>")