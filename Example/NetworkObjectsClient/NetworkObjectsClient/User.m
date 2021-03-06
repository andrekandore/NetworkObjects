//
//  User.m
//  NetworkObjectsClient
//
//  Created by Alsey Coleman Miller on 11/11/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "User.h"
#import "Client.h"
#import "Post.h"
#import "Session.h"

#import "User+NOUserKeysProtocol.h"

@implementation User

@dynamic created;
@dynamic password;
@dynamic resourceID;
@dynamic username;
@dynamic authorizedClients;
@dynamic createdClients;
@dynamic likedPosts;
@dynamic posts;
@dynamic sessions;

@end
