setup:
	bundle install --path vendor/bundle
	bundle exec pod install

build:
	bundle exec fastlane build
