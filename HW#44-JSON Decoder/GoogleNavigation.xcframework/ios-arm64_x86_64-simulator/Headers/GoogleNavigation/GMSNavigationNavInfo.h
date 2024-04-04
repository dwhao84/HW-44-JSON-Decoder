//
//  GMSNavigationNavInfo.h
//  Google Navigation SDK for iOS
//
//  Copyright 2022 Google LLC
//
//  Usage of this SDK is subject to the Google Maps/Google Earth APIs Terms of
//  Service: https://cloud.google.com/maps-platform/terms
//

#import <CoreLocation/CoreLocation.h>

#import "GMSNavigationTypes.h"

@class GMSNavigationStepInfo;

NS_ASSUME_NONNULL_BEGIN

/** Contains information about the state of navigation */
@interface GMSNavigationNavInfo : NSObject

/** The current @c GMSNavigationNavState for navigation. */
@property(nonatomic, readonly) GMSNavigationNavState navState;

/**
 * Information about the upcoming maneuver step. This is only set if the navState is
 * GMSNavigationNavStateEnroute and will be null otherwise.
 */
@property(nonatomic, nullable, readonly) GMSNavigationStepInfo *currentStep;

/** The remaining steps after the current step. */
@property(nonatomic, readonly) NSArray<GMSNavigationStepInfo *> *remainingSteps;

/**
 * Whether the route has changed since the last sent message. A route change may be caused by a
 * reroute, the addition/removal of a waypoint, the user selecting or driving onto an alternate
 * route, or a traffic update.
 */
@property(nonatomic, readonly) BOOL routeChanged;

/** The estimated remaining time in seconds along the route to the current step. */
@property(nonatomic, readonly) NSTimeInterval timeToCurrentStepSeconds;

/** The estimated remaining distance in meters along the route to the current step .*/
@property(nonatomic, readonly) CLLocationDistance distanceToCurrentStepMeters;

/** The estimated remaining time in seconds to the final destination. */
@property(nonatomic, readonly) NSTimeInterval timeToFinalDestinationSeconds;

/** The estimated remaining distance in meters to the final destination.*/
@property(nonatomic, readonly) CLLocationDistance distanceToFinalDestinationMeters;

- (null_unspecified instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
