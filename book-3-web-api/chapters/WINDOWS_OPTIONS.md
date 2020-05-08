# Windows Options for Mac Users

## Bootcamp

### General

- Only an option for computers that are 2012 or newer
- Newest Macs seemed a little more unstable than older models, but it's not too bad. It's still a viable option. I think this is due to windows driver issues

### Installation

- The Bootcamp Assistant process can be slow and can fail at the end requiring a retry
- The windows installation processes crashed for a student, requirint a re-install of the Apple drivers

### Day-to-day Operation

- The touchbar didn't work for a student until he re-installed the Apple drivers
- Some complaints of trackpad jankiness
- Some complaints of sleep issues. Computer wouldn't wake up or computer rebooted into Mac OS after sleep


## Wndows To Go

### General

- Only an option for computers that are 2012 or newer
- My students used SanDisk Extreme Portable drives. They put velcro strips on the drives and the back of their Macbooks to attach the drive so they wouldn't have to carry it around

### Installation

- Instructions: https://github.com/nashville-software-school/bangazon-inc/blob/master/book-2-platform-api/chapters/WINDOWS_TO_GO.md
- Windows version 1808 did NOT work. It blue-screened. 1803 did work
- Newer Macs will require an external keyboard and mouse during the windows installation process. Windows does not come with drivers that work for the newer Macs. The keyboard and trackpad will work after Apple drivers are installed
- You will need a windows machine that can format the drive. I recommend a real windows pc and not VM

### Day-to-day Operations

- Battery drains faster in windows
- Trackpad is less responsive


## Virtualbox

### General

- Only option for older Macs

### Installation

- Make sure to increase the number of processers to at least half the available procs after installation
- Zoom the screen to 200% during installation
- Do install the Virtualbox tools
- Do enable copy and paste between host and guest

### Day-to-day Operations

- Slow, but works
- Network somtimes goes away, turning WIFI off and on again on the Mac usually fixes it