# 검색하는 시퀀스
# 1 아마존에 접속한다
# 2 검색어를 입력한다
# 3 가격을 본다
# 4 엑셀에 입력한다

require 'mechanize'

agent = Mechanize.new
# alias : 가명
agent.user_agent_alias = 'Mac Safari'
# user agent를 지정한다.

page = agent.get 'https://amazon.com'