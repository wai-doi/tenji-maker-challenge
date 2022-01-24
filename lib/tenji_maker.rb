class TenjiMaker
  def to_tenji(text)
    tenjis = text
      .split
      .map { |alphabet| RomanAlphabet.new(alphabet).tenji }

      format_horizontally(tenjis)
  end

  private

  def format_horizontally(tenjis)
    tenjis.transpose.map{ _1.join(' ') }.join("\n")
  end
end

class RomanAlphabet
  BOIN_TABLE = {
    'A' => [0],
    'I' => [0, 1],
    'U' => [0, 3],
    'E' => [0, 1, 3],
    'O' => [1, 3]
  }

  SIIN_TABLE = {
    'K' => [5],
    'S' => [4, 5],
    'T' => [2, 4],
    'N' => [2],
    'H' => [2, 5],
    'M' => [2, 4, 5],
    'R' => [4]
  }

  SPECIAL_TABLE = {
    'YA' => [2, 3],
    'YU' => [2, 3, 5],
    'YO' => [2, 3, 4],
    'WA' => [2],
    'N' => [2, 4, 5]
  }

  DOT_SYMBOL = 'o'
  BLANK_SYMBOL = '-'

  def initialize(alphabet)
    @alphabet = alphabet
  end

  def tenji
    tenji_symbols.each_slice(3).to_a.transpose.map(&:join)
  end

  private

  def tenji_symbols
    Array.new(6) { |i| dot_positions.include?(i) ? DOT_SYMBOL : BLANK_SYMBOL }
  end

  def dot_positions
    SPECIAL_TABLE[@alphabet] || BOIN_TABLE[@alphabet] || BOIN_TABLE[@alphabet[1]] + SIIN_TABLE[@alphabet[0]]
  end
end
