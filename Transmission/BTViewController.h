#import <UIKit/UIKit.h>

@interface BTViewController : UIViewController
@property(nonatomic, strong) IBOutlet UIWebView *web;
-(void)addTorrentAtLocation:(NSString*)url;
+(BTViewController*)singleton;
-(void)reload;
@end
