//
//  MPMiniPlayerPlugin.h
//  MiniPlayer for Mac
//
//  Created by Alex Manzella on 09/04/14.
//  Copyright (c) 2014 Alex Manzella. All rights reserved.
//

#import <Foundation/Foundation.h>

// Version 1.0

typedef enum : NSUInteger {
    MPPlayerStatePaused,
    MPPlayerStatePlaying,
    MPPlayerStateStopped,
} MPPlayerState;

@protocol MPMediaItem <NSObject> // needed just for the search, if you don't implement search you don't need it

@required

- (NSString *)title;
- (NSString *)artist;
- (NSString *)album;
- (id)artwork; // NSString or NSImage
- (NSString *)itemID; // itemID can be something helpfull needed when didSelectItem is called... for example Spotify itemID is needed to play it... if you don't need forgot about it.

@end


@protocol MPMiniPlayerDelegate <NSObject>

- (void)playerManager:(id)playerManager statusDidChangeWithPlayerState:(MPPlayerState)playbackState; // call it to update the player

- (void)playerManager:(id)playerManager didFoundItems:(NSArray *)items forQuery:(NSString *)query; // call for return searched result, NSArray must be an array of id<MPMediaItem>


@end

@protocol MPMiniPlayerPlugin <NSObject>

@required

- (void)setDelegate:(id<MPMiniPlayerDelegate>)delegate;
- (MPPlayerState) playbackState;
- (NSString *)title;
- (NSString *)artist;
- (NSString *)album;
- (NSImage *)artwork;

+ (NSString *)serviceName; // Plugin Service name ex: Spotify
+ (BOOL)isAvailable; // for example return NO if the App is not installed

- (void)togglePlayPause;
- (void)next;
- (void)previous;
- (void)update; // Called by MiniPlayer when PlayBack Notification are not involved , for example when we start MiniPlayer, use it to update title, subtitle,artwork,album.... , make sure everyTime that we get info's they are up to date.... once finished, it call the delegate





@optional

- (NSString *)distribuitedNotificationName; // if your service don't have notification for playbackstate... implement your own way to get playback changes and track changes...
- (void)handleNotification:(NSNotification *)notification;


- (BOOL)searchEnabled; // return YES if you want the search
- (void)didSelectItem:(id<MPMediaItem>)item; // for example play the item
- (void)searchSongsForQuery:(NSString *)query; // call the delegate - (void)playerManager:(MPMiniPlayerMagager *)playerManager didFoundItems:(NSArray *)items forQuery:(NSString *)query; once finished // NSArray must be an array of MPItems

@end
