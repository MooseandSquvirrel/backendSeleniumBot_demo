def b71_b3_a2_Drivers(eventNamesArray, bandsLength, bandsArray, initialCellTimeStampArray)
        "-------------------- b7_1Driver -----------------------" 
        b7_1Driver(eventNamesArray, bandsLength)
        initialCellTimeStampArray << timestampB71(bandsArray)
        clickit()
        alert_clickit()
       
        "-------------------- b3 -------------------------" 
        b3(eventNamesArray, bandsLength)
        initialCellTimeStampArray << timestampB3(bandsArray)
        clickit() 
        alert_clickit() 

        "==================== a2 ========================="         
        band = bandsArray[0]
        a2_Driver(eventNamesArray, bandsLength, band)
        initialCellTimeStampArray << timestampA2(bandsArray)
        clickit()
        # alert_clickit() TWICE TO COVER BOTH ALERT POP-UPS
        alert_clickit()
        alert_clickit()
end