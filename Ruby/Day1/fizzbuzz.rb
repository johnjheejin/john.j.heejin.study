# 문제
#1 숫자를 세서 올라가는데,
#2 3의 배수는 fizz
#3 5의 배수는 buzz
#4 15의 배수는 fizz buzz가 되어야한다.

message = "fizzbuzz game"
puts message

# 풀이
#0 머릿속으로 숫자를 생각한다,
#4 15의 배수는 fizz buzz가 되어야한다.
#2 3의 배수는 fizz
#3 5의 배수는 buzz
#1 숫자를 세서 올라가는데,

for i in 1..15
	# i라는 변수가 1에서 15까지 증가한다.
    if i%3 == 0 && i%5 == 0
        puts "fizzbuzz"

        elsif i%3 == 0
            puts "fizz"
        elsif(i%5 == 0)
            puts "buzz"
        else
        	puts i
    end
end