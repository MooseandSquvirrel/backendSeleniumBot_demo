
require 'rubyXL'
require 'rubyXL/convenience_methods'
require 'rubygems'
require 'awesome_print'
require 'date'
require 'FileUtils'



"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                               Writter_2                                                  "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


# MAKE A TEMP DIRECTORY FOR HOUSING THE FINAL RESULTS 
def finalResultsDir()
    puts "\n"
    puts "Checking for finalResults Directory..."
    puts "Dirctory before:"
    puts Dir.pwd
    desktopDir = '~/Desktop'
    Dir.chdir(File.expand_path(desktopDir))
    puts "Directory is now:"
    puts Dir.pwd
    puts "Checking for Final_Results Directory..."
    if Dir.exist?("Final_Results") == false
        puts "Creating Final_Results Directory..."
        Dir.mkdir("Final_Results")
    else
        puts "Final_Results Directory exists."
    end
    puts "Dirctory before:"
    puts Dir.pwd
    seleniumDir = '~/fixit/backendSelenium'
    Dir.chdir(File.expand_path(seleniumDir))
    puts "Directory is now:"
    puts Dir.pwd
end

def mvFinalRes()
    Dir.glob("*Band*.xlsx") {|file|
        if file
            puts "Moving file '#{file}' into Final_Results Directory on Desktop..."
            temp_data_path = '~/Desktop/Final_Results'
            FileUtils.mv("#{file}", File.expand_path(temp_data_path))
        else
            puts "No Final_Result .xlsx file found in current Directory..."
        end 
    }
end
def writer2(bandsArray)

    finalResultsDir()
    # EQUALS LENGTH OF ARRAY
    bandsLength = bandsArray.length

    bandsArrayCounter = 0

    # LOOP UNTIL ALL BANDS IN bandsArray HAVE BEEN WRITTEN IN SEPERATE DOCUMENTS (CHANGE NAME FOR EACH AND SPECIFY NEW DIRECTORY)
    until bandsArrayCounter > bandsLength

        puts "bandsArray:"
        ap bandsArray
        band = bandsArray[bandsArrayCounter]
        ap "band: #{band}"
        
        workbookFinal = RubyXL::Workbook.new
        worksheet = workbookFinal[0]

        worksheet.insert_row(0)
        worksheet.insert_row(1)

        titlesArray = Array.new
        titlesArray = ["Summer Camp", "Brand", "Camp Date", "Band", "Total Members", "Coaches(Non-Admins", "NRUs", "NRU%", "Total Leaders", "New Leaders", "New Leaders %", "New GBLs", "New GBL %", "GBL NRUs", "NRUS per GBL", "Total NRUs", "Activity Sum", "Unique Users w/ Activity", "Sum/Total Member", "Unique/Member"]
        contentArray = [band.eventName, band.brandName, band.campDates, band.bandNum, band.totalMemberCount, band.coachesCount, band.nruCount, band.nruPercentage, band.totalLeaderCount, band.newLeaderCount, band.newLeaderPerc, band.newGblCount, band.newGblPerc, band.gblNru, band.nruPerGbl, band.totalNru]
        i = 0
        index = 0

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
            worksheet.add_cell(1, i, "#{contentArray[i]}")
            worksheet.change_column_width(i, 25)
            worksheet.change_row_height(1, 40)  # Sets first row height to 30
            # worksheet[0][i].change_font_bold(true)
            worksheet.change_column_font_name(i, 'Calibri')
            worksheet.change_column_font_size(i, 14)
            # HOZONTALLY CENTERS TEXT
            worksheet.sheet_data[1][i].change_horizontal_alignment('center')
            # VERTICALLY CENTERS TEXT
            worksheet.change_row_vertical_alignment(1, 'distributed')
            # TITLE ROW BOTTOM UNDERLINE
            worksheet.sheet_data[0][i].change_border(:bottom, 'medium')
            worksheet.change_row_border_color(1, :bottom, 'ed553b')
            # FILL TITLE ROW WITH GREY
            worksheet.change_row_fill(1, 'dcdcdc')   
            i += 1
        end
    
        workbookFinal.write("#{bandsArray[bandsArrayCounter]}.xlsx")
        mvFinalRes()

        bandsArrayCounter += 1
    end
end