# InstagramFirebase
An Instagram-like app using Firebase as it's database store

1. Install Cocoapods by typing the following command in the terminal
   sudo gem install cocoapods
   
2. Initiaze the pod file using the command
   pod init
   
3. Give the following pods in the Pod file
  target 'ProjectFirebase' do
  
   use_frameworks!
    pod 'Firebase/Analytics'
    pod 'Firebase/Auth'
    pod 'Firebase/Crashlytics'
    pod 'Firebase/Database'
    pod 'Firebase/Messaging'
    pod 'Firebase/MLVision'
    pod 'Firebase/Performance'
    pod 'Firebase/Storage'
    pod 'FirebaseUI/Anonymous'
    pod 'FirebaseUI/Auth'
    pod 'FirebaseUI/Google'
    pod 'ImagePicker'
    pod 'Lightbox'
    pod 'MaterialComponents/BottomAppBar'
    pod 'MaterialComponents/Buttons+ColorThemer'
    pod 'MaterialComponents/Cards'
    pod 'MaterialComponents/Chips'
    pod 'MaterialComponents/Dialogs'
    pod 'MaterialComponents/Dialogs+ColorThemer'
    pod 'MaterialComponents/Snackbar'
    pod 'MaterialComponents/TextFields'
    pod 'MaterialComponents/List'
    pod 'SDWebImage'
    pod 'Firebase/Core'
    pod 'MessageKit'
    pod 'Google-Mobile-Ads-SDK'
    pod 'Firebase/Firestore'
    pod 'Firebase/Messaging'
    
4. Now install the pods in the project
   pod install
