# MoviesInfo

Used MVVM Architecture

Not used XIB or StoryBoard , Everything is written in Code.

Network -> Not used any Dependecy for making API Calls , Just written a simple file to make API call.

ImageLoader -> Haven’t used Dependency for Loading Image.

HomeController -> fetch Movie from API , Also Added Pagination , Search will work Locally on the data came from API , While Serchig Pagination will not Work,Onces Serach textfield isEmpty than Pagination Will Work.

DetailController -> Made Multiple API Calls to get Data like Image , Trailor , Cast , Crew , Recommandations
- First Section will have Trailor of the Movie , on Click it will lunch Video Player , Used "XCDYouTubeKit" for this.
- Second Section will have Detail about Movie like Duration , Genre , Short Detail.
- Third and Forth Section Will be cast and Crew
- Fourth Section will be Recommandation of Movie on Click of it will go to Detail Page of Particular Moview.
- We can Change Section Position by just simply updating Section Array.

SearchController -> It will make API call to fetch data of user Search.
- added Throttel of 0.5 sec so that it will not make api call everytime when user enter somethig.
- last 5 searched Movies will be showed under Recent Search.
- On Click of result it will go to Detail Page.

