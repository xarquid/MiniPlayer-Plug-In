//
//  MPITunesSong.m
//  MPITunesPlugin
//
//  Created by Alex Manzella on 11/04/14.
//  Copyright (c) 2014 mpow. All rights reserved.
//

#import "MPITunesSong.h"

@implementation MPITunesSong

- (instancetype)initWithTitle:(NSString *)title artist:(NSString *)artist album:(NSString *)album artwork:(id)artwork itemID:(id)itemID{
    
    if (self=[super init]) {
        
        self.title=title;
        self.artist=artist;
        self.album=album;
        self.artwork=artwork;
        self.itemID=itemID;
    }
    
    return self;
}

@end