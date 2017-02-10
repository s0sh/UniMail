//
//  rbuSettingsView.h
//  ErmineMail
//
//  Created by Roman Bigun on 08.09.14.
//  Copyright (c) 2014 Roman Bigun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rbuSettingsView : UIViewController<UIScrollViewDelegate,UITextFieldDelegate>
{

    

}

@property(nonatomic,retain)NSString *email;
@property(nonatomic,retain)NSString *password;
@property(nonatomic, retain)IBOutlet UITextField *passwordField;
@property(nonatomic, retain)IBOutlet UITextField *emailField;
@property(nonatomic,retain)IBOutlet NSString *provider;
@property(nonatomic,retain)IBOutlet UIScrollView *providers;
-(IBAction)save:(id)sender;
@end
