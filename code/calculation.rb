a=File.open(ARGV[0])
a.each_line do |line|
    if /ARGV[1]/=~line
        puts line
    end
end

a.close