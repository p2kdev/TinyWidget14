#import "Tweak.h"

//Global
static double mediaPlayerHeight = 215;
//static double cornerRadius = 27; //Default 13

//Controls
static double mediaControlsOriginX = 100;
static double mediaControlsOriginY = 60;
static double mediaControlsHeight = 40;

static double volumeControlOriginY = 150;

//Corner Radius
// %hook MTMaterialView
// 	- (void)layoutSubviews
// 	{
// 		%orig;
// 		MTMaterialLayer *orig = [self _materialLayer];
//
// 		//Player
// 		if ([self.superview class] == objc_getClass("PLPlatterView"))
// 		{
// 			orig.cornerRadius = cornerRadius;
// 			//Thanks @bengiannis
// 			if (@available(iOS 13.0, *))
// 			    orig.cornerCurve = kCACornerCurveContinuous;
// 			else
// 				orig.continuousCorners = YES;
//
// 			orig.masksToBounds = YES;
// 		}
//
// 	}
// %end


//Player Height
%hook CSMediaControlsViewController

	- (CGRect)_suggestedFrameForMediaControls
	{
		CGRect frame = %orig;
		frame.size.height = mediaPlayerHeight;

		CGRect temp = self.view.superview.superview.frame;
		temp.size.height = mediaPlayerHeight;
		self.view.superview.superview.frame = temp;

		return frame;
	}

%end

//Suggestions
%hook MRUNowPlayingLabelView

	- (void)setShowSuggestionsView:(BOOL)arg1 {
		%orig(NO);
	}

%end

//Header Labels
%hook MRUNowPlayingLabelView

	- (void)setFrame: (CGRect)frame
	{
		//Only make changes for the lockscreen player by checking for parent view controller
		if([[[self _viewControllerForAncestor] parentViewController] isKindOfClass: %c(MRUCoverSheetViewController)])
			frame.origin.y = 0;
		%orig;
	}

%end

//Route Button
%hook MRUNowPlayingRoutingButton

	- (void)setFrame: (CGRect)frame
	{
		//Only make changes for the lockscreen player by checking for parent view controller
		if([[[self _viewControllerForAncestor] parentViewController] isKindOfClass: %c(MRUCoverSheetViewController)])
			frame.origin.y = 0;

		%orig;
	}

%end

//Media Controls
%hook MRUNowPlayingTransportControlsView

	- (void)setFrame: (CGRect)frame
	{
		if([[[self _viewControllerForAncestor] parentViewController] isKindOfClass: %c(MRUCoverSheetViewController)])
		{
			//Apple added constraints to the player control's, so we need to remove them before we can make any changes
			//Thanks to https://github.com/MDausch/LatchKey/blob/d898fee4a4670b0186118ffa59899c2fd1f4e71d/LatchKey.xm#L153		
			UIView *super = self.superview;
			while (super != nil) {
				for (NSLayoutConstraint *c in super.constraints) {
					if (c.firstItem == self || c.secondItem == self) {
						[super removeConstraint:c];
					}
				}
				super = super.superview;
			}

			//Remove all the constraints our object holds
			[self removeConstraints:self.constraints];
			self.translatesAutoresizingMaskIntoConstraints = YES;

			frame.origin.x = mediaControlsOriginX;
			frame.origin.y = mediaControlsOriginY;
			frame.size.width = frame.size.width - mediaControlsOriginX;
			frame.size.height = mediaControlsHeight;
		}
		%orig;
	}

%end

//Volume Slider
%hook MRUNowPlayingVolumeControlsView

	- (void)setFrame: (CGRect)frame
	{
		//Only make changes for the lockscreen player by checking for parent view controller
		if([[[self _viewControllerForAncestor] parentViewController] isKindOfClass: %c(MRUCoverSheetViewController)])
			frame.origin.y = volumeControlOriginY;

		%orig;
	}

%end
