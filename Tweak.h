@interface SBApplication : NSObject
@end

@interface UILabel ()
- (UIColor*)customTextColor;
- (void)setCustomTextColor:(UIColor*)arg;
@end

@interface UIImageView ()
- (UIColor *)customTintColor;
- (void)setCustomTintColor:(UIColor *)arg;
@end

@interface CAShapeLayer ()
- (UIColor*)customStrokeColor;
- (void)setCustomStrokeColor:(UIColor*)arg;
@end

@interface SBMediaController: NSObject
+ (id)sharedInstance;
- (SBApplication*)nowPlayingApplication;
- (id)_nowPlayingInfo;
@end

@interface UIView ()
- (id)_viewControllerForAncestor;
- (UIColor *)customBackgroundColor;
- (void)setCustomBackgroundColor:(UIColor *)arg;
- (id)_rootView;
@end

@interface CALayer (Undocumented)
	@property (assign) BOOL continuousCorners;
@end

@interface MTMaterialLayer : CALayer
@end

@interface MTMaterialView: UIView
  -(id)_materialLayer;
@end

@interface MediaControlsMaterialView : UIView
@end

@interface PLPlatterView : UIView
@end

@interface MRUCoverSheetViewController : UIViewController
@end

@interface MRUNowPlayingLabelView : UIView
@end

@interface MRUNowPlayingRoutingButton : UIView
@end

@interface MRUNowPlayingVolumeControlsView : UIView
@end

@interface MRUTransportButton : UIView
@end

@interface MRUNowPlayingTransportControlsView : UIView
	@property (nonatomic,retain) MRUTransportButton * languageOptionsButton;
@end
