# txts, file-again
# 폴더는 txts
# 파일 제목은 1.txt 2.txt
# 파일내용에 '좋은 아침입니다!'
Dir.chdir ("txts") 
2.times do |n|
	# do 를 한건데 여기서만 쓰일 기본변수를 n를 지칭한다.
	# 여기서 기본변수는 쉽게 변경할 수 있다.
	n+=1
	File.open(n.to_s + ".txt", "w") do |file|
		file.write("좋은 아침입니다!")
	end
end