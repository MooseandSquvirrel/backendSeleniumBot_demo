def b71_b3_a2_Drivers(eventNamesArray, bandsLength, bandsArray, initialCellTimeStampArray)
        "-------------------- b7_1Driver -----------------------" # MAKE THIS A FUNCTION?
        b7_1Driver(eventNamesArray, bandsLength)
        initialCellTimeStampArray << timestampB71(bandsArray)
        clickit()
        # initialCellTimeStampArray << timestampB71(bandsArray) ## TESTING THIS INFRONT OF clickit THE INCREASE ACCURACY OF TIMESTAMP
        puts"(b71_b3_a2_Drivers) initialCellTimeStampArray b71:"
        ap initialCellTimeStampArray
        alert_clickit()
       
        "-------------------- b3 -------------------------" # MAKE THIS A FUNCTION?
        "MIGHT NEED TO navigate() (SLIGHTLY ALTERED NAVIGATE) TO iFrame FOR THIS TO BE ABLE TO WORK"
        b3(eventNamesArray, bandsLength)
        initialCellTimeStampArray << timestampB3(bandsArray)
        clickit() # "CHANGE THIS TO INCLUDE NEW DATA"
        # initialCellTimeStampArray << timestampB3(bandsArray) 
        puts"(b71_b3_a2_Drivers) initialCellTimeStampArray b3:"
        ap initialCellTimeStampArray
        alert_clickit() # "CHANGE THIS TO INCLUDE NEW DATA"
        "==================== a2 =========================" # MAKE THIS A FUNCTION?
        "MIGHT NEED TO navigate() (SLIGHTLY ALTERED NAVIGATE) TO iFrame FOR THIS TO BE ABLE TO WORK"
        
        # THIS IS TO GRAB A2 INFO FROM JUST ONE (OR IN THIS CASE THE FIRST) BAND FOR ENTERING START AND END DATES INTO FIELD IN DRIVER
        band = bandsArray[0]
        a2_Driver(eventNamesArray, bandsLength, band)
        initialCellTimeStampArray << timestampA2(bandsArray)
        clickit()
        # initialCellTimeStampArray << timestampA2(bandsArray)
        puts"(b71_b3_a2_Drivers) initialCellTimeStampArray a2:"
        ap initialCellTimeStampArray
        alert_clickit()
        alert_clickit()
        puts "initialCellTimeStampArray Array:"
        ap initialCellTimeStampArray
end