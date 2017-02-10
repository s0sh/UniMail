//
//  RBUEmailHelper.m
//  ErmineMail
//
//  Created by Roman Bigun on 09.09.14.
//  Copyright (c) 2014 Roman Bigun. All rights reserved.
//

#import "RBUEmailHelper.h"
#import "constants.h"

#define MESSAGES_TO_FETCH 20
#define NUMBER_OF_MESSAGES_TO_LOAD		20
#define CLIENT_ID @"the-client-id"
#define CLIENT_SECRET @"the-client-secret"
#define KEYCHAIN_ITEM_NAME @"MailCore OAuth 2.0 Token"
NSString * const FetchFullMessageKey = @"FetchFullMessageEnabled";
NSString * const OAuthEnabledKey = @"OAuth2Enabled";



@implementation RBUEmailHelper

-(id)init
{

    if(self!=nil)
    {
    
        
    
    }
    
    return self;

}
+ (RBUEmailHelper *)sharedInstance
{
    
    static RBUEmailHelper * _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[RBUEmailHelper alloc] init];
        
    });
    
    return _sharedInstance;
}
-(NSArray*)messagesObjects
{

    return self.messages;

}

-(void)fetchGMailData
{

    MCOIMAPFetchFoldersOperation * op = [self.imapSession fetchSubscribedFoldersOperation];
    
    [op start:^(NSError * error, NSArray * folders) {
        
        
        NSLog(@"%@",folders);
        
        
        NSString*check = @"INBOX";
        
        [self loadMessages:NUMBER_OF_MESSAGES_TO_LOAD];
        
       // if ([curentServr isEqualToString:@"imap.gmail.com"]) {
            
        
            for (MCOIMAPFolder * folder in folders)
            {
                
                
                if (folder.flags ==32 && [check isEqualToString:@"Sent Mail"])
                {
                    
                    self.currentFolder = folder.path;
                    [self loadMessages:NUMBER_OF_MESSAGES_TO_LOAD];
                    
                    
            
                }
                
                
                if (folder.flags ==0 && [check isEqualToString:@"INBOX"] && [folder.path isEqualToString:@"INBOX"])
                {
                    
                    self.currentFolder = folder.path;
                    [self loadMessages:NUMBER_OF_MESSAGES_TO_LOAD];
                    
                   
                    
                }
                
                if (folder.flags ==1024 && [check isEqualToString:@"Spam"])
                {
                    
                    self.currentFolder = folder.path;
                    [self loadMessages:NUMBER_OF_MESSAGES_TO_LOAD];
                
                    
                }
                
                
            }
    }];

    

}
-(void)loginToHostAndFetchEmails
{
    
    NSString *hostname = @"";
    NSString *username = [[NSUserDefaults standardUserDefaults] valueForKey:
                          [NSString stringWithFormat:@"%@Address",[app currentAgent]]];
	NSString *password = [[NSUserDefaults standardUserDefaults] valueForKey:
                          [NSString stringWithFormat:@"%@Password",[app currentAgent]]];
    
    for(int i=0;i<MAIL_AGENTS_LIST.count;i++)
    {
        
        if([[MAIL_AGENTS_LIST objectAtIndex:i] isEqualToString:[app currentAgent]])
        {
        
            hostname = [AGENTS_DOMENS_IMAP objectAtIndex:i];
        
        }
	}
   
    [self loadAccountWithUsername:username password:password hostname:hostname oauth2Token:nil];
  
}
- (void)loadAccountWithUsername:(NSString *)username
                       password:(NSString *)password
                       hostname:(NSString *)hostname
                    oauth2Token:(NSString *)oauth2Token
{
    self.imapSession = [[MCOIMAPSession alloc] init];
	self.imapSession.hostname = hostname;
	self.imapSession.port = 993;
	self.imapSession.username = username;
	self.imapSession.password = password;
    if (oauth2Token != nil) {
        self.imapSession.OAuth2Token = oauth2Token;
        self.imapSession.authType = MCOAuthTypeXOAuth2;
    }
	self.imapSession.connectionType = MCOConnectionTypeTLS;
   
	self.imapSession.connectionLogger = ^(void * connectionID, MCOConnectionLogType type, NSData * data) {

        
    };
	
	// Reset the inbox
	self.messages = nil;
	self.totalNumberOfInboxMessages = -1;
	self.isLoading = NO;
	self.messagePreviews = [NSMutableDictionary dictionary];
	//[self.tableView reloadData];
    
	NSLog(@"checking account");
	self.imapCheckOp = [self.imapSession checkAccountOperation];
	[self.imapCheckOp start:^(NSError *error) {
		
		NSLog(@"finished checking account.");
		if (error == nil) {
            
            
            
            
			[self loadMessages:NUMBER_OF_MESSAGES_TO_LOAD];
		} else {
			NSLog(@"error loading account: %@", error);
            //             [mc hideMBProgressHUD];
            
           
		}
		
		self.imapCheckOp = nil;
	}];
    
    [app setSession:self.imapSession];
}

- (void)loadMessages:(NSUInteger)nMessages{
    
        self.isLoading = YES;
       // [app setCurFolder:@"Spam"];
        MCOIMAPMessagesRequestKind requestKind = (MCOIMAPMessagesRequestKind)
        (MCOIMAPMessagesRequestKindHeaders | MCOIMAPMessagesRequestKindStructure |
         MCOIMAPMessagesRequestKindInternalDate | MCOIMAPMessagesRequestKindHeaderSubject |
         MCOIMAPMessagesRequestKindFlags);
        
        NSString *inboxFolder = [app curFolder];//ROMA
        MCOIMAPFolderInfoOperation *inboxFolderInfo = [self.imapSession folderInfoOperation:inboxFolder];
        
        [inboxFolderInfo start:^(NSError *error, MCOIMAPFolderInfo *info)
         {
             BOOL totalNumberOfMessagesDidChange =
             self.totalNumberOfInboxMessages != [info messageCount];
             
             self.totalNumberOfInboxMessages = [info messageCount];
             
             NSUInteger numberOfMessagesToLoad =
             MIN(self.totalNumberOfInboxMessages, nMessages);
             
             if (numberOfMessagesToLoad == 0)
             {
                 self.isLoading = NO;
                 return;
             }
             
             MCORange fetchRange;
             
             // If total number of messages did not change since last fetch,
             // assume nothing was deleted since our last fetch and just
             // fetch what we don't have
             if (!totalNumberOfMessagesDidChange && self.messages.count)
             {
                 numberOfMessagesToLoad -= self.messages.count;
                 
                 fetchRange =
                 MCORangeMake(self.totalNumberOfInboxMessages -
                              self.messages.count -
                              (numberOfMessagesToLoad - 1),
                              (numberOfMessagesToLoad - 1));
             }
             
             // Else just fetch the last N messages
             else
             {
                 fetchRange =
                 MCORangeMake(self.totalNumberOfInboxMessages -
                              (numberOfMessagesToLoad - 1),
                              (numberOfMessagesToLoad - 1));
             }
             
             self.imapMessagesFetchOp =
             [self.imapSession fetchMessagesByNumberOperationWithFolder:inboxFolder
                                                            requestKind:requestKind
                                                                numbers:
              [MCOIndexSet indexSetWithRange:fetchRange]];
             
             [self.imapMessagesFetchOp setProgress:^(unsigned int progress) {
                 NSLog(@"Progress: %u of %u", progress, numberOfMessagesToLoad);
             }];
             
            
             [self.imapMessagesFetchOp start:
              ^(NSError *error, NSArray *messages, MCOIndexSet *vanishedMessages)
              {
                 
                  NSLog(@"fetched all messages.");
                  
                  self.isLoading = NO;
                  
                  NSSortDescriptor *sort =
                  [NSSortDescriptor sortDescriptorWithKey:@"header.date" ascending:NO];
                  
                  NSMutableArray *combinedMessages =
                  [NSMutableArray arrayWithArray:messages];
                  [combinedMessages addObjectsFromArray:self.messages];
                  
                  self.messages =
                  [combinedMessages sortedArrayUsingDescriptors:@[sort]];
                  
                  [[NSNotificationCenter defaultCenter] postNotificationName:@"messagesLoaded" object:nil];
                  
                  
              }];
         }];
    
    
}
     
     
@end
