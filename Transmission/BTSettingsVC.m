#import "BTSettingsVC.h"
#import "BTSettingVC.h"
#import "BTViewController.h"

@implementation BTSettingsVC {
	UIAlertView *hostnameAlert;
}
-(void)viewWillAppear:(BOOL)animated;
{
	[super viewWillAppear:animated];
	for(UITableViewCell *cell in self.tableView.visibleCells)
		cell.detailTextLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:cell.textLabel.text];
}
-(void)viewDidAppear:(BOOL)animated;
{
	[super viewDidAppear:animated];
	[self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:animated];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender;
{
	[(BTSettingVC*)segue.destinationViewController setSettingsKey:sender.textLabel.text];
}
-(IBAction)done:(id)sender;
{
	if([[[NSUserDefaults standardUserDefaults] objectForKey:@"Hostname"]?:@"" isEqual:@""]) {
		hostnameAlert = [[UIAlertView alloc] initWithTitle:@"Hostname required" message:@"You must select a host to control to use this app." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[hostnameAlert show];
		return;
	}
	[self.presentingViewController dismissModalViewControllerAnimated:YES];
	[[BTViewController singleton] reload];
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;
{
	hostnameAlert = nil;
}
@end
