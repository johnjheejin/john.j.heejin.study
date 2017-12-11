require 'eu_central_bank' #다른 환율 gem도 많지만, 제일 굳건해 보이는 이름.

def dollarExchange(to)
	# 은행 객체생성
	bank = EuCentralBank.new
	bank.update_rates
	# 은행 객체에 환율정보를 업뎃해줘

	return bank.exchange(100, 'USD', to)
	# 100 cent = 1 dollar 를 from에서 to로
	# return 없어도 됨 ㄷㄷ; 당연히 마지막이 리턴이겟거니
end

# def 정의한수이름(인자)
# 내용내용
# (return)반환값
# end

puts "USD 1 => KRW #{dollarExchange('KRW')}"