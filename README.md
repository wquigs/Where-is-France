# Where-is-France
An app that points you in the direction of France.
This was made in collaboration with Corey Briscoe and Blythe Hammett

![Simulator Screen Shot - iPhone SE (2nd generation) - 2022-09-01 at 12 52 40](https://user-images.githubusercontent.com/112192138/187972693-0e831576-e2c0-4d0b-949a-d4a47a996130.png)

The map view screen is used for displaying the user's distance from France, along with the direction towards France. The user can interact with this view by tapping anywhere on the map view. That will cause the arrow to spin around and ultimately land in the direction of France.

![Simulator Screen Shot - iPhone SE (2nd generation) - 2022-09-01 at 12 58 50](https://user-images.githubusercontent.com/112192138/187972357-6f56b1bd-1a76-453d-b6d6-923f58fe7eb9.png)

The purpose of the records screen is to keep track of the user's closest distances to France. The distance in meters, as well as the date achieved are displayed. There is nothing to interact with on this screen. Only the top three distances are recorded, and only one distance is stored per day. The table intentionally always has three cells, even when there are less than three appropriate records. This was a purposeful design decision so the user can implicitly see that we keep their top three records, to encourage them to come back again in the future. 

![Simulator Screen Shot - iPhone SE (2nd generation) - 2022-09-01 at 12 54 52](https://user-images.githubusercontent.com/112192138/187972719-6e57ca27-8977-4029-ab27-69d917e30829.png)

The colors screen is used for changing the color of the arrow. The arrow can interact with this screen by clicking on one of the boxes corresponding to the color that they want the arrow to be. The arrow color change is stored persistently, so the color will stay the same even after the user closes the application.

We used Xcode version 13.2.1 to compile our project. To accurately get the user's location, iOS hardware is required for testing. The only thing our app requires is location tracking, which is present on pretty much all iOS devices. The app still functions correctly on the simulator, but the location isn't always completely accurate.
Our app follows the M-V-C architectural pattern.
