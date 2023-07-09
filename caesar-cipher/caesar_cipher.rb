ALPHABET_LENGTH = 26

def encrypt_char(char, shift)
  offset = case char
    when /[a-z]/ then 'a'.ord
    when /[A-Z]/ then 'A'.ord
    else return char
  end
  ((char.ord - offset + shift) % ALPHABET_LENGTH + offset).chr
end

def caesar_cipher(string, shift)
  string.chars.map { |char| encrypt_char(char, shift) } .join('')
end
