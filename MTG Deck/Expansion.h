//
//  Expansion.h
//  MTG Deck
//
//  Created by Luca on 16/05/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Card;

@interface Expansion : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * expid;
@property (nonatomic, retain) Card * cards;

@end
