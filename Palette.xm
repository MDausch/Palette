#import <Foundation/Foundation.h>
#import <UIKit/UiKit.h>
#import <objc/runtime.h>
#import <libcolorpicker.h>

#define palettePrefs @"/var/mobile/Library/Preferences/ch.mdaus.palette.plist"

@interface NCNotificationShortLookView : UIView
@property(nonatomic, strong) UIImage *icon;
-(void)setBackgroundView:(id)arg1;
-(void)colorLabels:(UIView*)view color:(UIColor *)colorToUse;
-(UIColor *)getAverageColor:(UIImage *)icon transparency:(float)alpha;
@end

@interface BSUIDateLabel : UILabel
@property(nonatomic, strong) UIColor *textColor;
-(void)setTextColor:(UIColor*)arg1;
@end

@interface BSUIDefaultDateLabel : BSUIDateLabel
@property(nonatomic, strong) UIColor *textColor;
-(void)setTextColor:(UIColor*)arg1;
@end

@interface BSUIRelativeDateLabel : BSUIDefaultDateLabel
@property (nonatomic, strong) UIColor *textColor;
-(void)setTextColor:(UIColor*)arg1;
@end

@interface _MTBackdropView : UIView
@property (nonatomic, strong) UIColor *colorMatrixColor;
@end

@interface MTMaterialView : UIView
@end

@interface MTPlatterHeaderContentView : UIView
@property(assign, nonatomic) CGFloat contentBaseline;
@property(nonatomic, strong) UIImage *icon;
-(void)setBackgroundView:(id)arg1;
-(void)colorLabels:(UIView *)parentView color:(UIColor *)colorToUse;
@end

@interface _UIBackdropEffectView :UIView
@end

@interface MediaControlsHeaderView : UIView
@property (nonatomic,retain) UIImageView * artworkView;
@property (nonatomic,retain) UIImageView * placeholderArtworkView;
@property (assign,nonatomic) BOOL shouldUsePlaceholderArtwork;
@property (nonatomic,retain) UILabel * primaryLabel;
-(UIView *)artworkBackgroundView;
-(void)colorBG:(UIView *)parentView color:(UIColor *)colorToUse isCustom:(BOOL)shouldUseCustomColor;
-(void)colorLabels:(UIView *)parentView color:(UIColor *)colorToUse;
@end


@interface WGWidgetPlatterView : UIView
@property(nonatomic, strong) UIImage *icon;
-(void)setBackgroundView:(id)arg1;
-(void)colorLabels:(UIView *)parentView color:(UIColor *)colorToUse;
@end


static NSMutableDictionary *settings;
BOOL enabled = YES;

BOOL bannersEnabled = YES;
NSInteger bannersBlurStyle = 0;
NSInteger bannersLabelColor = 0;
float bannersColorAlpha =  0.7f;
BOOL bannersCustomColorEnabled = NO;
UIColor *bannersCustomColor = [UIColor whiteColor];
BOOL bannersGradientEnabled = YES;
BOOL bannersCustomGradientColorEnabled = NO;
UIColor *bannersCustomGradientColor = [UIColor whiteColor];
float bannersGradientColorAlpha =  0.7f;
BOOL bannersUserWantsFakeHeader = NO;
float bannersFakeHeaderColorAlpha =  1.0f;
BOOL bannersHeaderCustomColorEnabled = NO;
UIColor *bannersHeaderCustomColor = [UIColor whiteColor];
NSInteger bannersFakeHeaderStyle = 2;
NSInteger bannersGradientStyle = 0;
BOOL bannersUserWantsUnderline = NO;
float bannersUnderlineColorAlpha =  0.7f;
BOOL bannersUnderlineCustomColorEnabled = NO;
UIColor *bannersUnderlineCustomColor = [UIColor whiteColor];
NSInteger bannersUnderlineStyle = 0;


BOOL widgetsEnabled = YES;
NSInteger widgetsBlurStyle = 0;
NSInteger widgetsLabelColor = 0;
float widgetsColorAlpha =  0.7f;
BOOL widgetsCustomColorEnabled = NO;
UIColor *widgetsCustomColor;
BOOL widgetsGradientEnabled = YES;
BOOL widgetsCustomGradientColorEnabled = NO;
UIColor *widgetsCustomGradientColor;
float widgetsGradientColorAlpha =  0.7f;
BOOL widgetsUserWantsFakeHeader = NO;
float widgetsFakeHeaderColorAlpha =  1.0f;
BOOL widgetsHeaderCustomColorEnabled = NO;
NSInteger widgetsFakeHeaderStyle = 2;
NSInteger widgetsGradientStyle = 0;

UIColor *widgetsHeaderCustomColor;
BOOL widgetsUserWantsUnderline = NO;
float widgetsUnderlineColorAlpha =  0.7f;
BOOL widgetsUnderlineCustomColorEnabled = NO;
UIColor *widgetsUnderlineCustomColor = [UIColor whiteColor];
NSInteger widgetsUnderlineStyle = 0;

BOOL nowPlayingEnabled = YES;
NSInteger nowPlayingBlurStyle = 0;
NSInteger nowPlayingLabelColor = 0;
float nowPlayingColorAlpha =  0.7f;

BOOL ccNowPlayingEnabled = YES;
float ccNowPlayingColorAlpha =  0.7f;


static CGFloat offset = (CGFloat)15;
// ************************************************
// ****************** Preferences *****************
// ************************************************

void refreshPrefs() {
  settings = nil;
  settings = [[NSMutableDictionary alloc] initWithContentsOfFile:[palettePrefs stringByExpandingTildeInPath]];
  if([settings objectForKey:@"enabled"])enabled = [[settings objectForKey:@"enabled"] boolValue];

  if([settings objectForKey:@"bannersEnabled"])bannersEnabled = [[settings objectForKey:@"bannersEnabled"] boolValue];
  if([settings objectForKey:@"bannersBlurStyle"])bannersBlurStyle = [[settings objectForKey:@"bannersBlurStyle"] floatValue];
  if([settings objectForKey:@"bannersLabelColor"])bannersLabelColor = [[settings objectForKey:@"bannersLabelColor"] intValue];

  if([settings objectForKey:@"bannersColorAlpha"])bannersColorAlpha = [[settings objectForKey:@"bannersColorAlpha"] floatValue];
  if([settings objectForKey:@"bannersCustomColorEnabled"])bannersCustomColorEnabled = [[settings objectForKey:@"bannersCustomColorEnabled"] boolValue];
  bannersCustomColor = LCPParseColorString([settings objectForKey:@"bannersCustomColor"], @"#2196F3");

  if([settings objectForKey:@"bannersGradientEnabled"])bannersGradientEnabled = [[settings objectForKey:@"bannersGradientEnabled"] boolValue];
  if([settings objectForKey:@"bannersGradientStyle"])bannersGradientStyle = [[settings objectForKey:@"bannersGradientStyle"] intValue];
  if([settings objectForKey:@"bannersGradientColorAlpha"])bannersGradientColorAlpha = [[settings objectForKey:@"bannersGradientColorAlpha"] floatValue];
  if([settings objectForKey:@"bannersCustomGradientColorEnabled"])bannersCustomGradientColorEnabled = [[settings objectForKey:@"bannersCustomGradientColorEnabled"] boolValue];
  bannersCustomGradientColor = LCPParseColorString([settings objectForKey:@"bannersCustomGradientColor"], @"#2196F3");

  if([settings objectForKey:@"bannersUserWantsFakeHeader"])bannersUserWantsFakeHeader = [[settings objectForKey:@"bannersUserWantsFakeHeader"] boolValue];
  if([settings objectForKey:@"bannersFakeHeaderStyle"])bannersFakeHeaderStyle = [[settings objectForKey:@"bannersFakeHeaderStyle"] intValue];
  if([settings objectForKey:@"bannersFakeHeaderColorAlpha"])bannersFakeHeaderColorAlpha = [[settings objectForKey:@"bannersFakeHeaderColorAlpha"] floatValue];
  if([settings objectForKey:@"bannersHeaderCustomColorEnabled"])bannersHeaderCustomColorEnabled = [[settings objectForKey:@"bannersHeaderCustomColorEnabled"] boolValue];
  bannersHeaderCustomColor = LCPParseColorString([settings objectForKey:@"bannersHeaderCustomColor"], @"#2196F3");

  if([settings objectForKey:@"bannersUserWantsUnderline"])bannersUserWantsUnderline = [[settings objectForKey:@"bannersUserWantsUnderline"] boolValue];
  if([settings objectForKey:@"bannersUnderlineStyle"])bannersUnderlineStyle = [[settings objectForKey:@"bannersUnderlineStyle"] intValue];
  if([settings objectForKey:@"bannersUnderlineColorAlpha"])bannersUnderlineColorAlpha = [[settings objectForKey:@"bannersUnderlineColorAlpha"] floatValue];
  if([settings objectForKey:@"bannersUnderlineCustomColorEnabled"])bannersUnderlineCustomColorEnabled = [[settings objectForKey:@"bannersUnderlineCustomColorEnabled"] boolValue];
  bannersUnderlineCustomColor = LCPParseColorString([settings objectForKey:@"bannersUnderlineCustomColor"], @"#2196F3");


  if([settings objectForKey:@"widgetsEnabled"])widgetsEnabled = [[settings objectForKey:@"widgetsEnabled"] boolValue];
  if([settings objectForKey:@"widgetsBlurStyle"])widgetsBlurStyle = [[settings objectForKey:@"widgetsBlurStyle"] floatValue];
  if([settings objectForKey:@"widgetsLabelColor"])widgetsLabelColor = [[settings objectForKey:@"widgetsLabelColor"] intValue];

  if([settings objectForKey:@"widgetsColorAlpha"])widgetsColorAlpha = [[settings objectForKey:@"widgetsColorAlpha"] floatValue];
  widgetsCustomColor = LCPParseColorString([settings objectForKey:@"widgetsCustomColor"], @"#2196F3");
  if([settings objectForKey:@"widgetsCustomColorEnabled"])widgetsCustomColorEnabled = [[settings objectForKey:@"widgetsCustomColorEnabled"] boolValue];

  if([settings objectForKey:@"widgetsGradientEnabled"])widgetsGradientEnabled = [[settings objectForKey:@"widgetsGradientEnabled"] boolValue];
  if([settings objectForKey:@"widgetsGradientStyle"])widgetsGradientStyle = [[settings objectForKey:@"widgetsGradientStyle"] intValue];
  if([settings objectForKey:@"widgetsGradientColorAlpha"])widgetsGradientColorAlpha = [[settings objectForKey:@"widgetsGradientColorAlpha"] floatValue];
  if([settings objectForKey:@"widgetsCustomGradientColorEnabled"])widgetsCustomGradientColorEnabled = [[settings objectForKey:@"widgetsCustomGradientColorEnabled"] boolValue];
  widgetsCustomGradientColor = LCPParseColorString([settings objectForKey:@"widgetsCustomGradientColor"], @"#2196F3");

  if([settings objectForKey:@"widgetsUserWantsFakeHeader"])widgetsUserWantsFakeHeader = [[settings objectForKey:@"widgetsUserWantsFakeHeader"] boolValue];
  if([settings objectForKey:@"widgetsFakeHeaderStyle"])widgetsFakeHeaderStyle = [[settings objectForKey:@"widgetsFakeHeaderStyle"] intValue];
  if([settings objectForKey:@"widgetsFakeHeaderColorAlpha"])widgetsFakeHeaderColorAlpha = [[settings objectForKey:@"widgetsFakeHeaderColorAlpha"] floatValue];
  if([settings objectForKey:@"widgetsHeaderCustomColorEnabled"])widgetsHeaderCustomColorEnabled = [[settings objectForKey:@"widgetsHeaderCustomColorEnabled"] boolValue];
  widgetsHeaderCustomColor = LCPParseColorString([settings objectForKey:@"widgetsHeaderCustomColor"], @"#2196F3");

  if([settings objectForKey:@"widgetsUserWantsUnderline"])widgetsUserWantsUnderline = [[settings objectForKey:@"widgetsUserWantsUnderline"] boolValue];
  if([settings objectForKey:@"widgetsUnderlineStyle"])widgetsUnderlineStyle = [[settings objectForKey:@"widgetsUnderlineStyle"] intValue];
  if([settings objectForKey:@"widgetsUnderlineColorAlpha"])widgetsUnderlineColorAlpha = [[settings objectForKey:@"widgetsUnderlineColorAlpha"] floatValue];
  if([settings objectForKey:@"widgetsUnderlineCustomColorEnabled"])widgetsUnderlineCustomColorEnabled = [[settings objectForKey:@"widgetsUnderlineCustomColorEnabled"] boolValue];
  widgetsUnderlineCustomColor = LCPParseColorString([settings objectForKey:@"widgetsUnderlineCustomColor"], @"#2196F3");



  if([settings objectForKey:@"nowPlayingEnabled"])nowPlayingEnabled = [[settings objectForKey:@"nowPlayingEnabled"] boolValue];
  if([settings objectForKey:@"nowPlayingColorAlpha"])nowPlayingColorAlpha = [[settings objectForKey:@"nowPlayingColorAlpha"] floatValue];

  if([settings objectForKey:@"ccNowPlayingEnabled"])ccNowPlayingEnabled = [[settings objectForKey:@"ccNowPlayingEnabled"] boolValue];
  if([settings objectForKey:@"ccNowPlayingColorAlpha"])ccNowPlayingColorAlpha = [[settings objectForKey:@"ccNowPlayingColorAlpha"] floatValue];
}


static void PreferencesChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
  refreshPrefs();
}


// ************************************************
// ******************* Colorizer ******************
// ************************************************


//Thanks to stack overflow: https://stackoverflow.com/questions/5562095/average-color-value-of-uiimage-in-objective-c/42002273
struct pixel {
    unsigned char r, g, b, a;
};


static UIColor *dominantColorFromIcon(UIImage *icon, float alpha){
	UIImage *iconImage = icon ;
	NSUInteger red = 0;
	NSUInteger green = 0;
	NSUInteger blue = 0;
    NSUInteger numberOfPixelsCounted = 0;

	CGImageRef iconCGImage = iconImage.CGImage;
	struct pixel *pixels = (struct pixel *)calloc(1, iconImage.size.width * iconImage.size.height * sizeof(struct pixel));
	if (pixels != nil){
		CGContextRef context = CGBitmapContextCreate((void *)pixels, iconImage.size.width, iconImage.size.height, 8, iconImage.size.width * 4, CGImageGetColorSpace(iconCGImage), kCGImageAlphaPremultipliedLast);
		if (context != NULL) {
			CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, iconImage.size.width, iconImage.size.height), iconCGImage);
			NSUInteger numberOfPixels = iconImage.size.width * iconImage.size.height;
			for (int i = 0; i < numberOfPixels; i+=3) { //Only count every 10 pixels for speed
          if ((((pixels[i].r * .299 + pixels[i].g * .587 + pixels[i].b * .114))< 230) && (((pixels[i].r * .299 + pixels[i].g * .587 + pixels[i].b * .114) > 20))){

				      red += pixels[i].r;
				      green += pixels[i].g;
				      blue += pixels[i].b;
              numberOfPixelsCounted++;
          }
			}
			red /= numberOfPixelsCounted;
			green /= numberOfPixelsCounted;
			blue /= numberOfPixelsCounted;
			CGContextRelease(context);
		}
		free(pixels);
	}
	return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}


// ************************************************
// ****************** Now Playing *****************
// ************************************************

%hook MediaControlsHeaderView
-(void)primaryLabel{

    //Yeah this is fucked right here. Good thing I found a better way to do it in
    //Album art as background. It works so much better and is a lot less hacky
    UIView *bg = self.superview.superview.superview.superview.superview;

    UIColor * bgColor = dominantColorFromIcon(self.artworkView.image,nowPlayingColorAlpha);

    if((nowPlayingEnabled || ccNowPlayingEnabled ) && enabled){
        if(self.shouldUsePlaceholderArtwork == NO)
            [self colorBG:bg color:bgColor isCustom:YES];
        else
            [self colorBG:bg color:[UIColor clearColor] isCustom:NO];
    }


    return %orig;
}


%new
- (void)colorBG:(UIView *)parentView color:(UIColor *)colorToUse isCustom:(BOOL)shouldUseCustomColor{
    //Color the CC  View
    if(ccNowPlayingEnabled) {
      if([parentView isKindOfClass:[objc_getClass("_MTBackdropView") class]]){
        _MTBackdropView *ccBack = (_MTBackdropView *)parentView;
        if(shouldUseCustomColor){
          UIColor * color = [colorToUse colorWithAlphaComponent:ccNowPlayingColorAlpha];
          ccBack.superview.backgroundColor = color;
          ccBack.colorMatrixColor = [UIColor clearColor];
          ccBack.layer.opacity = 0; //Get rid of that black overlay for the cc widget
          ccBack.superview.layer.cornerRadius = 19;
        }else{
          ccBack.superview.backgroundColor = colorToUse;
          ccBack.colorMatrixColor = [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:.5]; //Replace it with the old one if not coloring
          ccBack.layer.opacity = 1;
        }    //TODO make this fetch the original color, so if some tweak sets it we dont override
        return;
      }
    }

    //Color the blur view for the NCWidget
    if([parentView isKindOfClass:[objc_getClass("_UIBackdropEffectView") class]]){
        _UIBackdropEffectView *npBack = (_UIBackdropEffectView *)parentView;
            npBack.backgroundColor = colorToUse;
            //UIView *bgColorViewNC = npBack.superview.superview.superview;

        return;
    }

    for (UIView *subview in parentView.subviews){
        [self colorBG:subview color:colorToUse isCustom:shouldUseCustomColor];
    }
}


%new
- (void)colorLabels:(UIView *)parentView color:(UIColor *)colorToUse{
    switch(nowPlayingLabelColor){
        case(1):
            colorToUse = [UIColor whiteColor];
            break;
        case(2):
            colorToUse = [UIColor blackColor];
            break;
        default:
            break; //Use adaptive color

    }

    //Update UITextView Label to Color
    if([parentView isKindOfClass:[UITextView class]]){
        UITextView *label = (UITextView *)parentView;
        label.textColor = colorToUse;
        return;
    }

    if([parentView isKindOfClass:[UILabel class]]){
        UILabel *label = (UILabel *)parentView;
        label.textColor = colorToUse;
        return;
    }

    //If we are not a label, search all subviews for the label
    for (UIView *subview in parentView.subviews){
        [self colorLabels:subview color:colorToUse];
    }
}
%end


// ************************************************
// ****************** Widgets *********************
// ************************************************

%hook WGWidgetPlatterView
-(void)setIcon:(id)arg1{
    %orig;

    const CGFloat width = [UIScreen mainScreen].bounds.size.width;
    if(enabled && widgetsEnabled){
        //UIImage *iconImage = arg1;
        UIImage *iconImage = self.icon;

        UIColor *iconColor;

        //Determine constant color
        if(widgetsCustomColorEnabled)
          iconColor = widgetsCustomColor;
        else
          iconColor = dominantColorFromIcon(iconImage,widgetsColorAlpha);

        CGFloat offsetFixed =  ((offset - self.icon.size.width) * 1.5 + self.icon.size.width) ;

        //Break down the color so we can figure out relative data coloring
        const CGFloat* iconComponents = CGColorGetComponents(iconColor.CGColor);
        CGFloat iconRed = iconComponents[0];
        CGFloat iconGreen = iconComponents[1];
        CGFloat iconBlue = iconComponents[2];

        if(widgetsCustomColorEnabled)
          iconColor = [UIColor colorWithRed: iconRed green:iconGreen blue:iconBlue alpha:widgetsColorAlpha];

        //TODO We need a beter way to get the height of the view. I think I have this worked out
        //For a rewrite but havent had time to fully implement
        UIView *bg=[[UIView alloc]initWithFrame:CGRectMake(0,0,width,1500)];

        if((widgetsBlurStyle == 1 || widgetsBlurStyle == 2) || widgetsBlurStyle == 0){
            UIVisualEffect *blurEffect;
            if(widgetsBlurStyle == 2)
                blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            else
                blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];

            UIVisualEffectView *blurEffectView;
            blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            blurEffectView.frame = bg.bounds;
            [bg addSubview:blurEffectView];
        }

        //The color view
        UIView *colorView =[[UIView alloc]initWithFrame:bg.frame];

        //Calculate if we need black or white tect based on brightness.
        //TODO Again I Hav found a better way for future rewrite
        float luminence = (iconComponents[0]) * .299 + (iconComponents[1]) * .587 + (iconComponents[2]) * .114;
        if(luminence > .7) //should use white
            [self colorLabels:(UIView *)self.superview.superview.superview.superview  color:[UIColor blackColor]];
        else //Should use black
            [self colorLabels:(UIView *)self.superview.superview.superview.superview  color:[UIColor whiteColor]];


        if(widgetsGradientEnabled) {
          //TODO REWRITE - Const addition/subtraction value to set.
          //If gradient enabled
          switch(widgetsGradientStyle){
            case(1):
              if(iconRed + .2 > 1)
                iconRed = 1;
              else
                iconRed = iconRed + .2;

              if(iconGreen + .2 > 1)
                iconGreen = 1;
              else
                iconGreen = iconGreen + .2;
              if(iconBlue + .2 > 1)
                iconBlue = 1;
              else
                iconBlue = iconBlue + .2;
              break;
            case(2):
              if(iconRed - .2 < 0)
                iconRed = 0;
              else
                iconRed = iconRed - .2;

              if(iconGreen - .2 < 0)
                iconGreen = 0;
              else
                iconGreen = iconGreen - .2;

              if(iconBlue - .2 < 0)
                iconBlue = 0;
              else
                iconBlue = iconBlue - .2;
              break;
            default:
              break; //Use regular color
          }

          //Create gradient view
          CAGradientLayer *gradient = [CAGradientLayer layer];
          gradient.startPoint = CGPointMake(0, 0.5);
          gradient.endPoint = CGPointMake(1, 0.5);
          gradient.frame = colorView.bounds;

          if(widgetsCustomGradientColorEnabled){
            const CGFloat* customGradientComponents = CGColorGetComponents(widgetsCustomGradientColor.CGColor);
            CGFloat customGradientRed = customGradientComponents[0];
            CGFloat customGradientGreen = customGradientComponents[1];
            CGFloat customGradientBlue = customGradientComponents[2];
            gradient.colors = @[(id) iconColor.CGColor , (id)[UIColor colorWithRed:customGradientRed green:customGradientGreen blue:customGradientBlue alpha:widgetsGradientColorAlpha].CGColor];
          }else
            gradient.colors = @[(id) iconColor.CGColor , (id)[UIColor colorWithRed:iconRed green:iconGreen blue:iconBlue alpha:widgetsGradientColorAlpha].CGColor];

          [colorView.layer insertSublayer:gradient atIndex:0];
        }else
          [colorView setBackgroundColor: iconColor];

        bg.clipsToBounds= YES;

        //Fake Header Stuff
        if(widgetsUserWantsFakeHeader){
          UIView *fakeHeader=[[UIView alloc]initWithFrame:CGRectMake(0,0,width,offsetFixed)];
          UIColor * headerColor = iconColor;
          if(widgetsCustomColorEnabled)
            headerColor = dominantColorFromIcon(iconImage,widgetsFakeHeaderColorAlpha);
          if(widgetsHeaderCustomColorEnabled)
            headerColor = widgetsHeaderCustomColor;

          const CGFloat* headerComponents = CGColorGetComponents(headerColor.CGColor);
          CGFloat headerRed = headerComponents[0];
          CGFloat headerGreen = headerComponents[1];
          CGFloat headerBlue = headerComponents[2];

          if(!widgetsHeaderCustomColorEnabled){
            switch(widgetsFakeHeaderStyle){
              case(1):
                if(headerRed + .1 > 1)
                  headerRed = 1;
                else
                  headerRed = headerRed + .1;

                if(headerGreen + .1 > 1)
                  headerGreen = 1;
                else
                  headerGreen = headerGreen + .1;

                if(headerBlue + .1 > 1)
                  headerBlue = 1;
                else
                  headerBlue = headerBlue + .1;
                break;
              case(2):
                if(headerRed - .1 < 0)
                  headerRed = 0;
                else
                  headerRed = headerRed - .1;

                if(headerGreen - .1 < 0)
                  headerGreen = 0;
                else
                  headerGreen = headerGreen - .1;

                if(headerBlue - .1 < 0)
                  headerBlue = 0;
                else
                  headerBlue = headerBlue - .1;
                break;
              default:
                break; //Use regular color
            }
          }

          [fakeHeader setBackgroundColor: [UIColor colorWithRed:headerRed green:headerGreen blue:headerBlue alpha:widgetsFakeHeaderColorAlpha]];
          [colorView addSubview:fakeHeader];
          [colorView bringSubviewToFront:fakeHeader];

        }


        if(widgetsUserWantsUnderline){

          UIView *underline=[[UIView alloc]initWithFrame:CGRectMake(0,offsetFixed,width,1)];
          UIColor * underlineColor = iconColor;
          if(widgetsCustomColorEnabled)
            underlineColor = dominantColorFromIcon(iconImage,widgetsUnderlineColorAlpha);
          if(widgetsUnderlineCustomColorEnabled)
            underlineColor = widgetsUnderlineCustomColor;

          const CGFloat* underlineComponents = CGColorGetComponents(underlineColor.CGColor);
          CGFloat underlineRed = underlineComponents[0];
          CGFloat underlineGreen = underlineComponents[1];
          CGFloat underlineBlue = underlineComponents[2];

          if(!widgetsUnderlineCustomColorEnabled){
            switch(widgetsUnderlineStyle){
              case(1):
                if(underlineRed + .1 > 1)
                  underlineRed = 1;
                else
                  underlineRed = underlineRed + .1;

                if(underlineGreen + .1 > 1)
                  underlineGreen = 1;
                else
                  underlineGreen = underlineGreen + .1;

                if(underlineBlue + .1 > 1)
                  underlineBlue = 1;
                else
                  underlineBlue = underlineBlue + .1;
                break;
              case(2):
                if(underlineRed - .1 < 0)
                  underlineRed = 0;
                else
                  underlineRed = underlineRed - .1;

                if(underlineGreen - .1 < 0)
                  underlineGreen = 0;
                else
                  underlineGreen = underlineGreen - .1;

                if(underlineBlue - .1 < 0)
                  underlineBlue = 0;
                else
                  underlineBlue = underlineBlue - .1;
                break;
              default:
                break; //Use regular color
                  }
                }

          [underline setBackgroundColor: [UIColor colorWithRed:underlineRed green:underlineGreen blue:underlineBlue alpha:widgetsUnderlineColorAlpha]];
          [colorView addSubview:underline];
          [colorView bringSubviewToFront:underline];
        }

        [bg addSubview:colorView];
        [self setBackgroundView:bg];

    }
}

-(void)_configureHeaderOverlayViewIfNecessary{
    %orig;
}

-(void)setBackgroundView:(id)arg1{
    %orig(arg1);
}

-(void)layoutSubviews{
  %orig;
      refreshPrefs();
      if(enabled && widgetsEnabled){
          UIImage *iconImage = self.icon;
          UIColor *iconColor;

          //Determine constant color
          if(widgetsCustomColorEnabled)
            iconColor = widgetsCustomColor;
          else
            iconColor = dominantColorFromIcon(iconImage,widgetsColorAlpha);

          const CGFloat* iconComponents = CGColorGetComponents(iconColor.CGColor);
          CGFloat iconRed = iconComponents[0];
          CGFloat iconGreen = iconComponents[1];
          CGFloat iconBlue = iconComponents[2];

          if(widgetsCustomColorEnabled)
            iconColor = [UIColor colorWithRed: iconRed green:iconGreen blue:iconBlue alpha:widgetsColorAlpha];

          //Calculate luminence
          float luminence = (iconComponents[0]) * .299 + (iconComponents[1]) * .587 + (iconComponents[2]) * .114;

          if(luminence > .7) //should use white
              [self colorLabels:(UIView *)self.superview.superview color:[UIColor blackColor]];
          else //Should use black
              [self colorLabels:(UIView *)self.superview.superview color:[UIColor whiteColor]];
      }
}

%new
- (void)colorLabels:(UIView *)parentView color:(UIColor *)colorToUse{
    switch(widgetsLabelColor){
        case(1):
            colorToUse = [UIColor whiteColor];
            break;
        case(2):
            colorToUse = [UIColor blackColor];
            break;
        default:
            break; //Use adaptive color
            //self.frame = CGRectMake(176,35,23,40);
    }

    if([parentView respondsToSelector:@selector(setTextColor:)]){
      [(id)parentView setTextColor:colorToUse];
    }


    if([parentView isKindOfClass:[objc_getClass("MTMaterialView") class]]){
      MTMaterialView *bg = (MTMaterialView *)parentView;
      bg.layer.opacity = 0;
      return;
    }

    //If we are not a label, search all subviews for the label
    for (UIView *subview in parentView.subviews){
        [self colorLabels:subview color:colorToUse];
    }
}

%end


// ************************************************
// ****************** Banners *********************
// ************************************************

%hook NCNotificationShortLookView
-(void)setIcon:(id)arg1 {
    %orig;
    refreshPrefs();

    const CGFloat width = [UIScreen mainScreen].bounds.size.width;
    if(enabled && bannersEnabled){
        UIImage *iconImage = self.icon;
        UIColor *iconColor;

        CGFloat offsetFixed =  ((offset - self.icon.size.width) * 1.5 + self.icon.size.width) ;

        //Determine constant color
        if(bannersCustomColorEnabled)
          iconColor = bannersCustomColor;
        else
          iconColor = dominantColorFromIcon(iconImage,bannersColorAlpha);

        const CGFloat* iconComponents = CGColorGetComponents(iconColor.CGColor);
        CGFloat iconRed = iconComponents[0];
        CGFloat iconGreen = iconComponents[1];
        CGFloat iconBlue = iconComponents[2];

        if(bannersCustomColorEnabled)
          iconColor = [UIColor colorWithRed: iconRed green:iconGreen blue:iconBlue alpha:bannersColorAlpha];

        UIView *bg=[[UIView alloc]initWithFrame:CGRectMake(0,0,width,1500)];

        if((bannersBlurStyle == 1 || bannersBlurStyle == 2) || bannersBlurStyle == 0){
            UIVisualEffect *blurEffect;
            if(bannersBlurStyle == 2)
                blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            else
                blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];

            UIVisualEffectView *blurEffectView;
            blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            blurEffectView.frame = bg.bounds;
            [bg addSubview:blurEffectView];
        }


        //Calculate luminence
        float luminence = (iconComponents[0]) * .299 + (iconComponents[1]) * .587 + (iconComponents[2]) * .114;

        if(luminence > .7) //should use white
            [self colorLabels:(UIView *)self.superview.superview  color:[UIColor blackColor]];
        else //Should use black
            [self colorLabels:(UIView *)self.superview.superview  color:[UIColor whiteColor]];


        UIView *colorView =[[UIView alloc]initWithFrame:bg.frame];
        if(bannersGradientEnabled) {
          //If gradient enabled
          //TODO Rewrite for const color manipulation add/subracts
          // Update colors based on users selection

          switch(bannersGradientStyle){
            case(1):
              if(iconRed + .2 > 1)
                iconRed = 1;
              else
                iconRed = iconRed + .2;

              if(iconGreen + .2 > 1)
                iconGreen = 1;
              else
                iconGreen = iconGreen + .2;

              if(iconBlue + .2 > 1)
                iconBlue = 1;
              else
                iconBlue = iconBlue + .2;
              break;
            case(2):
              if(iconRed - .2 < 0)
                iconRed = 0;
              else
                iconRed = iconRed - .2;

              if(iconGreen - .2 < 0)
                iconGreen = 0;
              else
                iconGreen = iconGreen - .2;

              if(iconBlue - .2 < 0)
                iconBlue = 0;
              else
                iconBlue = iconBlue - .2;
              break;
            default:
              break; //Use regular color
          }

          //Create gradient
          CAGradientLayer *gradient = [CAGradientLayer layer];
          gradient.startPoint = CGPointMake(0, 0.5);
          gradient.endPoint = CGPointMake(1, 0.5);
          gradient.frame = colorView.bounds;

          if(bannersCustomGradientColorEnabled){
            const CGFloat* customGradientComponents = CGColorGetComponents(bannersCustomGradientColor.CGColor);
            CGFloat customGradientRed = customGradientComponents[0];
            CGFloat customGradientGreen = customGradientComponents[1];
            CGFloat customGradientBlue = customGradientComponents[2];
            gradient.colors = @[(id) iconColor.CGColor , (id)[UIColor colorWithRed:customGradientRed green:customGradientGreen blue:customGradientBlue alpha:bannersGradientColorAlpha].CGColor];
          }else
            gradient.colors = @[(id) iconColor.CGColor , (id)[UIColor colorWithRed:iconRed green:iconGreen blue:iconBlue alpha:bannersGradientColorAlpha].CGColor];

          [colorView.layer insertSublayer:gradient atIndex:0];
        }else
          [colorView setBackgroundColor: iconColor];

        bg.clipsToBounds= YES;

        //Fake Header Coloring View
        if(bannersUserWantsFakeHeader){

          UIView *fakeHeader=[[UIView alloc]initWithFrame:CGRectMake(0,0,width,offsetFixed)];
          UIColor * headerColor = iconColor;
          if(bannersCustomColorEnabled)
            headerColor = dominantColorFromIcon(iconImage,bannersFakeHeaderColorAlpha);
          if(bannersHeaderCustomColorEnabled)
            headerColor = bannersHeaderCustomColor;

          const CGFloat* headerComponents = CGColorGetComponents(headerColor.CGColor);
          CGFloat headerRed = headerComponents[0];
          CGFloat headerGreen = headerComponents[1];
          CGFloat headerBlue = headerComponents[2];

          if(!bannersHeaderCustomColorEnabled){
            switch(bannersFakeHeaderStyle){
              case(1):
                if(headerRed + .1 > 1)
                  headerRed = 1;
                else
                  headerRed = headerRed + .1;

                if(headerGreen + .1 > 1)
                  headerGreen = 1;
                else
                  headerGreen = headerGreen + .1;

                if(headerBlue + .1 > 1)
                  headerBlue = 1;
                else
                  headerBlue = headerBlue + .1;
                break;
              case(2):
                if(headerRed - .1 < 0)
                  headerRed = 0;
                else
                  headerRed = headerRed - .1;

                if(headerGreen - .1 < 0)
                  headerGreen = 0;
                else
                  headerGreen = headerGreen - .1;

                if(headerBlue - .1 < 0)
                  headerBlue = 0;
                else
                  headerBlue = headerBlue - .1;
                break;
              default:
                break; //Use regular color
            }
          }

        [fakeHeader setBackgroundColor: [UIColor colorWithRed:headerRed green:headerGreen blue:headerBlue alpha:bannersFakeHeaderColorAlpha]];
        [colorView addSubview:fakeHeader];
        [colorView bringSubviewToFront:fakeHeader];
      }

      //Underline View
      if(bannersUserWantsUnderline){

        UIView *underline=[[UIView alloc]initWithFrame:CGRectMake(0,offsetFixed,width,1)];
        UIColor * underlineColor = iconColor;
        if(bannersCustomColorEnabled)
          underlineColor = dominantColorFromIcon(iconImage,bannersUnderlineColorAlpha);
        if(bannersUnderlineCustomColorEnabled)
          underlineColor = bannersUnderlineCustomColor;

        const CGFloat* underlineComponents = CGColorGetComponents(underlineColor.CGColor);
        CGFloat underlineRed = underlineComponents[0];
        CGFloat underlineGreen = underlineComponents[1];
        CGFloat underlineBlue = underlineComponents[2];

        if(!bannersUnderlineCustomColorEnabled){
          switch(bannersUnderlineStyle){
            case(1):
              if(underlineRed + .1 > 1)
                underlineRed = 1;
              else
                underlineRed = underlineRed + .1;

              if(underlineGreen + .1 > 1)
                underlineGreen = 1;
              else
                underlineGreen = underlineGreen + .1;

              if(underlineBlue + .1 > 1)
                underlineBlue = 1;
              else
                underlineBlue = underlineBlue + .1;
              break;
            case(2):
              if(underlineRed - .1 < 0)
                underlineRed = 0;
              else
                underlineRed = underlineRed - .1;

              if(underlineGreen - .1 < 0)
                underlineGreen = 0;
              else
                underlineGreen = underlineGreen - .1;

              if(underlineBlue - .1 < 0)
                underlineBlue = 0;
              else
                underlineBlue = underlineBlue - .1;
              break;
            default:
              break; //Use regular color
          }
        }

        [underline setBackgroundColor: [UIColor colorWithRed:underlineRed green:underlineGreen blue:underlineBlue alpha:bannersUnderlineColorAlpha]];
        [colorView addSubview:underline];
        [colorView bringSubviewToFront:underline];

      }

      [bg addSubview:colorView];
      [self setBackgroundView:bg];

    }
}

-(void)layoutSubviews{
  %orig;
      if(enabled && bannersEnabled){
          UIImage *iconImage = self.icon;
          UIColor *iconColor;

          //Determine constant color
          if(bannersCustomColorEnabled)
            iconColor = bannersCustomColor;
          else
            iconColor = dominantColorFromIcon(iconImage,bannersColorAlpha);

          const CGFloat* iconComponents = CGColorGetComponents(iconColor.CGColor);
          CGFloat iconRed = iconComponents[0];
          CGFloat iconGreen = iconComponents[1];
          CGFloat iconBlue = iconComponents[2];

          if(bannersCustomColorEnabled)
            iconColor = [UIColor colorWithRed: iconRed green:iconGreen blue:iconBlue alpha:bannersColorAlpha];

          //Calculate luminence
          float luminence = (iconComponents[0]) * .299 + (iconComponents[1]) * .587 + (iconComponents[2]) * .114;

          if(luminence > .7) //should use white
              [self colorLabels:(UIView *)self.superview.superview color:[UIColor blackColor]];
          else //Should use black
              [self colorLabels:(UIView *)self.superview.superview color:[UIColor whiteColor]];
      }
}

-(void)setBackgroundView:(id)arg1{
    %orig(arg1);
}

%new
- (void)colorLabels:(UIView *)parentView color:(UIColor *)colorToUse{
    switch(bannersLabelColor){
        case(1):
            colorToUse = [UIColor whiteColor];
            break;
        case(2):
            colorToUse = [UIColor blackColor];
            break;
        default:
            break; //Use adaptive color
            //self.frame = CGRectMake(176,35,23,40);
    }
    //Update UITextView Label to Color
    if([parentView respondsToSelector:@selector(setTextColor:)]){
      [(id)parentView setTextColor:colorToUse];
    }


    if([parentView isKindOfClass:[objc_getClass("MTMaterialView") class]]){
      MTMaterialView *bg = (MTMaterialView *)parentView;
      bg.layer.opacity = 0;
    }

    //If we are not a label, search all subviews for the label
    for (UIView *subview in parentView.subviews){
        [self colorLabels:subview color:colorToUse];
    }
}

%end

%hook MTPlatterHeaderContentView

-(void)layoutSubviews{
  %orig;

  //Check to not fuck up when other views have a contentBaseline
  //TODO Fix for less hacky check
  if(self.contentBaseline < 40 )
     offset = (self.contentBaseline);

}
%end

%ctor {
  @autoreleasepool {
    settings = [[NSMutableDictionary alloc] initWithContentsOfFile:[palettePrefs stringByExpandingTildeInPath]];
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) PreferencesChangedCallback, CFSTR("ch.mdaus.palette.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    refreshPrefs();
  }
}
