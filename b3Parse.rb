
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

# MOVE TO PROPER DIRECTORY FOR PARSING
def mvDir()
    puts "----- Moving Directories to reach TEMP_B7 Directory -----"
    puts "Directory before:"
    puts Dir.pwd
    b3Dir = '~/fixit/backendSelenium/TEMP_B3'
    Dir.chdir(File.expand_path(b3Dir))
    puts "Directory is now:"
    puts Dir.pwd
end

# TOTAL MEMBER COUNT FUNCTION
def totalMembersCount(band, worksheet, bandNum, b3TotalRowCount)
    index = 1
    cellBandNum = worksheet.sheet_data[index][0].value
    while cellbandNum != bandNum
        index +=1
    end
    puts "cellbandNum = #{cellBandNum}"
    if cellBandNum == bandNum
        totalMembers = worksheet.sheet_data[index][2].value
        # TO FLOAT FOR DIVISION PURPOSES LATER
        band.totalMembers = totalMembers.to_f
    end
end

def nruPercentage()
    band.nruPercentage = (band.nruCount / band.totalMembersCount).round(2)
end

# COACHES COUNT FOR EVENT/BAND 
def coachesCount(band, worksheet, adminsList, b3TotalRowCount, bandNum)
    bandAdminsArray = []
    coachesCount = 0
    cellBandNum = worksheet.sheet_data[index][0].value
    cellAdminName = worksheet.sheet_data[index][5].value
    index = 1
    #   GRAB AND STORE ALL COACHES AND THEN USE .uniq  TO DELETE REPEAT NAMES AND GET newLeaderCount (CHECKS IF DATE CREATED CELL IS nil?, IF NOT, STORE)
    while index < b3TotalRowCount
        # IF THE DATE CELL IS NOT EMPTY
        if not worksheet.sheet_data[index][10].nil?
            if cellBandNum == bandNum 
                if adminList.include?("#{cellAdminName}")
                    bandAdminsArray << worksheet.sheet_data[index][5].value
                end
            end
        end
        index += 1 
    end
        return

    bandsAdminsArray = bandAdminsArray.uniq
    # TO FLOAT FOR DIVISION PURPOSES LATER
    adminsCount = bandsAdminsArray.length.to_f
    band.coachesCount = band.totalMembers - adminsCount
    
end

# TOTAL LEADER COUNT FOR EVENT/BAND
def totalLeaderArray(adminsArray, b3RowCount, worksheet, adminList, datesArray)
    leaderArray = []
    totalLeaderArray = []
    cellDateCreated = worksheet.sheet_data[index][10].value
    cellCoachesName = worksheet.sheet_data[index][5].value
    index = 1
    # GRAB AND STORE ALL LEADERS AND THEN USE .uniq  TO DELETE REPEAT NAMES AND GET newLeaderCount (CHECKS IF DATE CREATED CELL IS nil?, IF NOT, STORE)
    " $$$$$$$$ $$$$$$$$  THIS MIGHT NEED TO BE '<=' INSTEAD OF '<' TO GET THE LAST ROW $$$$$$$$ $$$$$$$$"
    while index < b3RowCount
        # IF THE DATE CELL IS NOT EMPTY
        if not worksheet.sheet_data[index][10].nil?
            # IF -NOT- IN adminList THEN IT IS COACH
            if not adminList.include?("#{cellCoachesName}")
                # STORING ALL LEADER NAMES (MULTIPLES INCLUDED)
                leaderArray << worksheet.sheet_data[index][5].value
            end
        end
        index += 1
    end

    puts "\nnewLeaderArray.length (count) -- before .uniq: #{leaderArray.length}"

    # DELETES MULTIPLES OF LEADERS
    draftLeaderArray = leaderArray.uniq
    puts "\nleaderArray.length (count) -- after .uniq: \n#{draftLeaderArray.length}"
    puts "\n(draftLeaderArray:"
    ap draftLeaderArray

    # TO FLOAT FOR DIVISION PURPOSES LATER
    totalLeaderArrayLength = draftLeaderArray.length.to_f
    puts "totalLeaderArray:\n#{totalLeaderArrayLength}"

    band.totalLeaderCount = totalLeaderArrayLength
end

# NEW LEADER COUNT FOR EVENT/BAND
def newLeaderCount(band, worksheet, b3RowCount, datesArray)
    newLeaderArray = []
    cellDateCreated = worksheet.sheet_data[index][10].value
    cellCoachesName = worksheet.sheet_data[index][5].value
    index = 1
    # GRAB AND STORE ALL LEADERS AND THEN USE .uniq  TO DELETE REPEAT NAMES AND GET newLeaderCount (CHECKS IF DATE CREATED CELL IS nil?, IF NOT, STORE)
    while index < b3RowCount
        # IF THE DATE CELL IS NOT EMPTY
        if not worksheet.sheet_data[index][10].nil?
            if not adminList.include?("#{cellCoachesName}")
                # DATES BELOW 'DECIDES' IF LEADER IS NEW
                if not datesArray.include?("#{datesArray}")
                    newLeaderArray << worksheet.sheet_data[index][5].value
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
    newLeaderArrayLength = tempLeaderArray.length.to_f
    puts "totalLeaderArray:\n#{totalLeaderArrayLength}"

    band.newLeaderCount = newLeaderArrayLength
end


# NEW GBL COUNT FOR EVENT/BAND
def newGblCount(band, worksheet, b3RowCount, adminsList, datesArray)
    newGblArray = []
    cellDateCreated = worksheet.sheet_data[index][10].value
    cellCoachesName = worksheet.sheet_data[index][5].value
    cellBandMemSize = worksheet.sheet_data[index][15].value.to_f
    index = 1
    # GRAB AND STORE ALL LEADERS AND THEN USE .uniq  TO DELETE REPEAT NAMES AND GET newLeaderCount (CHECKS IF DATE CREATED CELL IS nil?, IF NOT, STORE)
    while index < b3RowCount
        # IF THE DATE CELL IS NOT EMPTY
        if not worksheet.sheet_data[index][10].nil?
            if not adminList.include?("#{cellCoachesName}")
                # DATES BELOW 'DECIDES' IF LEADER IS NEW
                if not datesArray.include?("#{datesArray}")
                    if cellBandMemSize > 1
                        newGblArray << worksheet.sheet_data[index][5].value
                    end
                end
            end
        end
        index += 1
    end

    puts "\nnewLeaderArray.length (count) -- before .uniq: #{newLeaderArray.length}"

    # DELETES MULTIPLES OF LEADERS
    tempGblArray = newGblArray.uniq
    puts "\nleaderArray.length (count) -- after .uniq: \n#{tempGblArray.length}"
    puts "\n(tempGblArray:"
    ap tempGblLeaderArray

    # TO FLOAT FOR DIVISION PURPOSES LATER
    tempGblArrayLength = tempGblArray.length.to_f
    puts "tempGblArrayLength:\n#{tempGblArrayLength}"

    band.new_GBL_LeaderCount = tempGblArrayLength
end

# NEW LEADER AVG FUNCTION
def newLeaderAvg(coachesCount, newLeaderCount)
    newLeaderAvg = (newLeaderCount / coachesCount).round(2)
    band.newLeaderAvg = newLeaderAvg
end

# EXTRANEOUS PRINT STATEMENT TO SHOW RESULTS OF B3 LOOP (PER EVENT)
def resultsB3(eventName)

    puts "==============================================================================================="
    puts "Results of first B3 (#{eventName})"
    puts "-----------------------------------"
    puts "totalMemberCount: #{band.totalMembersCount}"
    puts "nruPercentage: #{band.nruPercentage}"
    puts "coachesCount: #{band.coachesCount}"
    puts "totalLeaderCount: #{band.totalLeaderCount}"
    puts "newLeaderCount: #{band.newLeaderCount}"
    puts "newGblCount: #{band.newGblCount}"
    puts "newLeaderAvg: #{band.newLeaderAvg}%"
    puts "==============================================================================================="
end

"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                              B3 Loop Main                                              "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

def b3Parse(eventNumsArray, bandsArraywDates)

    # SETTING UP ARRAY OF ADMINS NAMES FROM ADMINS EXCEL SPREADSHEET -- FOR USE IN B3 (AND B7.1?) TO REMOVE ADMINS WHO CREATED BANDS
    adminsArray = adminsList()

    puts "adminsArray"
    ap adminsArray

    # Move to TEMP_B3
    mvDir()

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

        # **FINAL RESULT** SAVE TOTALMEMBERS COUNT - STORED INTO RESULT IN BAND OBJECT
        totalMembersCount(band, worksheet, band.bandNum, b3TotalRowCount)

        # **FINAL RESULT** SAVE NRUPERCENTAGE - STORED INTO RESULT IN BAND OBJECT
        nruPercentage()

        # **FINAL RESULT** SAVE COACHESCOUNT (USED IN B3 AND FINAL RESULT GRAPH) - STORED INTO RESULT IN BAND OBJECT
        coachesCount(band, worksheet, b3RowCount, adminsList, band.bandNum)

        # **FINAL RESULT** totalLeadersCount - STORED INTO RESULT IN BAND OBJECT
        totalLeaderCount(band, worksheet, b3RowCount, adminsList, band.datesArray)

        # **FINAL RESULT** newLeaderCount - STORED INTO RESULT IN BAND OBJECT
        newLeaderCount(band, worksheet, b3RowCount, adminsList, band.datesArray)

        # **FINAL RESULT** new_GBL_LeaderCount - STORED INTO RESULT IN BAND OBJECT
        newGblCount(band, worksheet, b3RowCount, adminsList, band.datesArray)

        # **FINAL RESULT** newLeaderAvg - STORED INTO RESULT IN BAND OBJECT
        newLeaderAvg(band.coachesCount, band.newLeaderCount)

        # RESULTS PRINTED FOR B3 FOR ONE EVENT
        resultsB3()

        i += 1
    end
end