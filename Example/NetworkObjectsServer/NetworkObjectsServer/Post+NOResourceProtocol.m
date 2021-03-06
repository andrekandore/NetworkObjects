//
//  Post+NOResourceProtocol.m
//  NetworkObjects
//
//  Created by Alsey Coleman Miller on 10/6/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "Post+NOResourceProtocol.h"
#import "Post+NOResourceKeysProtocol.h"
#import "Client.h"
#import "Session.h"

// LLVM thinks we didnt implement the protocol becuase its in a category

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprotocol"

@implementation Post (NOResourceProtocol)

#pragma clang diagnostic pop

+(BOOL)requireSession
{
    return NO;
}

+(NSSet *)requiredInitialProperties
{
    return nil;
}

#pragma mark - Validate New Values

-(BOOL)isValidValue:(NSObject *)newValue
       forAttribute:(NSString *)attributeName
{
    
    return YES;
}

-(BOOL)isValidValue:(NSObject *)newValue
    forRelationship:(NSString *)relationshipName
{
    
    return YES;
}


#pragma mark - Permissions

+(BOOL)canCreateNewInstanceFromSession:(NSManagedObject<NOSessionProtocol> *)sessionProtocolObject
{
    Session *session = (Session *)sessionProtocolObject;
    
    // only first party apps can create posts
    if (session.user && session.client.isNotThirdParty.boolValue) {
        
        return YES;
    }
    
    return NO;
}

-(BOOL)canDeleteFromSession:(NSManagedObject<NOSessionProtocol> *)sessionProtocolObject
{
    Session *session = (Session *)sessionProtocolObject;
    
    // only creator can delete post
    if (session.user == self.creator && session.client.isNotThirdParty.boolValue) {
        
        return YES;
    }
    
    return NO;
}

-(NOResourcePermission)permissionForSession:(NSManagedObject<NOSessionProtocol> *)sessionProtocolObject
{
    Session *session = (Session *)sessionProtocolObject;
    
    // creator has edit permission
    if (session.user == self.creator) {
        
        return EditPermission;
    }
    
    return ReadOnlyPermission;
}

-(NOResourcePermission)permissionForAttribute:(NSString *)attributeName
                                      session:(NSManagedObject<NOSessionProtocol> *)sessionProtocolObject
{
    if ([attributeName isEqualToString:@"views"]) {
        
        return ReadOnlyPermission;
    }
    
    return EditPermission;
}

-(NOResourcePermission)permissionForRelationship:(NSString *)relationshipName
                                         session:(NSManagedObject<NOSessionProtocol> *)session
{
    // dont wanna directly replace relationship, use function instead
    return ReadOnlyPermission;
}

#pragma mark - Notifications

-(void)wasCreatedBySession:(NSManagedObject<NOSessionProtocol> *)sessionProtocolObject
{
    Session *session = (Session *)sessionProtocolObject;
    
    // set the creator to the user who created the post
    self.creator = session.user;
    
}

-(void)wasAccessedBySession:(NSManagedObject<NOSessionProtocol> *)sessionProtocolObject
{
    self.views = [NSNumber numberWithInteger:self.views.integerValue + 1];
}

-(void)wasEditedBySession:(NSManagedObject<NOSessionProtocol> *)sessionProtocolObject
{
    
}

-(void)attribute:(NSString *)attributeName
wasAccessedBySession:(NSManagedObject<NOSessionProtocol> *)session
{
    
}

-(void)attribute:(NSString *)attributeName
wasEditedBySession:(NSManagedObject<NOSessionProtocol> *)session
{
    
}

-(void)relationship:(NSString *)relationshipName
wasAccessedBySession:(NSManagedObject<NOSessionProtocol> *)session
{
    
    
}

-(void)relationship:(NSString *)relationshipName
 wasEditedBySession:(NSManagedObject<NOSessionProtocol> *)session
{
    
    
}

#pragma mark - Functions

+(NSSet *)resourceFunctions
{
    return [NSSet setWithArray:@[@"like"]];
}

-(BOOL)canPerformFunction:(NSString *)functionName
                  session:(NSManagedObject<NOSessionProtocol> *)session
{
    return YES;
}

-(NOResourceFunctionCode)performFunction:(NSString *)functionName
                             withSession:(NSManagedObject<NOSessionProtocol> *)session
          recievedJsonObject:(NSDictionary *)recievedJsonObject
                    response:(NSDictionary *__autoreleasing *)jsonObjectResponse
{
    if ([functionName isEqualToString:@"like"]) {
        
        NSLog(@"performed 'like' function on %@", self);
        
    }
    
    return FunctionPerformedSuccesfully;
}

@end
