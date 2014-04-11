//
//  MPITunesSong.h
//  MPITunesPlugin
//
//  Created by Alex Manzella on 11/04/14.
//  Copyright (c) 2014 mpow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPMiniPlayerPlugin.h"

@interface MPITunesSong : NSObject<MPMediaItem>

@property (nonatomic,copy) NSString *title,*artist,*album;
@property (nonatomic,readwrite) id itemID;
@property (nonatomic,copy) id artwork;
// itemID can be something helpfull needed when didSelectItem is called... for example Spotify itemID is needed to play it... if you don't need forgot about it.

- (instancetype)initWithTitle:(NSString *)title artist:(NSString *)artist album:(NSString *)album artwork:(id)artwork itemID:(id)itemID;


@end
