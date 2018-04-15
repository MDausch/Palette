#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#include <spawn.h>

#define palettePrefs @"/var/mobile/Library/Preferences/ch.mdaus.palette.plist"

@interface mdpaletteRootListController : PSListController

@end


@protocol PreferencesTableCustomView
- (id)initWithSpecifier:(PSSpecifier *)specifier;
- (CGFloat)preferredHeightForWidth:(CGFloat)width;
@end

@interface mdpaletteHeaderCell : PSTableCell <PreferencesTableCustomView> {
    UIImageView *headerImageView;
}
@end

