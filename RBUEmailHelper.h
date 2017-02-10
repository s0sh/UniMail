//
//  RBUEmailHelper.h
//  ErmineMail
//
//  Created by Roman Bigun on 09.09.14.
//  Copyright (c) 2014 Roman Bigun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErmineMail/mailcore2-master/src/MailCore.h"
@interface RBUEmailHelper : NSObject
{


}
@property (nonatomic, strong) MCOIMAPOperation *imapCheckOp;
@property (nonatomic, strong) MCOIMAPSession *imapSession;
@property (nonatomic, strong) MCOIMAPFetchMessagesOperation *imapMessagesFetchOp;
@property (nonatomic) BOOL isLoading;
@property (nonatomic) BOOL isLoadingForUp;
@property (nonatomic) NSInteger totalNumberOfInboxMessages;
@property (nonatomic, strong) NSArray *messages;
@property (nonatomic, strong) NSMutableDictionary *messagePreviews;
@property (nonatomic, strong) MCOIMAPMessageRenderingOperation * messageRenderingOperation;
@property (nonatomic, retain) NSString *currentFolder;

+(RBUEmailHelper*)sharedInstance;
-(void)fetchGMailData;
-(NSArray*)messagesObjects;
-(void)loginToHostAndFetchEmails;
@end
