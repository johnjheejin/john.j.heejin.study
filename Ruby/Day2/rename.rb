Dir.chdir("txts")
# 작업경로를 txts로 변경한다.
files = Dir.entries(Dir.pwd).reject {|name| name[0] == '.'}
# 현재 폴더에서 .으로 시작하는 애들을 제외하고 엔트리에 올린다.
# 이걸 하는 이유는 dir들을 제외한 것들에게만 수정을 가하기 위해서다.
# (.)PWD (..)UP DIRECTORY
files.each do |file|
	File.rename(file, "hello" + file)
	# rename(변경 전 이름, 변경 후 이름.)
end