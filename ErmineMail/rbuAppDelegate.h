//
//  rbuAppDelegate.h
//  ErmineMail
//
//  Created by Roman Bigun on 08.09.14.
//  Copyright (c) 2014 Roman Bigun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mailcore2-master/src/MailCore.h"

@interface rbuAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) MCOIMAPSession *imapSessionLocal;

-(void)setSession: (MCOIMAPSession *)sessionLoca;
- (MCOIMAPSession *)getSession;
-(void)setCurrentAgent:(NSString*)agent;
-(NSString*)currentAgent;

-(void)setCurrentFolder:(NSString*)folder;
-(NSString*)currentFolder;
@property (strong, nonatomic)NSString *curFolder;
@property (strong, nonatomic)NSString *agent;
@end
