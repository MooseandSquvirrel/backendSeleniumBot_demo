
def allDrivers(eventNamesArray, bandsLength, bandsArray, initialCellTimeStampArray)
    "-------------------- b7_1Driver -----------------------" # MAKE THIS A FUNCTION?
    b7_1Driver(eventNamesArray, bandsLength)
    clickit()
    initialCellTimeStampArray << timestampB71(bandsArray)
    alert_clickit()

    "-------------------- b3 -------------------------" # MAKE THIS A FUNCTION?
    "MIGHT NEED TO navigate() (SLIGHTLY ALTERED NAVIGATE) TO iFrame FOR THIS TO BE ABLE TO WORK"
    b3(eventNamesArray, bandsLength)
    clickit() # "CHANGE THIS TO INCLUDE NEW DATA"
    initialCellTimeStampArray << timestampB3(bandsArray)
    alert_clickit() # "CHANGE THIS TO INCLUDE NEW DATA"

    "==================== a2 =========================" # MAKE THIS A FUNCTION?
    "MIGHT NEED TO navigate() (SLIGHTLY ALTERED NAVIGATE) TO iFrame FOR THIS TO BE ABLE TO WORK"

    # THIS IS TO GRAB A2 INFO FROM JUST ONE (OR IN THIS CASE THE FIRST) BAND FOR ENTERING START AND END DATES INTO FIELD IN DRIVER
    band = bandsArray[0]

    a2_Driver(eventNamesArray, bandsLength, band)
    clickit()
    initialCellTimeStampArray << timestampA2(bandsArray)
    alert_clickit()
    alert_clickit()
end