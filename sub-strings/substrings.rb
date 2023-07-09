def count_occurences(substring, string)
  substring = substring.downcase
  string = string.downcase
  count = 0
  m = string.match(substring)
  while m
    count += 1
    string = string[m.end(0)..-1]
    m = string.match(substring)
  end
  count
end

def substrings(string, dictionary)
  dictionary.reduce(Hash.new(0)) do |substrings_hash, word|
    count = count_occurences(word, string)
    substrings_hash[word] = count if count > 0
    substrings_hash
  end
end
