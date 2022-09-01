# Where-is-France
An app that points you in the direction of France.
This was made in collaboration with Corey Briscoe and Blythe Hammett
![Simulator Screen Shot - iPhone SE (2nd generation) - 2022-09-01 at 12 58 50](https://user-images.githubusercontent.com/112192138/187971465-59e69ab4-329b-4f9b-9857-517d1c7e0f6b.png)

![Simulator Screen Shot - iPhone SE (2nd generation) - 2022-09-01 at 12 52 40](https://user-images.githubusercontent.com/112192138/187969670-ddfc9fa9-9352-4b2f-9543-c0b1a3ec6156.png)

The map view screen is used for displaying the user's distance from France, along with the direction towards France. The user can interact with this view by tapping anywhere on the map view. That will cause the arrow to spin around and ultimately land in the direction of France.

![image](https://user-images.githubusercontent.com/112192138/187969927-16da44e4-5386-4445-8673-2ad8538a3de0.png)

The purpose of the records screen is to keep track of the user's closest distances to France. The distance in meters, as well as the date achieved are displayed. There is nothing to interact with on this screen. Only the top three distances are recorded, and only one distance is stored per day. The table intentionally always has three cells, even when there are less than three appropriate records. This was a purposeful design decision so the user can implicitly see that we keep their top three records, to encourage them to come back again in the future. 

![Simulator Screen Shot - iPhone SE (2nd generation) - 2022-09-01 at 12 54 52](https://user-images.githubusercontent.com/112192138/187970117-a1884686-bff1-467a-a5cd-5a1a714d1381.png)

The colors screen is used for changing the color of the arrow. The arrow can interact with this screen by clicking on one of the boxes corresponding to the color that they want the arrow to be. The arrow color change is stored persistently, so the color will stay the same even after the user closes the application.

We used Xcode version 13.2.1 to compile our project. To accurately get the user's location, iOS hardware is required for testing. The only thing our app requires is location tracking, which is present on pretty much all iOS devices. The app still functions correctly on the simulator, but the location isn't always completely accurate.
Our app follows the M-V-C architectural pattern.
