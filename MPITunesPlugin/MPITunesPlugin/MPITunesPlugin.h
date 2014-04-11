//
//  MPSpotifyManager.h
//  MiniPlayer for Mac
//
//  Created by Alex Manzella on 09/04/14.
//  Copyright (c) 2014 Alex Manzella. All rights reserved.
//

#import "MPMiniPlayerPlugin.h"
#import <Scripting/Scripting.h>
#import "iTunes.h"
#import "MPITunesSong.h"

static NSString* kTitle=@"Name";
static NSString* kArtist=@"Artist";
static NSString* kAlbum=@"Album";

@interface MPITunesPlugin : NSObject<MPMiniPlayerPlugin>{
    
    iTunesApplication *iTunesApp;
    iTunesPlaylist *libraryPlaylist;
}

@property (nonatomic,readwrite) id<MPMiniPlayerDelegate>delegate;
@property (nonatomic,assign) MPPlayerState playbackState;
@property (nonatomic,copy) NSString *title,*artist,*album;
@property (nonatomic,copy) NSImage *artwork;

@end
