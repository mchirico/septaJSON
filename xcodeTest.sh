#!/bin/bash
cd SeptaJSON
xcodebuild clean build -project SeptaJSON.xcodeproj -scheme SeptaJSON CODE_SIGNING_REQUIRED=NO -destination 'platform=iOS Simulator,name=iPhone X,OS=12.1' -quiet
xcodebuild test -project SeptaJSON.xcodeproj -scheme SeptaJSON -destination 'platform=iOS Simulator,name=iPhone X,OS=12.1'  -enableCodeCoverage  YES -quiet
