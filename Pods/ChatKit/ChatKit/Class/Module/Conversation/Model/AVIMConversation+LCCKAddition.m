//
//  AVIMConversation+LCCKAddition.m
//  LeanCloudChatKit-iOS
//
//  Created by 陈宜龙 on 16/3/11.
//  Copyright © 2016年 ElonChan. All rights reserved.
//

#import "AVIMConversation+LCCKAddition.h"
#import <objc/runtime.h>
#import "LCCKUserSystemService.h"
#import "LCCKSessionService.h"
#import "LCCKUserDelegate.h"

@implementation AVIMConversation (LCCKAddition)

- (AVIMTypedMessage *)lcck_lastMessage {
    return objc_getAssociatedObject(self, @selector(lcck_lastMessage));
}

- (void)setLcck_lastMessage:(AVIMTypedMessage *)lcck_lastMessage {
    objc_setAssociatedObject(self, @selector(lcck_lastMessage), lcck_lastMessage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)lcck_unreadCount {
    NSNumber *lcck_unreadCountObject = objc_getAssociatedObject(self, @selector(lcck_unreadCount));
    return [lcck_unreadCountObject intValue];
}

- (NSString *)lcck_badgeText {
    NSString *badgeText;
    NSUInteger unreadCount = self.lcck_unreadCount;
    if (unreadCount > 99) {
        badgeText = @"···";
    } else {
        badgeText = [NSString stringWithFormat:@"%@", @(unreadCount)];;
    }
    return badgeText;
}

- (void)setLcck_unreadCount:(NSInteger)lcck_unreadCount {
    NSNumber *lcck_unreadCountObject = [NSNumber numberWithInteger:lcck_unreadCount];
    objc_setAssociatedObject(self, @selector(lcck_unreadCount), lcck_unreadCountObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)lcck_mentioned {
    NSNumber *lcck_mentionedObject = objc_getAssociatedObject(self, @selector(lcck_mentioned));
    return [lcck_mentionedObject boolValue];
}

- (void)setLcck_mentioned:(BOOL)lcck_mentioned {
    NSNumber *lcck_mentionedObject = [NSNumber numberWithBool:lcck_mentioned];
    objc_setAssociatedObject(self, @selector(lcck_mentioned), lcck_mentionedObject, OBJC_ASSOCIATION_ASSIGN);
}

- (NSString *)lcck_draft {
    return objc_getAssociatedObject(self, @selector(lcck_draft));
}

- (void)setLcck_draft:(NSString *)lcck_draft {
    objc_setAssociatedObject(self, @selector(lcck_draft), lcck_draft, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LCCKConversationType)lcck_type {
    if (self.members.count > 2) {
        return LCCKConversationTypeGroup;
    }
    return LCCKConversationTypeSingle;
}

- (NSString *)lcck_displayName {
    if ([self lcck_type] == LCCKConversationTypeSingle) {
        NSString *peerId = [self lcck_peerId];
        NSError *error = nil;
       NSArray *peers = [[LCCKUserSystemService sharedInstance] getCachedProfilesIfExists:@[peerId] error:&error];
        id<LCCKUserDelegate> peer;
        if (peers.count > 0) {
            peer = peers[0];
        }
        return peer.name ?: peerId;
    } else {
        return self.name;
    }
}

- (NSString *)lcck_peerId {
    NSArray *members = self.members;
    if (members.count == 0) {
        [NSException raise:@"invalid conversation" format:@"invalid conversation"];
    }
    if (members.count == 1) {
        return members[0];
    }
    NSString *peerId;
    if ([members[0] isEqualToString:[LCCKSessionService sharedInstance].clientId]) {
        peerId = members[1];
    } else {
        peerId = members[0];
    }
    return peerId;
}

- (NSString *)lcck_title {
    if (self.lcck_type == LCCKConversationTypeSingle) {
        return self.lcck_displayName;
    } else {
        return [NSString stringWithFormat:@"%@(%ld)", self.lcck_displayName, (long)self.members.count];
    }
}

@end

