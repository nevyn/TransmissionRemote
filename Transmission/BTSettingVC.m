#import "BTSettingVC.h"
#import "BTSettingsVC.h"

@implementation BTSettingVC
@synthesize field, settingsKey;
-(void)viewWillAppear:(BOOL)animated;
{
	self.title = self.settingsKey;
	self.field.text = [[NSUserDefaults standardUserDefaults] objectForKey:self.settingsKey];
	[self.field becomeFirstResponder];
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)or;
{
	return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ?: or == UIInterfaceOrientationPortrait;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
	[[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:self.settingsKey];
	return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
	[[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:self.settingsKey];
	[self.navigationController popViewControllerAnimated:YES];
	return YES;
}
@end
