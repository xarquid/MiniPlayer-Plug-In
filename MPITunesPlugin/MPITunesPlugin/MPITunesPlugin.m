//
//  MPSpotifyManager.m
//  MiniPlayer for Mac
//
//  Created by Alex Manzella on 09/04/14.
//  Copyright (c) 2014 Alex Manzella. All rights reserved.
//

#import "MPITunesPlugin.h"

@implementation MPITunesPlugin

+ (BOOL)isAvailable{
    return YES; // iTunes is always installed so.... for other app example... return [[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Spotify.app" isDirectory:nil]
}

+ (NSString *)serviceName{
    return @"iTunes";
}


- (instancetype)init{
    
    if (self=[super init]) {
        
        iTunesApp=[SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];

        [iTunesApp activate]; // open iTunes
        
    }
    
    return self;
}



#pragma mark - Notification

- (NSString *)distribuitedNotificationName{
    
    return @"com.apple.iTunes.playerInfo";
}

- (void)handleNotification:(NSNotification *)notification{
    
    NSDictionary* userInfo=notification.userInfo;
    
    MPPlayerState state=MPPlayerStatePaused;
    
    if ([[userInfo objectForKey:@"Player State"] isEqualToString:@"Playing"]) {
        state=MPPlayerStatePlaying;
    }else if ([[userInfo objectForKey:@"Player State"] isEqualToString:@"Stopped"]){
        state=MPPlayerStateStopped;
    }
    
    self.playbackState=state;

    self.title=[userInfo objectForKey:kTitle];
    self.artist=[userInfo objectForKey:kArtist];
    self.album=[userInfo objectForKey:kAlbum];
    
    if ([self.delegate respondsToSelector:@selector(playerManager:statusDidChangeWithPlayerState:)]) {
        [self.delegate playerManager:self statusDidChangeWithPlayerState:self.playbackState];
    }
    
}


#pragma mark - Actions


- (void)togglePlayPause{
    
    [iTunesApp playpause];
}

- (void)next{
    
    [iTunesApp nextTrack];
}

- (void)previous{
    
    [iTunesApp previousTrack];
}



#pragma mark Getters

- (NSImage *)artwork{
    
    NSData* artworkData=[(iTunesArtwork *)[[[iTunesApp currentTrack] artworks]firstObject] rawData];
    if (!artworkData) {
        return nil;
    }
    return [[NSImage alloc] initWithData:artworkData];
}


#pragma mark Update

- (void)update{
 
    iTunesEPlS itunesState = [iTunesApp playerState];
    
    MPPlayerState state=MPPlayerStatePlaying;
    
    if (itunesState==iTunesEPlSPaused) {
        state=MPPlayerStatePaused;
    }else if (itunesState==iTunesEPlSStopped){
        state=MPPlayerStateStopped;
    }
    
    self.playbackState=state;

    
    self.title=[[iTunesApp currentTrack] name];
    self.artist=[[iTunesApp currentTrack] artist];
    
    if ([self.delegate respondsToSelector:@selector(playerManager:statusDidChangeWithPlayerState:)]) {
        [self.delegate playerManager:self statusDidChangeWithPlayerState:self.playbackState];
    }
    
}


#pragma mark - Search

- (BOOL)searchEnabled{
    
    return YES;
}

- (iTunesPlaylist *)getLibrary{
    
    if (!libraryPlaylist) {
        
        for (iTunesSource* source in [iTunesApp sources]) {
            if ([source kind]==iTunesESrcLibrary) {
                NSArray *playlists=[source playlists];
                for (iTunesPlaylist *playlist in playlists) {
                    if ([playlist specialKind]==iTunesESpKLibrary) {
                        libraryPlaylist=playlist;
                        return libraryPlaylist;
                    }else libraryPlaylist=[playlists firstObject]; // .... better than nothing...
                }
            }
        }
    }
    
    return libraryPlaylist;
}

- (void)searchSongsForQuery:(NSString *)query{
    
    NSArray *items=(NSArray *)[[self getLibrary] searchFor:query only:iTunesESrAAll];
    
    if ([items count]==0) {
        if ([self.delegate respondsToSelector:@selector(playerManager:didFoundItems:forQuery:)]) {
            [self.delegate playerManager:self didFoundItems:nil forQuery:query];
        }
    }
    
    NSMutableArray *properTracks=[[NSMutableArray alloc] init];
    for (iTunesTrack* track in items) {
        NSData *data=[[[track artworks] firstObject] rawData];
        NSImage* image=nil;
        if (data) {
            image=[[NSImage alloc] initWithData:data];
        }
        [properTracks addObject:[[MPITunesSong alloc] initWithTitle:[track name] artist:[track artist] album:[track album] artwork:image itemID:track]];
    }
    
    if ([self.delegate respondsToSelector:@selector(playerManager:didFoundItems:forQuery:)]) {
        [self.delegate playerManager:self didFoundItems:properTracks forQuery:query];
    }
    
}

-(void)didSelectItem:(id<MPMediaItem>)item{
    [(iTunesTrack *)[item itemID] playOnce:YES];
}

@end
