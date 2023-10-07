# Ham Radio Scripts

## TQSL Upload Scripts
|Scripts|
|-------|
|uploadtQSL.ps1|
|uploadtQSL.bat|

### Background
These scripts can be used to automate the upload of .adi log files into tQSL for uploading to Logbook of the World (LOTW). 

You should be able to adjust the folder locations to fit your needs. This is done in the PowerShell file. The lines of note in the PowerShell file you may need to modify are:

|Line|Function|
|----|--------|
|2|Set the desired log directory location|
|4|Set the install location of TrustedQSL (If different than default)|
|5|Upload directory. Defaults to the directory the script is called from.|
|6|Default tQSL location. Script currently pulls POTA Park numbers from log name based on POTA Naming Scheme|
|7|Batch file location. Ultimately the batch file can be stored anywhere.|

### How it works
The uploadtQSL.ps1 script is the main script that is executed between the pair.

**PLEASE NOTE: Locations must be set up in tQSL as the Park Designator or uploadtQSL.ps1 will need to be updated to use your naming convention. Gridsquare must match POTA Designator for the adi log.**

#### uploadtQSL.ps1
- Script checks for Dated folder (Pattern YYYYMMDD) in the selected log location
    - Create the Dated folder if it does not exist
- Gather all .adi files in the Upload Directory, splitting them out by name
- Loop through all log files
    - Pull the POTA designator out of the log file based on the default POTA convention of `[band]_POTA_[Callsign]@[PARK_DESIGNATOR]-[DATE]`. This is used as the location of the contact. If no POTA designator is present, uses the default location.
    - Assemble the path of the .adi log file
    - Call the batch file passing the install location of tQSL, Location of the contacts, Path to the log file, logging directory

#### uploadtQSL.bat
- Calls tqsl with information passed from the powershell script. 
    - Output logged to the logging directory with the naming convention `[tQSL_Location]_tqsl.txt`