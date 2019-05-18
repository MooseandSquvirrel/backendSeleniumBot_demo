#!/Users/agardner/.rvm/rubies/ruby-2.5.0/bin/ruby

print"\n\n"
print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n"
print "                                            WELCOME TO Fixit!                                     \n"
print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n"

print "\n\nThis program will continue until 'exit' is entered on the command line.\n\nHit 'Enter' key to begin.\n"

until gets.strip() == "exit"
    puts "\n"
    puts("Enter file to clean. When finished enter 'done'.")

    # COLLECTS USER INPUT INTO ARRAY filesArray
    filesArray = []
    usrFiles = ""
    while usrFiles != "done"
        usrFiles = gets.strip
        if usrFiles == "done"
            break
        end
        filesArray.push(usrFiles)
        print filesArray
        print "\n"
    end

    # SEARCHES DIRECTORY FOR USER INPUT PARAMETERS FROM filesArray -> 
    # STORES FILES THAT ACTUALLY EXIST IN DIRECTORY INTO NEW ARRAY dirFiles
    i = 0
    dirFiles = []
    arrLen = filesArray.length
    while i < arrLen
        dirFiles << Dir.glob("#{filesArray[i]}")
        i += 1
    end

    puts"-------------------------------------------------"
    puts "dirFiles -- (User input entered, w/ blanks for non-existent file choices in directory.)"
    print dirFiles
    puts "\n"

    # REMOVES NIL CHOICES FROM ARRAY THAT Dir.glob() WAS UNABLE TO FIND IN DIRECTORY
    cleanDirFiles = Array.new
    cleanDirFiles = dirFiles.reject{|element| element.empty?}
    if cleanDirFiles.empty? 
        puts"-------------------------------------------------"
        print "\nNo files with those names in current folder.\nCheck file names for spelling errors.\n"
        puts"-------------------------------------------------\n"
    else
        print "\ncleanDirFiles array, w/ non-.txt files & .txt files -- \n(Needs Cleaning of none .txt)\n"
        puts cleanDirFiles
        puts "++++++++++++++++++++++++++++\n"
        puts "cleanDirFiles array length"
        puts cleanDirFiles.length
        puts "\n"
    end

    # loopy FUNCTION (NEEDED TO TAKE PARAMETERS FOR SOME REASON TO GET PARAMS INSIDE LOOPS)
    # LOOPS THROUGH AND GETS EXTENSIONS OF cleanDirFiles, PURPOSE TO CLEAN OUT WRONG FILE TYPES
    # NOT SURE THIS IS NECESSARY IF USER ERROR ON FILE NAME INPUT OR EXTENSION IS AVOIDED
    
   # fileExtns = Array.new
   # finalFileArr = Array.new
   # arrLenExtns = cleanDirFiles.length
   # def loopy(cleanDirFiles, fileExtns, finalFileArr, arrLenExtns)
   #     i = 0
   #     while i < arrLenExtns
   #             fileExtns << File.extname("#{cleanDirFiles[i]}")
   #             puts "-----------------------------"
   #             puts "Inside 'while i < arrLenExtns'"
   #             puts "cleanDirFiles[i]:"
   #             puts cleanDirFiles[i]
   #             puts "\n"
   #             puts "fileExtns"
   #             #puts fileExtns
   #             puts fileExtns[i]
   #             if fileExtns[i] == ".txt\*"
   #                 finalFileArr << cleanDirFiles[i]
   #                 puts "finalFileArr[i]"
   #                 puts finalFileArr[i]
   #             end
   #             i += 1
   #     end
   # end


   fileExtns = ""
   finalFileArr = Array.new
   arrLenExtns = cleanDirFiles.length
   def loopy(cleanDirFiles, fileExtns, finalFileArr, arrLenExtns)
        i = 0
        cleanDirFiles.each do |i|
            fileExtns = File.extname("#{cleanDirFiles[i]}")
            puts "-----------------------------"
            puts "Inside 'while i < arrLenExtns'"
            puts "cleanDirFiles[i]:"
            puts cleanDirFiles[i]
            puts "\n"
            puts "fileExtns"
            #puts fileExtns
            puts fileExtns[i]
            if fileExtns == ".txt"
                finalFileArr << cleanDirFiles[i]
                puts "finalFileArr[i]"
                puts finalFileArr[i]
            end
            i += 1
        end
    end



    # loopy EXECUTION
    loopy(cleanDirFiles, fileExtns, finalFileArr, arrLenExtns)


    print "\nDone!\n"
    puts"-------------------------------------------------\n"
    puts"-------------------------------------------------\n"
    puts"-------------------------------------------------\n"
    puts"-------------------------------------------------\n"


    puts "Hit 'Enter' to try again. Or Type 'exit' to quit.\n"
end
