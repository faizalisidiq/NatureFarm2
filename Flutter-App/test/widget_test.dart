name: naturefarm
description: A new Flutter project for NatureFarm 🐐🌿

publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: ">=3.3.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.6
  # Tambahin package lain kalau butuh di sini

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^3.0.1

flutter:

  uses-material-design: true

  assets:
    - assets/images/
    - assets/fonts/

  fonts:
    - family: Poppins
      fonts:
        - asset: assets/fonts/Poppins-Regular.ttf
        - asset: assets/fonts/Poppins-Medium.ttf
        - asset: assets/fonts/Poppins-SemiBold.ttf
        - asset: assets/fonts/Poppins-Bold.ttf
