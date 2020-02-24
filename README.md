# first_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# Build APK (Android)

1. Run `flutter packages get` after cloning.
2. Make sure .env and google-services.json already created in each respective directory.
3. Create a keystore using following command for Mac/Linux 
    ```
    keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
    ```
3. For Windows
    ```
    keytool -genkey -v -keystore c:/Users/USER_NAME/key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias key
    ```
4. Create a file named key.properties in project directory/android/ , which contains 
    ```
    storePassword=<password from previous step>
    keyPassword=<password from previous step>
    keyAlias=key
    storeFile=<location of the key store file, such as /Users/<user name>/key.jks>
    ```
5. In the build.gradle (App-level) , before android block , add 
    ```
    def keystoreProperties = new Properties()
    def keystorePropertiesFile = rootProject.file('key.properties')
    if (keystorePropertiesFile.exists()) {
        keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
    }

    android {
            ...
    }
    ```
6. In the same file ,before buildTypes block , add 
    ```
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
    ```
7. In the project directory , open terminal , run 
    ```
    flutter build apk --split-per-abi
    ```

8. Connect your Android Device to your computer with USB cable , and in the project directory run 
    ```
    flutter install
    ```

# Issues

Currently the google sign in button is not working after releasing the app,it only work when running the apps localy with ``flutter run``,to login to the app use email and password field which use firebase auth.

List of email and password that is working : 
1. `test@testmail.com` with password `test123`
2. `coba@mail.com` with password `123456`