Dir.chdir("files") # files 라는 폴더로 파일 경로를 변경한다.

3.times do |n| 
# 3번 실행하는데 이 전체 구문에서 n이라는 변수가 있다.
	n += 1 
	# n은 이후 1이 더해진 값이 된다.
	File.open(n.to_s + ".txt","w") do |file| 
	# n녀석의 글자를 딴것과 .txt 를 합쳐 파일을 저장하면서 연다. 그러면서 취할 행동이 있으며, 이때 이를 file이라 부른다.
		file.write(n.to_s + "번째 txt") 
		# file안에 n녀석의 글자를 딴것과 번째 txt를 합친것을 작성한다.
	end
end