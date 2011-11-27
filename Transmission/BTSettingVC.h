#import <UIKit/UIKit.h>

@interface BTSettingVC : UIViewController <UITextFieldDelegate>
@property(nonatomic,strong) IBOutlet UITextField *field;
@property(nonatomic,strong) NSString *settingsKey;
@end
