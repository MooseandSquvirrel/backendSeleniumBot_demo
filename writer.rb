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
    worksheet[0][i].change_font_bold(true)
    worksheet.change_column_font_name(i, 'Calibri')
    worksheet.change_column_font_size(i, 20)
    worksheet.sheet_data[0][i].change_horizontal_alignment('center')
    worksheet.sheet_data[0][i].change_border(:bottom, 'medium')
    worksheet.change_row_border_color(0, :bottom, '0ba53d')


    i += 1
end

workbookFinal.write("workbookFinal.xlsx")

