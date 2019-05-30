#!/usr/env/bin ruby


require 'rubyXL'
require 'rubyXL/convenience_methods'
require 'rubygems'
require 'awesome_print'


"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
"                                               Writter                                                  "
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



workbookFinal = RubyXL::Workbook.new
worksheet = workbookFinal[0]

worksheet.insert_row(0)
worksheet.insert_row(1)

"THIS WOULD BE FILLED WITH INFO FROM THE BEGINNING OF THE INITIAL GETS.STRIP OF PROGRAM"
#infoArrayOfHashes = Array.new
#infoArrayOfHashes = [{:band_name => "123412341234", :band_num => "12341234234", :brand => "UCA", :event_date => "5/23 - 5/26"}]

titlesArray = Array.new
titlesArray = ["Band Name", "Band Number", "Brand", "Camp Date", "Total Members", "Activity Sum", "Avg Activity Per Member", "New Member Avg", "New Leaders", "New Leader Avg", "GBLs", "GBL NRUs", "NRUs Per GBL"]

"NEED TO MAKE AN ARRAY OF JUST THE VALUES FROM EACH BAND IN SAME ORDER EACH TIME CAUSE WONT BE KEYS TO IDENTIFY THE VALUES STORED IN ARRAY"

    """"" NEED TO FILL THE ORIGINAL HASH WITH THE RETURN INFO FROM B7/B3/B72/A2 FOR EASY CELL FILLING BELOW """""

k = 0
j = 0
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

workbookFinal.write("workbookFinal.xlsx")

