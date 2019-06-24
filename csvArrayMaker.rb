#!/usr/env/bin ruby

require 'csv'
require 'ap'

csvArray = CSV.read("csvHiBandNumbList.csv", {:col_sep => ', '})
p csvArray.flatten

