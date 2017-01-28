
lines= File.readlines(ARGV[0])#array
line_count=lines.size  
text=lines.join #string

#Count the characters
character_count=text.length
character_count_nospaces=text.gsub(/\s+/, '').length

#Count the words, sentences, and paragraphs
word_count = text.split.length
sentence_count=text.split(/\.|\?|!/).length
paragraph_count= text.split(/\n\n/).length

#Make a list of words in the text that aren't stop words,
#count them, and work out the percentage of non-stop words
# against all words
stop_words= %w{the a by on for of are with just but and to my I has some in}
all_words=text.scan(/\w+/)
good_words= all_words.select {|word| !stop_words.include? (word)}
good_percentage=((good_words.length.to_f/all_words.length.to_f)*100).to_i

#Summarize the text by cherry picking some choice sentences
sentences=text.gsub(/\s+/,' ').strip.split(/\.|\?|\!/)
sentences_sorted=sentences.sort_by {|sentence| sentence.length}
one_third=sentences.length/3
ideal_sentences=sentences_sorted.slice(one_third,one_third+1)
ideal_sentences=ideal_sentences.select {|sentence| sentence=~ /is|are/}

#Give the analysiis backt to the user
puts "line count: #{line_count}"
puts "character count: #{character_count}"
puts "character count(no spaces) #{character_count_nospaces}"
puts "word count: #{word_count}"
puts "sentence count: #{sentence_count}"
puts "paragraph count: #{paragraph_count}"
puts "Average number of sentences per paragraph: #{sentence_count/paragraph_count}"
puts "Average number of words per sentence: #{word_count/sentence_count}"
puts "#{good_percentage}% of words are non-fluff words"
puts "Summary:\n\n"+ideal_sentences.join(". ")
puts "--End of analysis"
