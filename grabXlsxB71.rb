# MAKE A TEMP DIRECTORY FOR HOUSING THE B7 FOR PARSING
def tempB7Dir()
    puts "\n"
    puts "Checking for TEMP_B7 Directory..."
    puts "Dirctory before:"
    puts Dir.pwd
    desktopDir = '~/fixit/backendSelenium'
    Dir.chdir(File.expand_path(desktopDir))
    puts "Directory is now:"
    puts Dir.pwd
    puts "Checking for TEMP_B7 Directory..."
    if Dir.exist?("TEMP_B7") == false
        puts "Creating TEMP_B7 Directory..."
        Dir.mkdir("TEMP_B7")
    else
        puts "TEMP_B7 Directory exists."
    end
end

# FUNCTION TO GRAB B7.1 FROM ~/DOWNLOADS AND MOVE IT INTO FIXIT'S WORKING DIRECTORY FOR PARSING (PUTTING INSIDE NEW DIRECTORY FOR ORGANIZATION)
def grabXlsxB71()
    puts "\n"
    tempB7Dir()
    puts "Grabbing B-7 .xlsx from ~/Downloads..."
    puts "Directory before:"
    puts Dir.pwd
    downloadDir = '~/Downloads'
    Dir.chdir(File.expand_path(downloadDir))
    puts "Directory is now:"
    puts Dir.pwd
    puts "Checking Downloads Directory for B-7 download file to move to TEMP_B7 for parsing..."
    Dir.glob("*B-7*.xlsx") {|file|
        if file
            puts "Moving file '#{file}' into TEMP_B7 Directory, in the working Directory inside Fixit..."
            temp_data_path = '~/fixit/backendSelenium/TEMP_B7'
            FileUtils.mv("#{file}", File.expand_path(temp_data_path))
        else
            puts "No B-7 file found in ~/Downloads..."
        end
      }
end

def removeTEMPB7()
    puts "Moving to Delete TEMP_B7..."
    puts "Directory before:"
    puts Dir.pwd
    fixitDir = '~/fixit/backendSelenium'
    Dir.chdir(File.expand_path(fixitDir))
    puts "Directory is now:"
    puts Dir.pwd
    puts "Deleting TEMP_B7 Directory..."
    thisDir = "~/fixit/backendSelenium/TEMP_B7"
    FileUtils.remove_dir(File.expand_path(thisDir))
end
