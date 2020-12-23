
$cellReturnText = ""

# FUNCTION TO ITERATE BACK TO CELL WITH "RUNNING/SUCEED" TEXT IN ORDER TO BREAK WHILE LOOP OF 'STILL RUNNING' ***SAVES cell.text IN RETURN STATEMENT***
def iterate_to_cell(band, table, bandNum, userNameVar, my_date, cellTimeStampArray)
    table.find_elements(:tag_name, "tr").each do |r|  
        if r.text.include? "#{userNameVar}" && r.text.include? "#{bandNum}" && r.text.include? "#{my_date}"
            if not r.text.include? "FAIL"
                if (r.text.include? "#{cellTimeStampArray[0]}") || (r.text.include? "#{cellTimeStampArray[1]}") || (r.text.include? "#{cellTimeStampArray[2]}")
                    i = 0
                    r.find_elements(:tag_name, "td").each do |cell|
                        i += 1
                        if i == 2
                            return cell.text
                        end
                    end
                end
            end
        end
    end
end

# FUNCTION TO ITERATE BACK TO CELL WITH "RUNNING/SUCEED" TEXT IN ORDER TO BREAK WHILE LOOP OF 'STILL RUNNING' ***SAVES cell.text IN RETURN STATEMENT***
def iterate_to_cellB7(band, table, bandNum, userNameVar, my_date, cellTimeStampArray)
    table.find_elements(:tag_name, "tr").each do |r|  
        if r.text.include? "#{userNameVar}" && r.text.include? "#{bandNum}" && r.text.include? "#{my_date}" && r.text.include? "B-7"
            if not r.text.include? "FAIL"
                if (r.text.include? "#{cellTimeStampArray[0]}") || (r.text.include? "#{cellTimeStampArray[1]}") || (r.text.include? "#{cellTimeStampArray[2]}")
                    i = 0
                    r.find_elements(:tag_name, "td").each do |cell|
                        i += 1
                        if i == 2
                            return cell.text
                        end
                    end
                end
            end
        end
    end
end

# FUNCTION TO ITERATE BACK TO CELL WITH "RUNNING/SUCEED" TEXT IN ORDER TO BREAK WHILE LOOP OF 'STILL RUNNING' ***SAVES cell.text IN RETURN STATEMENT***
def iterate_to_cellB3(band, table, bandNum, userNameVar, my_date, cellTimeStampArray)
    table.find_elements(:tag_name, "tr").each do |r|  
        if r.text.include? "#{userNameVar}" && r.text.include? "#{bandNum}" && r.text.include? "#{my_date}" && r.text.include? "B-3"
            if not r.text.include? "FAIL"
                if (r.text.include? "#{cellTimeStampArray[0]}") || (r.text.include? "#{cellTimeStampArray[1]}") || (r.text.include? "#{cellTimeStampArray[2]}")
                    i = 0
                    r.find_elements(:tag_name, "td").each do |cell|
                        i += 1
                        if i == 2
                            return cell.text
                        end
                    end
                end
            end
        end
    end
end

# FUNCTION TO ITERATE BACK TO CELL WITH "RUNNING/SUCEED" TEXT IN ORDER TO BREAK WHILE LOOP OF 'STILL RUNNING' ***SAVES cell.text IN RETURN STATEMENT***
def iterate_to_cellA2(band, table, bandNum, userNameVar, my_date, cellTimeStampArray)
    table.find_elements(:tag_name, "tr").each do |r|  
        if r.text.include? "#{userNameVar}" && r.text.include? "#{bandNum}" && r.text.include? "#{my_date}" && r.text.include? "A-2"
            if not r.text.include? "FAIL"
                if (r.text.include? "#{cellTimeStampArray[0]}") || (r.text.include? "#{cellTimeStampArray[1]}") || (r.text.include? "#{cellTimeStampArray[2]}")
                        i = 0
                        r.find_elements(:tag_name, "td").each do |cell|
                            i += 1
                            if i == 2
                                return cell.text
                            end
                        end
                    end
                end
            end
        end
    end
end

# FUNCTION TO ITERATE TO CELL WITH HREF DOWNLOAD LINK
def iterate_to_hrefCells(band, table, bandNum, files_href, userNameVar, cellTimeStampArray)
    table.find_elements(:tag_name, "tr").each do |r|  
        if r.text.include? "#{userNameVar}" && r.text.include? "#{bandNum}" && r.text.include? "#{$_my_date}"
            if not r.text.include? "FAIL"
                if (r.text.include? "#{cellTimeStampArray[0]}") || (r.text.include? "#{cellTimeStampArray[1]}") || (r.text.include? "#{cellTimeStampArray[2]}")
                    i = 0
                    r.find_elements(:tag_name, "td").each do |cell|
                        i += 1
                        if i == 7
                            cell.find_elements(:tag_name, "a").each do |n|
                                puts "Storing n.attribute(\"href\") into array $_files_href" 
                                $_files_href << n.attribute("href")
                            end
                        end
                    end
                end
            end
        end
    end
end

# STORED BELOW CODE INTO A FUNCTION SO THAT IT CAN BE 'REQUIRED' INTO excelTestParser.rb -- CALLED FUNCTION BELOW TO KEEP CODE RUNNING LIKE ORIGINAL
def storeTable(browser)
    $_wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    # STORE THE TABLE INTO table OBJECT
    $_table = $_wait.until {
        element = $_browser.find_element(:tag_name, "table")
        element if element.displayed?
    }
end

def b7Cell(band, userNameVar, bandNum, cellTimeStampArray)
    if $_B7counter == 0
        i = 0
        r.find_elements(:tag_name, "td").each do |cell|
            i += 1
            if i == 2 # THIS REACHES THE DOWNLOAD LINK CELL IN THE TABLE
                while $_B7counter == 0
                    cellReturnText = iterate_to_cellB7(band, $_table, bandNum, userNameVar, $_my_date, cellTimeStampArray)
                    if cellReturnText == 'SUCCEED'
                        $_B7counter = 1
                        return
                    end
                    if cellReturnText == 'FAIL'
                        return
                    end
                    puts "STILL RUNNING..."
                    sleep(10) 
                    reloadButton = $_browser.find_element(:id, "refresh").click
                    # GRABS NEW REFERENCE TO TABLE AFTER REFRESH
                    $_table = $_wait.until {
                        element = $_browser.find_element(:tag_name, "table")
                    }
                    puts "After Reload, table:"
                    puts $_table
                    puts "---------------------------------------------------------"
                    sleep(5)
                    redo
                end
            end
        end
    end
end

def b3Cell(band, userNameVar, bandNum, cellTimeStampArray)
    if $_B3counter == 0                                
        i = 0
        r.find_elements(:tag_name, "td").each do |cell|
            i += 1
            if i == 2 # THIS REACHES THE DOWNLOAD LINK CELL IN THE TABLE
                while $_B3counter == 0
                    cellReturnText = iterate_to_cellB3(band, $_table, bandNum, userNameVar, $_my_date, cellTimeStampArray)
                    if cellReturnText == 'SUCCEED'
                        $_B3counter = 1
                        return 
                    end
                    puts "STILL RUNNING..."
                    sleep(10) # change this to 30 or 60
                    reloadButton = $_browser.find_element(:id, "refresh").click
                    # GRABS NEW REFERENCE TO TABLE AFTER REFRESH
                    $_table = $_wait.until {
                        element = $_browser.find_element(:tag_name, "table")
                    }
                    puts "After Reload, table:"
                    puts $_table
                    puts "---------------------------------------------------------"
                    sleep(5)
                    redo
                end
            end
        end
    end
end

def a2Cell(band, userNameVar, bandNum, cellTimeStampArray)
    if r.text.include? "RUNNING"
        # BELOW if ACCOUNTS FOR SECOND A2
        if $_A2counter == 0
            i = 0
            r.find_elements(:tag_name, "td").each do |cell|
                i += 1
                if i == 2 # THIS REACHES THE DOWNLOAD LINK CELL IN THE TABLE
                    while cell.text == 'RUNNING'
                        cellReturnText = iterate_to_cellA2(band, $_table, bandNum, userNameVar, $_my_date, cellTimeStampArray)
                        if cellReturnText == 'SUCCEED'
                            $_A2counter = 1
                            return 
                        end
                        puts "STILL RUNNING..."
                        sleep(10) 
                        reloadButton = $_browser.find_element(:id, "refresh").click
                        # GRABS NEW REFERENCE TO TABLE AFTER REFRESH
                        $_table = $_wait.until {
                            element = $_browser.find_element(:tag_name, "table")
                        }
                        puts "After Reload, table:"
                        puts $_table
                        puts "---------------------------------------------------------"
                        sleep(5)
                        redo
                    end
                end
            end
        end
    end
end

# ITERATE THROUGH TABLE ROWS, THEN TABLE CELLS THEN STORE HREF LINKS OF DOWNLOAD LINK INTO ARRAY files_href
def checkHref(band, userNameVar, browser, bandNum, cellTimeStampArray)
    functionCounter = 0
    cellReturnText = ""
    # ACCOUNTING FOR SOUTH KOREA BEING 16 HOURS AHEAD
    date = DateTime.now + (16.0/24)
    $_my_date = date.strftime("%Y/%m/%d")
    $_table.find_elements(:tag_name, "tr").each do |r|  
        if r.text.include? "#{userNameVar}" && r.text.include? "#{bandNum}" && r.text.include? "#{$_my_date}"
            if ((r.text.include? "#{cellTimeStampArray[0]}") || (r.text.include? "#{cellTimeStampArray[1]}") || (r.text.include? "#{cellTimeStampArray[2]}"))
                if  r.text.include? "B-7"
                    b7Cell(band, userNameVar, bandNum, cellTimeStampArray)
                end
                if r.text.include? "B-3"
                    b3Cell(band, userNameVar, bandNum, cellTimeStampArray)
                end
                if r.text.include? "A-2"
                    a2Cell(band, userNameVar, bandNum, cellTimeStampArray)
                end
                functionCounter += 1 
            end
        end
    end
end

# CHECK IF DOWNLOAD LINK EXISTS, IF SO CALLS iterate_to_hrefCells TO STORE HREF LINK TO DOWNLOAD INTO files_href ARRAY
def storeReadyDownloadLink(band, table, bandNum, userNameVar, files_href, cellTimeStampArray)
    puts "(storeReadyDownloadLink) calling iterate_to_hrefCells..."
    iterate_to_hrefCells(band, $_table, bandNum, files_href, userNameVar, cellTimeStampArray)
    puts "(storeReadyDownloadLink) $_files_href now:"
    ap $_files_href
end

# FUNCTION TO CHECK IF DOWNLOAD LINK IS READY IN CELL, IF NOT RELOAD PAGE, IF SO, STORE INTO $_files_href ARRAY
def checkTableDownload(bandsArray, cellTimeStampArray)
    $_B7counter = 0
    $_B3counter = 0
    $_A2counter = 0
    $_files_href = []
    band = bandsArray[0]
    i = 0
    while (($_B7counter == 0 || $_B3counter == 0 || $_A2counter == 0) && (i < 3))
        # MIGHT NEED TO MAKE cellReturnText INTO EMPTY STRING HERE TO RESET IT FOR EACH LOOP FOR EACH BAND IN ARRAY
        checkHref(band, $_userNameVar, $_browser, $_table, band.bandNum, cellTimeStampArray)
        puts"(checkTableDownload) loop 'while $_B7counter == 0 || $_B3counter == 0 || $_A2counter == 0' restarting"
        i += 1
    end
    storeReadyDownloadLink(band, $_table, band.bandNum, $_userNameVar, $_files_href, cellTimeStampArray)
end

# NAVIGATE GOES TO URI WHICH DOWNLOADS EXCEL FILE FROM ARRAY $_files_href 
def downloadFile(browser, files_href)
    files_href = files_href.uniq
    len = files_href.length

    i = 0
    while i < len
        $_browser.navigate().to("#{files_href[i]}")
        puts "Downloading ==> #{files_href[i]}"
        i += 1
        sleep(7)     
    end
end

