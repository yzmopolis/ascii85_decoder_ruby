gem 'minitest', '~> 5.4'
require 'minitest/autorun'
require_relative '../ascii/ascii_decoder'


class AsciiTest < Minitest::Test
  def setup
    @ascii = Ascii
  end
  def test_decode_from_ascii85
    tst_1 = "<~6tL4RB5_g'Df,~>"
    tst_2 = "<~A7]UrB5_g'Df,~>"
    tst_3 = "<~Ao_TsDIdf2A8c?5F<GC6AH~>"
    tst_4 = "<~;eT_bBlbD,Eaa9>/g)l'~>"
    assert_equal("Demogorgon", @ascii.decode_from_ascii85(tst_1), "Error decode from ascii case 1")
    assert_equal("demogorgon", @ascii.decode_from_ascii85(tst_2), "Error decode from ascii case 2")
    assert_equal("friends don't lie", @ascii.decode_from_ascii85(tst_3), "Error decode from ascii case 3")
    assert_equal("She is crazy. 11", @ascii.decode_from_ascii85(tst_4), "Error decode from ascii case 4")
  end

  def test_encode_to_ascii85
    tst_1 = "Demogorgon"
    tst_2 = "demogorgon"
    tst_3 = "friends don't lie"
    tst_4 = "She is crazy. 11"
    assert_equal("<~6tL4RB5_g'Df,~>", @ascii.encode_to_ascii85(tst_1), "Error encode to ascii case 1")
    assert_equal("<~A7]UrB5_g'Df,~>", @ascii.encode_to_ascii85(tst_2), "Error encode to ascii case 2")
    assert_equal("<~Ao_TsDIdf2A8c?5F<GC6AH~>", @ascii.encode_to_ascii85(tst_3), "Error encode to ascii case 3")
    assert_equal("<~;eT_bBlbD,Eaa9>/g)l'~>", @ascii.encode_to_ascii85(tst_4), "Error encode to ascii case 4")
  end
end