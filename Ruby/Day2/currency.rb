require 'eu_central_bank' #다른 환율 gem도 많지만, 제일 굳건해 보이는 이름.
 
bank = EuCentralBank.new # 은행 객체생성

from = 'USD'
to = 'KRW'

bank.update_rates # 은행 객체에 환율정보를 업뎃해줘

result = bank.exchange(100, from , to)
# 100 cent = 1 dollar 를 from에서 to로

puts "#{from} 1 => #{to} #{result}"