#!/usr/env/bin ruby


require 'rubyXL'
require 'rubyXL/convenience_methods'
require 'rubygems'
require 'awesome_print'
require 'date'


"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                               Writter_2                                                  "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

"I NEED TO CREATE AN ARRAY FOR THE FINAL RESULT VARIABLES COMBINED WITH THE VARIABLES THAT WERE INITIALLY ENTERED IN THE PROGRAM! FOR MULTIPLE NEED TO BE ARRAY OF ARRAYS OR ARRAY OF HASHES"
"The above array in quote might need to be like the one tempArrayOfHashes below."

"MAKE SURE TO FIND OR CREATE THE EQUIVALENT DATA STRUCTURES BELOW IN ORIGINAL CODE, THEN DELETE THIS TEMPORARY HASH AND bandsNamesArray, THESE ARE IN PLACE OF ACCESSING THE ORIGINAL ARRAY OF HASHES OF BANDS INFO (stringsHash?)"
"*****THIS HASH NEEDS TO EVENTUALLY BE AN ARRAY OF HASHES LIKE ORIGINAL GETS INPUT TO HANDLE MULTIPLE BANDS INPUT************"
tempArrayOfHash = Array.new
bandsNamesArray = Array.new
tempArrayOfHash = [{:band_name => "donkey", :band_num => 2222},{:band_name => "pugface", :band_num => 99999999}]
bandsNamesArray = ["firstBand", "SecondBand"]

puts "Code that iterates the info to be new for the second line of data chart."
puts "tempArrayOfHash.map{|x| x[:band_name], x[:band_num]}:"
puts tempArrayOfHash.map{|x| x[:band_name]}
#, x[:band_num], x[:brand_name]

# EQUALS LENGTH OF ARRAY OF tempArrayOfHash AND WHATEVER THE BAND NAME ARRAY GETS NAMED; THIS WILL HELP FOR ITERATING THE TITLE OF THE SHEET THAT IS WRITTEN AT THE BOTTOM IN THE INTERPOLATION
bandsLength = tempArrayOfHash.length

bandsArrayCounter = 0
"(CHANGE NAME FOR EACH WRITTEN ANALYSIS AND SPECIFY NEW DIRECTORY)"
# LOOP UNTIL ALL BANDS IN bandsArray HAVE BEEN WRITTEN IN SEPERATE DOCUMENTS (CHANGE NAME FOR EACH AND SPECIFY NEW DIRECTORY)
until bandsArrayCounter > bandsLength

    
    workbookFinal = RubyXL::Workbook.new
    worksheet = workbookFinal[0]

    worksheet.insert_row(0)
    worksheet.insert_row(1)

    titlesArray = Array.new
    titlesArray = ["Band Name", "Band Number", "Brand", "Camp Date", "Total Members", "Activity Sum", "Avg Activity Per Member", "New Member Avg", "New Leaders", "New Leader Avg", "GBLs", "GBL NRUs", "NRUs Per GBL"]

    # CONVERTING ORIGINAL bandsArray (ARRAY OF HASHES OF BANDS' INFO) INTO ARRAY OF ARRAYS SO THAT EACH ARRAY CAN ITERATE ITS INFO INTO SHEET AT CORRECT CELL (HASH .each WOULDN'T WORK FOR THIS WHILE LOOP TO FILL EACH CELL INDIVIDUALLY, WOULD FILL ONE WITH ALL K/V PAIRS)
    i = 0
    "UNCOMMENT WHEN READY TO MERGE"
    #### bandsArray = bandsArray.map{|x| [x[:band_name], x[:band_num], x[:brand_name]]}
    
    index = 0

    #puts "bandArrayOfArrays before pushing result variables into array:"
    #ap bandsArray

    puts "Code that iterates the info to be new for the second line of data chart."
    puts "tempArrayOfHash.map{|x| x[:band_name], x[:band_num]}:"
    puts dog = tempArrayOfHash.map{|x| x.map { |y| y[:band_name], y[:band_num]}}
#, x[:band_num], x[:brand_name]

    # TITLE ROW CELL FILLING
    i = 0
    while i < 15
        worksheet.add_cell(0, i, "#{titlesArray[i]}")
        worksheet.change_column_width(i, 25)
        worksheet.change_row_height(0, 40)  # Sets first row height to 30
        # worksheet[0][i].change_font_bold(true)
        worksheet.change_column_font_name(i, 'Calibri')
        worksheet.change_column_font_size(i, 14)
        # HOZONTALLY CENTERS TEXT
        worksheet.sheet_data[0][i].change_horizontal_alignment('center')
        # VERTICALLY CENTERS TEXT
        worksheet.change_row_vertical_alignment(0, 'distributed')
        # TITLE ROW BOTTOM UNDERLINE
        worksheet.sheet_data[0][i].change_border(:bottom, 'medium')
        worksheet.change_row_border_color(0, :bottom, 'ed553b')
        # FILL TITLE ROW WITH GREY
        worksheet.change_row_fill(0, 'dcdcdc')   
        i += 1
    end

    # DATA ROW FILING
    i = 0
    j = 0
    while i < 15
        # worksheet.add_cell(0, i, "#{bandArray[i][j]}")
        worksheet.add_cell(0, i, "#{tempArrayOfHash[i][j]}")
        worksheet.change_column_width(i, 25)
        worksheet.change_row_height(0, 40)  # Sets first row height to 30
        # worksheet[0][i].change_font_bold(true)
        worksheet.change_column_font_name(i, 'Calibri')
        worksheet.change_column_font_size(i, 14)
        # HOZONTALLY CENTERS TEXT
        worksheet.sheet_data[0][i].change_horizontal_alignment('center')
        # VERTICALLY CENTERS TEXT
        worksheet.change_row_vertical_alignment(0, 'distributed')
        # TITLE ROW BOTTOM UNDERLINE
        worksheet.sheet_data[0][i].change_border(:bottom, 'medium')
        worksheet.change_row_border_color(0, :bottom, 'ed553b')
        # FILL TITLE ROW WITH GREY
        worksheet.change_row_fill(0, 'dcdcdc')   
        i += 1
    end

    "CREATE AN ARRAY WITH THE BANDS NAMES THAT WILL BE ITERATED HERE FOR THE TITLES OF EACH SHEET"
    "**********      DON'T FORGET TO MAKE bandsnameArray IF IT DOESN'T EXIT YET TO SAVE EACH FILE WITH NAME FROM BAND AND ITERATE IN THE INTERPOLATION BELOW"
    workbookFinal.write("#{bandsNameArray[index]}.xlsx")
    bandsArrayCounter += 1
    index += 1


end

