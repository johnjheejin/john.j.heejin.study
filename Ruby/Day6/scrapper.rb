require 'mechanize'
require 'pry'
require 'csv' #comma seprated values

agent = Mechanize.new
agent.user_agent_alias = 'Windows Chrome'

page = agent.get('https://amazon.com')

# 요소검사를 통해 검색창을 찾아감

search_form = page.form

search_form['field-keywords'] = 'Easystore 8tb'

# 메인에서 검색하는 것 까지 넘겅감
# search_form.submit

#result_0 > div > div > div > div.a-fixed-left-grid-col.a-col-right > div.a-row.a-spacing-small

# 결과 페이지를 보자
page = search_form.submit

items = page.search('.s-result-item')

puts "list --"
items.each do |item|
	puts "#{item.css('h2').text}"
	puts "#{item.css('.a-offscreen').text}"


# 더불어서 이것을 저번에 배운 csv로 저장하기
	title = item.css('h2').text
	price = item.css('.a-offscreen').text

	CSV.open("./list.csv", "a+") do |csv|
		csv << [title,price]

	end
end
puts 'success'

# binding.pry