//
//  constants.h
//  ErmineMail
//
//  Created by Roman Bigun on 09.09.14.
//  Copyright (c) 2014 Roman Bigun. All rights reserved.
//
#include "rbuAppDelegate.h"
#ifndef ErmineMail_constants_h
#define ErmineMail_constants_h

#define app (rbuAppDelegate *)[[UIApplication sharedApplication] delegate]
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define userIdiomPhone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define is_iOS_7    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define MAIL_AGENTS_LIST [NSArray arrayWithObjects:@"gmail",@"aol",@"outlook",@"mailru",@"ukrnet",@"yahoo",@"hotmail",@"yandex",nil]
#define MAIL_AGENTS_PICS [NSArray arrayWithObjects:@"gmail.png",@"aol.png",@"outlook.png",@"mailru.png",@"ukrnet.png",@"yahoo.png",@"hotmail.png",@"yandex.png",nil]

#define AGENTS_DOMENS_IMAP [NSArray arrayWithObjects:@"imap.gmail.com",@"imap.aol.com",@"imap-mail.outlook.com",@"imap.mail.ru",@"imap.ukr.net",@"imap.mail.yahoo.com",@"imap-mail.outlook.com",@"imap.yandex.ru",nil]

#define AGENTS_DOMENS_SMTP [NSArray arrayWithObjects:@"smtp.gmail.com",@"smtp.aol.com",@"smtp-mail.outlook.com",@"imap.mail.ru",@"smtp.ukr.net",@"smtp.mail.yahoo.com",@"smtp-mail.outlook.com",@"smtp.yandex.ru",nil]

#endif

/*
"port":465,
"hostname":"smtp.mail.yahoo.com",

"port":587,
"hostname":"smtp.gmail.com",
"starttls":true
},
{
    "port":465,
    "hostname":"smtp.gmail.com",
    "ssl":true
},
{
    "port":25,
    "hostname":"smtp.gmail.com",
    "starttls":true
}

"port":25,
"hostname":"smtp-mail.outlook.com",


"port": 465,
"hostname": "smtp.mail.ru",


{
    "port":587,
    "hostname":"smtp.aol.com",
    "starttls":true
},
{
    "port":465,
    "hostname":"smtp.aol.com",
    "ssl":true
},
{
    "port":25,
    "hostname":"smtp.aol.com",
    "starttls":true
}

адрес почтового сервера — smtp.yandex.ru;
защита соединения — SSL;
порт — 465.

smtp.ur.net/465
*/
