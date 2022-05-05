# Technical Test - Astronaut Browser
​
Build an iOS application that retrieves and displays information about astronauts (and cosmonauts, taikonauts, etc).
​

The data can be obtained from the `astronaut` endpoint as detailed here: https://lldev.thespacedevs.com/2.2.0/swagger 

​
The app should display the astronaut names in a list, along with the name of the space agency they work for, and their profile image thumbnail. By default only 10 items are returned at a time, so your app needs to seamlessly load more items when the user scrolls near the bottom of the list.

​
The list should have some method to filter by the astronaut's status (active, retired, deceased, etc)

​
_Hint: use a query param to select the active status of astronauts. The id of 'active' status is `1` and there are 8 possible statuses in total_

​
Tapping an astronaut row should display a second screen which shows more information about the astronaut, including their full biography, date of birth, the full sized profile image, and links to their twitter, instagram and wikipedia pages (if available) - all this is in the API response. 

​
Your project should be made available in a public git repository.

​
## Hints
​
* The app should follow good UI design principles, but you have free reign on the exact layout and appearance. 
​
* You can write this app using whatever architecture you prefer, and are free to use 3rd party libraries - but you will be expected to explain these decisions. 
​
* The UI should be written using SwiftUI (preferred), or UIKit. 
​
* Some level of unit testing should also be demonstrated. 
​
* It is expected that this should take no more than approximately 4 hours. 
