//
//  DatabaseController.h
//  RechargeReward
//
//  Created by Tommy on 12/27/15.
//  Copyright © 2015 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Reachability.h"
#import "SHAlertHelper.h"

typedef void (^SuccessBlock)(id json);
typedef void (^FailureBlock)(id json);

@interface DatabaseController : AFHTTPRequestOperationManager 
{

}

+ (DatabaseController *)sharedManager;
+ (DatabaseController *)sharedManager2;

//
//-(void)userSocialSignup:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//
//-(void)userManualSignup:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//
//-(void)userCheckNameExist:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//
//-(void)userManualSignin:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//
//-(void)userLogout:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//
//-(void)userForgotPswd:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//
//-(void)userVerifyCode:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//
//-(void)userSetNewPswd:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//
//-(void)userChangePswd:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//
//-(void)updateMyLocation:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//
//-(void)getFeed:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//
//-(void)getRestaurantDetail:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//
//-(void)favoriteRestaurant:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//
//-(void)ignoreRestaurant:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//
//-(void)rate:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//
//-(void)userProfileUpdate:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//
//-(void)userProfilePhotoUpdate:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//
//-(void)userSettingsUpdate:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//
//-(void)contact:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//
//-(void)feedback:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//-(void)addResPhoto:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
//-----------------------new func---------------------
-(void)getDetails:(NSString*)url  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)patchData:(NSDictionary *)params url:(NSString *)url onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)postData:(NSDictionary *)params url:(NSString *)url onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)postDataWithImage:(NSDictionary *)params url:(NSString *)url imageData:(NSData *)image onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)postDataPass:(NSDictionary *)params url:(NSString *)url onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
- (void) httpJsonRequest:(NSString *) urlStr withJSON:(NSMutableDictionary *)params;

-(void)test:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;

/* POST */
-(void)POST:(NSString *)url
 parameters:(NSMutableDictionary*)parameters
      onSuccess:(SuccessBlock)completionBlock
  onFailure:(FailureBlock)failureBlock;
/* POSTPASS */
-(void)POSTPASS:(NSString *)url
 parameters:(NSMutableDictionary*)parameters
  onSuccess:(SuccessBlock)completionBlock
  onFailure:(FailureBlock)failureBlock;

/* POST WITH IMAGE */
-(void)POSTWithImage:(NSString *)url
  parameters:(NSMutableDictionary*)parameters
      vImage:(NSData*)vImage
   onSuccess:(SuccessBlock)completionBlock
   onFailure:(FailureBlock)failureBlock;

/* GET */
- (void)GET:(NSString *)url
parameters:(NSMutableDictionary*)parameters
onSuccess:(SuccessBlock)completionBlock
  onFailure:(FailureBlock)failureBlock;
/* PATCH */
- (void)PATCH:(NSString *)url
 parameters:(NSMutableDictionary*)parameters
  onSuccess:(SuccessBlock)completionBlock
  onFailure:(FailureBlock)failureBlock;



@end
