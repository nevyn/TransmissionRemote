#import "BTAppDelegate.h"
#import "BTViewController.h"

@implementation BTAppDelegate
@synthesize window = _window;
+(void)initialize;
{
	[[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObject:@"9091" forKey:@"Port"]];
}
-(BOOL)application:(UIApplication*)app handleOpenURL:(NSURL *)url;
{
	[[BTViewController singleton] addTorrentAtLocation:url.absoluteString];
	return YES;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
{
	if([launchOptions objectForKey:UIApplicationLaunchOptionsURLKey])
		[self application:application handleOpenURL:[launchOptions objectForKey:UIApplicationLaunchOptionsURLKey]];
	return YES;
}
@end
