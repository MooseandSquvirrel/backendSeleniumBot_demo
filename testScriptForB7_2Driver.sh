# SCRIPT TO AUTOMATE TEST RUNS FOR B7-2 DRIVER :) ('\n' are the enter button for the command line arguements infront of them)
# NOW TRYING TO ACCESS BACKEND UNLIKE TESTERRUN.SH TESTING, SO NOW ADDING APPROPRIATE ARGUEMENTS BELOW FOR BACKEND ACCESS (USERNAME PWD INSTEAD OF 'Y')

# IN ORDER FOR PWD() FUNCTION TO WORK WITH THIS TEST SCRIPT --MUST DISABLE INVISIABLE TEXT ENTER TEMPORARILY FOR COMMANDLINE 
                                                                                                                    
printf 'y\n9252091488\ny\nCAZ0412\ny\nIhavethepower1!\ny\neventName\ny\nBrandName\ny\n16/06/2019\ny\n4\ny\n74311255\ny\n\neventName\ny\nBrandName\ny\n4\ny\n74311251\ny\ngo\n' | ruby fixit.rb 
                                                                                                                    #  ^^^ double new line for hitting 'enter'
                                                                                                                    # to put a second band's info into array 