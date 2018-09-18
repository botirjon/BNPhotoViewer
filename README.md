# BNPhotoViewer

[![CI Status](http://img.shields.io/travis/botirjon.nasridinov@gmail.com/BNPhotoViewer.svg?style=flat)](https://travis-ci.org/botirjon.nasridinov@gmail.com/BNPhotoViewer)

![](https://github.com/botirjon/BNPhotoViewer/screen2.PNG | width=100)
    
## Example

To be able to use the library, you need to first install the pod. Then import the PhotoViewerController into your project:
```ruby
import BNPhotoViewer
```
Then initliaze a BNPhotoViewer object, set its delegate, initial item index.

Example:

```ruby
let photoViewer = BNPhotoViewer()
photoViewer.delegate = self
photoViewer.initialItemIndex = 3
```
You can also perform some action when when photo viewer closes by setting its `photoViewerDidClose` closure.

```ruby
photoViewer?.photoViewerDidClose = {
    // some action here
}
```

You should also implement its delegate functions:

Example:

```ruby
extension ViewController: BNPhotoViewerDelegate {

    func numberOfItems(in photoViewer: BNPhotoViewer) -> Int {
        // provide the number of items to display
    }

    func numberOfBottomBarItems(in photoViewer: BNPhotoViewer, forItemAt index: Int) -> Int {
        // provide the number bottom bar items. 
    }

    func photoViewer(_ photoViewer: BNPhotoViewer, imageView: UIImageView, at index: Int) {
        // configure the imageView for the item at index
    }

    func photoViewer(_ photoViewer: BNPhotoViewer, leftTopBarItemsAt index: Int) -> [UIBarButtonItem] {
        // provide bar button item to display at the left of top bar
    }


    func photoViewer(_ photoViewer: BNPhotoViewer, rightTopBarItemsAt index: Int) -> [UIBarButtonItem] {
        // provide bar button item to display at the right of top bar
    }

    func photoViewer(_ photoViewer: BNPhotoViewer, bottomBarButton button: UIButton, at position: Int, forItemAt index: Int) {
        // configure the bottom bar button for the item at index
    }

    func photoViewer(_ photoViewer: BNPhotoViewer, titleForItemAt index: Int) -> String {
        // provide a title for the item at index 
    }

    func photoViewer(_ photoViewer: BNPhotoViewer, detailForItemAt index: Int) -> String {
        // provide a detail for the item at index
    }

    func photoViewer(_ photoViewer: BNPhotoViewer, didChangeState state: BNPhotoViewerState) {
        // OPTIONAL: you can perform some action when photo viewer switches between detailed and regular states 
    }
    
    func photoViewerDidClose() {
        // OPTIONAL: perform some action after it closes
    }
}
```
After this you are all set to present the photoViewer:

```ruby
self.present(photoViewer, animated: true, completion: nil)
```


## Requirements

## Installation

PhotoViewerController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BNPhotoViewer', :git => 'https://github.com/botirjon/BNPhotoViewer.git'

pod 'BNPhotoViewer'
```

## Author

Botirjon Nasridinov,  botirjon.nasridinov@gmail.com

## License

BNPhotoViewer is available under the MIT license. See the LICENSE file for more info.
