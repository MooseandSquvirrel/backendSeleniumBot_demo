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
worksheet.insert_row(2)
i = 1
while i < 14
    worksheet.add_cell(0, i, 'Title')
    worksheet.change_column_width(i, 20)
   # worksheet[i][0].change_contents("DOGG")
    worksheet[0][1].change_font_bold(true)
    worksheet.change_column_font_name(i, 'Courier')
    i += 1
end

workbookFinal.write("workbookFinal.xlsx")

