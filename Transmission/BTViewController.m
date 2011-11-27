#import "BTViewController.h"

static __weak BTViewController *g_singleton;

@implementation BTViewController {
	NSString *_pendingURL;
	NSTimer *_timer;
}
@synthesize web = _web;
-(id)initWithCoder:(NSCoder *)aDecoder;
{
	if(!(self = [super initWithCoder:aDecoder])) return nil;
	g_singleton = self;
	return self;
}
+(BTViewController*)singleton;
{
	return g_singleton;
}

-(NSURL*)remoteUrl;
{
	NSString *host = [[NSUserDefaults standardUserDefaults] objectForKey:@"Hostname"];
	if(!host) return nil;
	NSString *port = [[NSUserDefaults standardUserDefaults] objectForKey:@"Port"];
	if(!port) return nil;
	return [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@", host, port]];
}
-(void)viewWillAppear:(BOOL)animated;
{
	if(self.remoteUrl) {
		NSURLRequest *req = [NSURLRequest requestWithURL:self.remoteUrl];
		[_web loadRequest:req];
	}
}
-(void)viewDidAppear:(BOOL)animated;
{
	[super viewDidAppear:animated];
	if(![[NSUserDefaults standardUserDefaults] objectForKey:@"Hostname"])
		[self performSegueWithIdentifier:@"showSettings" sender:nil];
}
-(void)addPendingTorrent;
{
	NSString *token =  [_web stringByEvaluatingJavaScriptFromString:@"transmission.remote._token"];
	if(!token) return; // site is not done loading
	
	NSString *cmd = [NSString stringWithFormat:@"transmission.remote.addTorrentByUrl('%@', {paused:false})", _pendingURL];
	
	[_web stringByEvaluatingJavaScriptFromString:cmd];
	[_timer invalidate]; _timer = nil; _pendingURL = nil;
}
-(void)addTorrentAtLocation:(NSString*)url;
{
	_pendingURL = url;
	[_timer invalidate];
	_timer = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(addPendingTorrent) userInfo:nil repeats:YES];
	[self addPendingTorrent];
}
@end
