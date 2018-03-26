# BFInfiniteHorizontalMovingView

A view which can scroll infinitely in horizontal direction. This view is desgined for the progress bar. Also it can be reused in any case which need a infinite animation.

![BFInfiniteHorizontalMovingView.gif](https://github.com/wizardguy/screenshots/raw/master/BFInfiniteHorizontalMovingView.gif)

### How To Use

1) copy the BFInfiniteHorizontalMovingView into your project
2) Add your own background image resource
3) Init your BFRatingView:

#####By code:

```swift
let aView = BFInfiniteHorizontalMovingView.newInstance(patternImage: UIImage(named: "1.jpg")!, frame: containerView.bounds)
containerView.addSubview(aView)
```
or you can change the background image via `backgroundPatternImage`

##### By Xib:

Set a view as BFInfiniteHorizontalMovingView directly.

Change the `backgroundPatternImage` paramter in inspector view.

4) Call:

```swift
aView.startMoving()
...
aView.stopMoving()
```
5) Build and Run!

Check out the demo project for more details.

#### BFInfiniteHorizontalMovingViewDelegate

A built-in view tap gesture delegate.

```swift
let aView = BFInfiniteHorizontalMovingView.newInstance(...)
aView.delegate = self
```
Note, the view's background color will be changed to hihglight by default when you tap on it.