#!/home/chris/.rbenv/shims/ruby -w
#
# pathscript.rb
#
# copies all ruby scripts in current directory to /usr/local/bin/ and removes .rb extension, so can be executed from terminal
#


# load all files in current directory into an array
allfiles = `ls`.split("\n")

case (Process.uid)
when 0
  # We're root!
else
  $stderr.puts("You must run this with root privileges via sudo")
  exit 1
end

# method to ask user for yes/no returns true/false

def inputs_yes()
    answer = gets.chomp
    sleep(0.2)
    if answer.downcase == "yes" || answer.downcase == "y"
        return true
    end
    return false
end

# loop through all files except this currently running one

for file in allfiles do
    if file =~ /.rb$/
        newfile = file.gsub(/.rb$/,'')
        puts "load file #{file} into #PATH?\n"
        if inputs_yes()
                # check for shebang and add if needed
            firstline = `head -1 #{file}`
            if firstline !~ /\#\!\/home\/chris\/.rbenv\/shims\/ruby/
                puts "Enable warnings on script?"
                if inputs_yes()
                    `echo "#!/home/chris/.rbenv/shims/ruby -w" | cat - #{file} > temp && mv temp #{file}`
                else
                    `echo "#!/home/chris/.rbenv/shims/ruby" | cat - #{file} > temp && mv temp #{file}`
                end
            end
            puts "cp #{file} /usr/local/bin/#{newfile}"
            `cp #{file} /usr/local/bin/#{newfile}`
            sleep(0.2)
            puts "copied #{newfile} to /usr/local/bin/"
            sleep(0.2)
        end
    end
end

# answer checking method
