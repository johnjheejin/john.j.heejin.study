def exchange(from,to)
	bank = EuCentralBank.new
	bank.update_rates

	return bank.exchange(100, from, to)
	# return 없어도 됨 ㄷㄷ; 당연히 마지막이 리턴이겟거니
end
