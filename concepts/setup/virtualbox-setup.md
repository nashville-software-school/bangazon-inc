
1. Visit [virtualbox.org](https://www.virtualbox.org/)
2. Click "Download Virtual Box 5.1"
3. Choose the [OS X hosts](http://download.virtualbox.org/virtualbox/5.1.14/VirtualBox-5.1.14-112924-OSX.dmg) link under the "VirtualBox 5.1.14 platform packages" bullet point.
4. Open the dmg that is downloaded
5. Run 'VirtualBox.pkg'

### Virtual Box Installer

1. Click 'Next'
2. Click 'Install'
3. type in your password when requested
4. Click 'Close'


## Using an Instructor provided VM

### Import the VM

1. First, [Download the VM](https://s3.amazonaws.com/nss-vm-images/windows/E2v2.ova). Save it to a location where you can easily find it.
2. Once the download finishes, Select the "Import Appliance".
3. Use the dialog to navigate to location of the file downloaded in Step 1. (The file will be named "E2v2") and click "Ok".
4. Make sure the checkbox for "Reinitialize the MAC Address for all network cards" is checked.
5. Click "Import"

### First Windows Boot
The VM should appear in your Left Pane named, "NSS E2".

1. Select the VM named "NSS E2" and click start.
2. Once booted up, click anywhere on the screen and enter `change_me_now` as the password.


## To Install Windows from Scratch

### Creating the Virtual Machine

1. Open VirtualBox.app
2. Click 'New'
3. Fill in 'Name' with 'Windows 8'
4. Confirm that 'Windows 8' is selected for version
5. Click 'Continue'
5. Allocate 4 GB (4096 MB) of RAM
6. Click 'Continue'
7. Select 'Create a virtual disk now'
8. Click 'Create'
9. Click 'Continue'
10. Select 'Dynamically allocated'
11. Click 'Continue'
12. Select '50GB'
13. Click 'Create'

The virtual machine has been created.

### Installing Windows

1. Click 'Start'
2. Select the (in order of priority) DVD drive, dmg file, or iso file for Windows 8
3. Click 'Start'
4. Wait a while for things to get going.

### Windows Installer

1. Click 'Next' on language options
2. Click 'Install'
3. *From here, follow windows-install-steps.md instructions from step 2 onwards to choose installation options.*