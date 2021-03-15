#!/home/chris/.rbenv/shims/ruby -w
#
# prepends string to file
#
# pre <string> <file>
#
# also can prepend a file to a file
#
# pre <file> <file>

if ARGV.length == 0
    puts "Missing string to prepend\nUsage:\npre <string/file> <file>\n"
    exit 1
end

if ARGV.length == 1
    puts "Missing file to prepend to\nUsage:\npre <string/file> <file>\n"
    exit 1
end

prependstring = ARGV[0]
destfile = ARGV[1]

if File.file?(Dir.getwd+"/"+destfile)
    if File.file?(Dir.getwd+"/"+prependstring)
        `cat #{prependstring} | cat - #{destfile} > temp && mv temp #{destfile}`
    else
        `echo "#{prependstring}" | cat - #{destfile} > temp && mv temp #{destfile}`
    end
else
    puts "#{destfile} doesn't exist"
    exit 1
end