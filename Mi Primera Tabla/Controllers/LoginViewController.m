//
//  LoginViewController.m
//  Mi Primera Tabla
//
//  Created by Amalia Gatelum on 10/29/17.
//  Copyright © 2017 wgdomenzain. All rights reserved.
//

#import "LoginViewController.h"
@import FirebaseAnalytics;

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet GIDSignInButton *signInButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].clientID = @"212668756959-lii6d3i8odunk05oq86ourvmc3knrs6u.apps.googleusercontent.com";
    [GIDSignIn sharedInstance].delegate = self;
    
    [FIRAnalytics logEventWithName:@"pantalla_login"
                        parameters:@{
                                     @"name": @"pantalla_login",
                                     @"full_text": @"pantalla_login"
                                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Google Delegatte
// Implement these methods only if the GIDSignInUIDelegate is not a subclass of
// UIViewController.

// Stop the UIActivityIndicatorView animation that was started when the user
// pressed the Sign In button
- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    //[myActivityIndicator stopAnimating];
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    if (error == nil) {
        // Perform any operations on signed in user here.
        NSString *userId = user.userID;                  // For client-side use only!
        NSString *idToken = user.authentication.idToken; // Safe to send to the server
        NSString *fullName = user.profile.name;
        NSString *givenName = user.profile.givenName;
        NSString *familyName = user.profile.familyName;
        NSString *email = user.profile.email;
        // Go to list
        [self performSegueWithIdentifier:@"toList" sender:nil];
    } else {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Iniciar sesión"
                                                                       message:@"No se pudo iniciar sesión, intente de nuevo."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


@end
