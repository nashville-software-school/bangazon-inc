# Heist Part II

- Knocking over banks isn't going to be easy. Alarms... Vaults... Security Guards.... Each of these safeguards is something we'll have to handle for a successful heist. First things first. Let's create a `Bank` class to represent the security we're up against. Give the `Bank` class the following properties:
  - An integer property for `CashOnHand`
  - An integer property for `AlarmScore`
  - An integer property for `VaultScore`
  - An integer property for `SecurityGuardScore`
  - A _computed_ boolean property called `IsSecure`. If _all_ the scores are less than or equal to 0, this should be `false`. If _any_ of the scores are above 0, this should be `true`

- Each type of robber will have a special skill that will come in handy while knocking over banks. Start by creating an interface called `IRobber`. The interface should include: 
  - A string property for `Name`
  - An integer property for `SkillLevel`
  - An integer property for `PercentageCut`
  - A method called `PerformSkill` that takes in a `Bank` parameter and doesn't return anything.

- Since bank security consists of alarms, vaults, and security guards; we'll need crew members that can deal with each of them. We'll need **hackers** to take care of the alarms; **lock pick specialists** to crack the vaults, and some good old fashion **muscle** to handle the security guards. Create three classes: `Hacker`, `Muscle`, and `LockSpecialist`. They should all implement the `IRobber` interface. Each implementation for `PerformSkill` should do three things:
    - Take the `Bank` parameter and decrement its appropraite security score by the `SkillLevel`. i.e. A Hacker with a skill level of 50 should decrement the bank's `AlarmScore` by 50.
    - Print to the console the name of the robber and what action they are performing. i.e. _"Mr. Pink is hacking the alarm system. Decreased security 50 points"_
    - If the appropriate security score has be reduced to 0 or below, print a message to the console, i.e. _"Mr Pink has disabled the alarm system!"_

Before we start trying to assemble the perfect crew, we need to know who our options are. Let's build out a rolodex of possible recruits first. We'll pick the team and plan out the actual opperation later.

- In the `Main` method, create a `List<IRobber>` and store it in a variable named `rolodex`. This list will contain all possible operatives that we could employ for future heists. We want to give the user the opportunity to add new operatives to this list, but for now let's pre-populate the list with 5 or 6 robbers (give it a mix of Hackers, Lock Specialists, and Muscle).

- When the program starts, print out the number of current operatives in the roladex. Then prompt the user to enter the name of a new possible crew member. Once the user has entered a name, print out a list of possible specialties and have the user select which specialty this operative has. The list should contain the following options
  - Hacker (Disables alarms)
  - Muscle (Disarms guards)
  - Lock Specialist (cracks vault)
  
  Once the user has selected a specialty, prompt them to enter the crew member's skill level as an integer between 1 and 100. Then prompt the user to enter the percentage cut the crew member demands for each mission. Once the user has entered the crew member's name, specialty, skill level, and cut, you should instantiate the appropriate class for that crew member (based on their specialty) and they should be added to the rolodex.
  
- Continue the above action and allow the user to enter as many crew members as they like to the rolodex until they enter a blank name before continuing.

Once the user is finished with their rolodex, it's time to begin a new heist

- The program should create a new bank object and randomly assign values for these properties:
  - AlarmScore (between 0 and 100)
  - VaultScore (between 0 and 100)
  - SecurityGuardScore (between 0 and 100)
  - CashOnHand (between 50,000 and 1 million)
  
  Let's do a little recon next. Print out a Recon Report to the user. This should tell the user what the bank's _most_ secure system is, and what its _least_ secure system is (don't print the actual integer scores--just the name, i.e. `Most Secure: Alarm` `Least Secure: Vault`
  
Now that we have a clue what kind of security we're working with, we can try to built out the perfect crew. 

- Print out a report of the rolodex that includes each person's name, specialty, skill level, and cut. Include an index in the report for each operative so that the user can select them by that index in the next step. (You may want to update the IRobber interface and/or the implementing classes to be able to print out the specialty) 

- Create a new `List<IRobber>` and store it in a variable called `crew`. Prompt the user to enter the index of the operative they'd like to include in the heist. Once the user selects an operative, add them to the `crew` list.
  
- Allow the user to select as many crew members as they'd like from the rolodex. Continue to print out the report after each crew member is selected, but the report should not include operatives that have already been added to the crew, or operatives that require a percentage cut that can't be offered.

- Once the user enters a blank value for a crew member, we're ready to begin the heist. Each crew member should perform his/her skill on the bank. Afterwards, evaluate if the bank is secure. If not, the heist was a success! Print out a success message to the user. If the bank _does_ still have positive values for any of its security properties, the heist was a failure. Print out a failure message to the user.

- If the heist was a success, print out a report of each members' take, along with how much money is left for yourself.