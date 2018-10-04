#!/bin/bash
cd septaJSON
xcodebuild clean build -project septaJSON.xcodeproj -scheme septaJSON CODE_SIGNING_REQUIRED=NO -destination 'platform=iOS Simulator,name=iPhone X,OS=12.0' -quiet
xcodebuild test -project septaJSON.xcodeproj -scheme septaJSON -destination 'platform=iOS Simulator,name=iPhone X,OS=12.0'  -enableCodeCoverage  YES -quiet
