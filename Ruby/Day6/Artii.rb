require "artii"

a = Artii::Base.new font: 'slant'
puts a.asciify 'Bot!'

def asciify(text, font)
	a = Artii::Base.new font: "#{font}"
	puts a.asciify "#{text}"
end

puts '언제나 더불어 입력해서 출력해보기'
puts 'text 입력'
text= gets.chomp!
puts 'font 입력'
font =gets.chomp!

asciify(text,font)