
####################################
# EXCELTESTPARSER REQUIRES
####################################
require 'rubyXL'
require 'rubyXL/convenience_methods'
require 'rubygems'
require 'awesome_print'
require 'date'
####################################
# TEST_CREEP REQUIRES
####################################
require 'selenium-webdriver'
require 'pp'
require 'rspec/expectations'
require 'io/console'
####################################
require './adminsList.rb'
####################################
require './stringToArrayCsv.rb'
####################################
require './adminsNameList.rb'
####################################


# MOVE TO PROPER DIRECTORY FOR PARSING
def mvDirB3()
    puts "----- Moving Directories to reach TEMP_B3 Directory -----"
    puts "Directory before:"
    puts Dir.pwd
    b3Dir = '~/fixit/backendSelenium/TEMP_B3'
    Dir.chdir(File.expand_path(b3Dir))
    puts "Directory is now:"
    puts Dir.pwd
end

# COACHES COUNT FOR EVENT/BAND 
def coachesCount(band, worksheet, b3TotalRowCount, adminsArray, bandNum)

    "THIS WAS ASSUMING B3 PROVIDED ALL ADMINS IN BAND, IT'S JUST -POSSIBLY- ADMINS THAT CREATED BANDS, NOT IN THEM. THAT IS B7 USER_NUMBERS THAT IS NEEDED FOR EACH ADMIN TO GET PROPER COACHES COUNT."
    "FOR NOW, THE AVERAGE IS 5 ADMINS PER BAND SO SUBTRACT FROM TOTAL MEMBERS TO GET ROUGH AVERAGE. CAN BE FIXED LATER WITH ALL USER_NO OF ADMINS/HI'S AND USE IT WITH B7 PARSE."
    
    band.coachesCount = band.totalMemberCount - 5
     
    # bandAdminsArray = []
    # coachesCount = 0
    # index = 1
    # # GRAB AND STORE ALL COACHES AND THEN USE .uniq  TO DELETE REPEAT NAMES AND GET newLeaderCount (CHECKS IF DATE CREATED CELL IS nil?, IF NOT, STORE)
    # while index < b3TotalRowCount
    #     cellBandNum = worksheet.sheet_data[index][0].value
    #     puts "coachesCount cellBandNum: #{cellBandNum}"
    #     cellAdminName = worksheet.sheet_data[index][5].value
    #     puts "coachesCount cellAdminName: #{cellAdminName}"
    #     # IF THE DATE CELL IS NOT EMPTY
    #     if not worksheet.sheet_data[index][10].nil?
    #         if cellBandNum == bandNum 
    #             if adminsArray.include?("#{cellAdminName}")
    #                 bandAdminsArray << worksheet.sheet_data[index][5].value
    #             end
    #         end
    #     end
    #     index += 1 
    # end
   
    # bandsAdminsArray = bandAdminsArray.uniq
    # # TO FLOAT FOR DIVISION PURPOSES LATER
    # adminsCount = bandsAdminsArray.length.to_f
    # puts "adminsCount: #{adminsCount}"
    # band.coachesCount = band.totalMemberCount - adminsCount
    
end

def nruPercentage(band)
    band.nruPercentage = ("#{((band.nruCount / band.coachesCount).round(2) * 100)}%")
end

# TOTAL LEADER COUNT FOR EVENT/BAND
def totalLeaderCount(band, worksheet, b3TotalRowCount, adminsArray, datesArray, bandNum, adminsWithBANDName)
    leaderArray = []
    totalLeaderArray = []
    index = 1
    puts "cellDateCreated = worksheet.sheet_data[index][10].value: #{worksheet.sheet_data[index][10].value}"
    puts "cellCoachesName = worksheet.sheet_data[index][5].value: #{worksheet.sheet_data[index][5].value}"
    # GRAB AND STORE ALL LEADERS AND THEN USE .uniq  TO DELETE REPEAT NAMES AND GET newLeaderCount (CHECKS IF DATE CREATED CELL IS nil?, IF NOT, STORE)
    " $$$$$$$$ $$$$$$$$  THIS MIGHT NEED TO BE '<=' INSTEAD OF '<' TO GET THE LAST ROW $$$$$$$$ $$$$$$$$"
    while index < b3TotalRowCount
        # IF THE DATE CELL IS NOT EMPTY
        if not worksheet.sheet_data[index][10].nil?
            cellDateCreated = worksheet.sheet_data[index][10].value
            cellCoachesName = worksheet.sheet_data[index][5].value
            cellBandNum = worksheet.sheet_data[index][0].value
            if cellBandNum == bandNum 
                # IF -NOT- IN adminsArray THEN IT IS COACH
                if not adminsArray.include?("#{cellCoachesName}")
                    if not adminsWithBANDName.include?("#{cellCoachesName}")
                        # STORING ALL LEADER NAMES (MULTIPLES INCLUDED)
                        leaderArray << worksheet.sheet_data[index][5].value
                    end
                end
            end
        end
        index += 1
    end

    puts "\n\n\n\n\n\n\n"
    puts "Leadersarray"
    ap leaderArray
    puts "\n\n\n\n\n\n\n"

    puts "\nnewLeaderArray.length (count) -- before .uniq: #{leaderArray.length}"

    # DELETES MULTIPLES OF LEADERS
    draftLeaderArray = leaderArray.uniq - adminsArray
    puts "\nleaderArray.length (count) -- after .uniq: \n#{draftLeaderArray.length}"
    puts "\n(draftLeaderArray:"
    ap draftLeaderArray

    # TO FLOAT FOR DIVISION PURPOSES LATER
    totalLeaderArrayLength = draftLeaderArray.length.to_f
    puts "totalLeaderArray:\n#{totalLeaderArrayLength}"

    band.totalLeaderCount = totalLeaderArrayLength
end

# NEW LEADER COUNT FOR EVENT/BAND
def newLeaderCount(band, worksheet, b3TotalRowCount, adminsArray, datesArray, bandNum, adminsWithBANDName)
    newLeaderArray = []
    index = 1
    # GRAB AND STORE ALL LEADERS AND THEN USE .uniq  TO DELETE REPEAT NAMES AND GET newLeaderCount (CHECKS IF DATE CREATED CELL IS nil?, IF NOT, STORE)
    while index < b3TotalRowCount
        # IF THE DATE CELL IS NOT EMPTY
        if not worksheet.sheet_data[index][10].nil?
            cellDateCreated = worksheet.sheet_data[index][10].value
            cellCoachesName = worksheet.sheet_data[index][5].value
            cellBandNum = worksheet.sheet_data[index][0].value
            if cellBandNum == bandNum 
                if not adminsArray.include?("#{cellCoachesName}")
                    # DATES BELOW 'DECIDES' IF LEADER IS NEW
                    if datesArray.include?("#{cellDateCreated}")
                        if not adminsWithBANDName.include?("#{cellCoachesName}")
                            newLeaderArray << worksheet.sheet_data[index][5].value
                            puts "new Leader #{worksheet.sheet_data[index][5].value}"
                        end
                    end
                end
            end
        end
        index += 1
    end

    puts "\nnewLeaderArray.length (count) -- before .uniq: #{newLeaderArray.length}"

    # DELETES MULTIPLES OF LEADERS
    tempNewLeaderArray = newLeaderArray.uniq
    puts "\nleaderArray.length (count) -- after .uniq: \n#{tempNewLeaderArray.length}"
    puts "\n(tempLeaderArray:"
    ap tempNewLeaderArray

    # TO FLOAT FOR DIVISION PURPOSES LATER
    newLeaderArrayLength = tempNewLeaderArray.length.to_f
    puts "newLeaderArray:\n#{newLeaderArrayLength}"

    band.newLeaderCount = newLeaderArrayLength
end

# NEW GBL COUNT FOR EVENT/BAND && NEW BAND NUMBERS FOR B7-2 PARSE/DRIVE.RB
def newGblCount(band, worksheet, b3TotalRowCount, adminsArray, datesArray, bandNum)
    newGblArray = []
    newBandNumbsb7_2 = []
    index = 1
    # GRAB AND STORE ALL LEADERS AND THEN USE .uniq  TO DELETE REPEAT NAMES AND GET newLeaderCount (CHECKS IF DATE CREATED CELL IS nil?, IF NOT, STORE)
    while index < b3TotalRowCount
        # IF THE DATE CELL IS NOT EMPTY
        if not worksheet.sheet_data[index][10].nil?
            cellDateCreated = worksheet.sheet_data[index][10].value
            cellCoachesName = worksheet.sheet_data[index][5].value
            cellBandMemSize = worksheet.sheet_data[index][14].value.to_i
            cellBandNum = worksheet.sheet_data[index][0].value
            if cellBandNum == bandNum 
                if not adminsArray.include?("#{cellCoachesName}")
                    # DATES BELOW 'DECIDES' IF LEADER IS NEW
                    if datesArray.include?("#{cellDateCreated}")
                        if cellBandMemSize > 1
                            newGblArray << worksheet.sheet_data[index][5].value
                            # COLLECTING BAND NUMBER FOR B7-2 PARSE/DRIVE.RB
                            newBandNumbsb7_2 << worksheet.sheet_data[index][7].value
                            puts "\n\n\n\n\n\n"
                            puts "adding cell with cellBandMemSize: #{cellBandMemSize}"
                            puts "\n\n\n\n\n\n"
                        end
                    end
                end
            end
        end
        index += 1
    end

    puts "\n(newGblArray:"
    ap newGblArray

    # TO FLOAT FOR DIVISION PURPOSES LATER
    tempGblArrayLength = newGblArray.length.to_f
    puts "tempGblArrayLength:\n#{tempGblArrayLength}"

    band.newGblCount = tempGblArrayLength
    band.newBandNumbsb7_2 = newBandNumbsb7_2

    puts "band.newNumber: #{band.newBandNumbsb7_2}"
end

# NEW LEADER AVG FUNCTION
def newLeaderPerc(band, coachesCount, newLeaderCount)
    newLeaderPerc = "#{((newLeaderCount / coachesCount).round(2) * 100)}%"
    band.newLeaderPerc = newLeaderPerc
end

# EXTRANEOUS PRINT STATEMENT TO SHOW RESULTS OF B3 LOOP (PER EVENT)
def resultsB3(band, eventName)

    puts "==============================================================================================="
    puts "Results of first B3 (#{eventName})"
    puts "-----------------------------------"
    puts "totalMemberCount: #{band.totalMemberCount}"
    puts "nruPercentage: #{band.nruPercentage}"
    puts "coachesCount: #{band.coachesCount}"
    puts "totalLeaderCount: #{band.totalLeaderCount}"
    puts "newLeaderCount: #{band.newLeaderCount}"
    puts "newGblCount: #{band.newGblCount}"
    puts "newLeaderPerc: #{band.newLeaderPerc}%"
    puts "==============================================================================================="
end

"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                              B3 Loop Main                                              "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

def b3Parse(eventNumsArray, bandsArraywDates)

    # SETTING UP ARRAY OF ADMINS NAMES FROM ADMINS EXCEL SPREADSHEET -- FOR USE IN B3 (AND B7.1?) TO REMOVE ADMINS WHO CREATED BANDS
    # **** THIS DOES NOT INCLUDE 'BAND' NAME AS ADMIN ****S
    adminsArray = adminsList()

    puts "adminsArray"
    ap adminsArray

    # SETTING UP ARRAY WITH 'BAND' NAME INCLUDED WTIH ALL OTHER ADMINS TOO ( EVENTUALLY DELETE ABOVE CODE AFTER REPLACING FUNCTIONS WITH BELOW CODE)
    adminsWithBANDName = adminsNamesList()

    # Move to TEMP_B3
    mvDirB3()

    # COLLECT FILE NAME(S) IN TEMP_B3 (JUST WANT IT TO BE ONE BUT MIGHT GET MULTIPLES IF NOT WORKING PROPERLY)
    fileNamesArray = []
    fileNamesArray = Dir["./*.xlsx"]
    puts "fileNamesArray:"
    ap fileNamesArray

    i = 0
    bandNum = 0
    while i < eventNumsArray.length
        puts "i = #{i}"
        puts "eventNumsArray.length = #{eventNumsArray.length}"
        workbookB3 = RubyXL::Parser.parse("#{fileNamesArray[0]}")
         
        # DEFINES WORKBOOK AS WORKSHEET (DONT DELETE)
        worksheet = workbookB3[0]
 
        #  ASSIGNS BAND OBJECT FROM ARRAY
        band = bandsArraywDates[i]

        # USE TO ITERATE IN filterBandNums FUNCTION TO GRAB ROW COUNT SPECIFIC FOR EACH BAND IN ORDER TO ITERATE IN LATER FUNCTIONS
        b3TotalRowCount = worksheet.sheet_data.rows.size - 1
        puts "b3TotalRowCount: #{b3TotalRowCount}"

        # **FINAL RESULT** SAVE COACHESCOUNT (USED IN B3 AND FINAL RESULT GRAPH) - STORED INTO RESULT IN BAND OBJECT
        coachesCount(band, worksheet, b3TotalRowCount, adminsArray, band.bandNum)
        puts "band.coachesCount: #{band.coachesCount}"

        # **FINAL RESULT** SAVE NRUPERCENTAGE - STORED INTO RESULT IN BAND OBJECT
        nruPercentage(band)
        puts "band.nruPercentage: #{band.nruPercentage}"

        # **FINAL RESULT** totalLeadersCount - STORED INTO RESULT IN BAND OBJECT
        totalLeaderCount(band, worksheet, b3TotalRowCount, adminsArray, band.datesArray, band.bandNum, adminsWithBANDName)

        # **FINAL RESULT** newLeaderCount - STORED INTO RESULT IN BAND OBJECT
        newLeaderCount(band, worksheet, b3TotalRowCount, adminsArray, band.datesArray, band.bandNum, adminsWithBANDName)

        # **FINAL RESULT** new_GBL_LeaderCount - STORED INTO RESULT IN BAND OBJECT
        newGblCount(band, worksheet, b3TotalRowCount, adminsArray, band.datesArray, band.bandNum)

        # **FINAL RESULT** newLeaderPerc - STORED INTO RESULT IN BAND OBJECT
        newLeaderPerc(band, band.coachesCount, band.newLeaderCount)

        # RESULTS PRINTED FOR B3 FOR ONE EVENT
        resultsB3(band, band.eventName)

        i += 1
    end
end
