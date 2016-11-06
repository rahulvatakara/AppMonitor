
set -e

LIB_EXT=framework
LIB_NAME=AppMonitor
SDK_PATH=$(pwd)/..
SDK_PROJECT="${SDK_PATH}/AppMonitor/AppMonitor.xcodeproj"
OUTPUT_PATH="${SDK_PATH}/Output"

echo "${SDK_PROJECT}"

OUTPUT_LIB_PATH="${OUTPUT_PATH}/lib/${LIB_NAME}.${LIB_EXT}"

rm -Rf "${OUTPUT_PATH}/lib/${LIB_NAME}.${LIB_EXT}"

# 1st argument is iphoneos or iphonesimulator. 2nd argument is Architecture
function BuildProject ()
{
	echo "BUILDING $1"AppMonitor
	
	xcodebuild -sdk $1 -project "${SDK_PROJECT}" -target AppMonitor CONFIGURATION="Release" clean build ARCHS=$2 IPHONEOS_DEPLOYMENT_TARGET='8.0'
	
	if [ -f "${OUTPUT_PATH}/.Universal/${LIB_NAME}.${LIB_EXT}" ]
	then
		echo "Combining"
		mkdir -p "${OUTPUT_PATH}/.Universal/tmp"
		
		cp -f "${OUTPUT_PATH}/.Universal/${LIB_NAME}.${LIB_EXT}" "${OUTPUT_PATH}/.Universal/tmp"
		lipo -create "${OUTPUT_PATH}/.Universal/tmp/${LIB_NAME}.${LIB_EXT}" "${OUTPUT_LIB_PATH}" -output "${OUTPUT_PATH}/.Universal/${LIB_NAME}.${LIB_EXT}"
	else
		echo "COPYING"
		cp -fv "${OUTPUT_LIB_PATH}" "${OUTPUT_PATH}/.Universal/${LIB_NAME}.${LIB_EXT}"
	fi
	
	rm -f "${OUTPUT_LIB_PATH}"
}

rm -fR "${OUTPUT_PATH}/.Universal"
mkdir -p "${OUTPUT_PATH}/.Universal"
mkdir -p "${OUTPUT_PATH}/lib"

BuildProject iphonesimulator 'i386'
BuildProject iphonesimulator 'x86_64'
BuildProject iphoneos 'armv7'
BuildProject iphoneos 'armv7s'
BuildProject iphoneos 'arm64'

cp -fv "${OUTPUT_PATH}/.Universal/${LIB_NAME}.${LIB_EXT}" "${OUTPUT_LIB_PATH}"

# rm -Rf "${OUTPUT_PATH}/.Universal"

# rm -fR mkdir -p "${OUTPUT_PATH}/VMaxAdSDK"

# mkdir -p "${OUTPUT_PATH}/VMaxAdSDK/include"
# mkdir -p "${OUTPUT_PATH}/VMaxAdSDK/lib"

# cp -fR "${OUTPUT_PATH}/include/" "${OUTPUT_PATH}/VMaxAdSDK/include/"
# cp -fR "${OUTPUT_PATH}/lib/" "${OUTPUT_PATH}/VMaxAdSDK/lib/"
# cp -fR "${OUTPUT_PATH}/VMaxAdSDKResources.bundle/" "${OUTPUT_PATH}/VMaxAdSDK/VMaxAdSDKResources.bundle/"

# rm -fR mkdir -p "${OUTPUT_PATH}/include"
# rm -fR mkdir -p "${OUTPUT_PATH}/lib"
# rm -fR mkdir -p "${OUTPUT_PATH}/VMaxAdSDKResources.bundle"

## Create LIVE URL directory and copy to it.
# OUTPUT_LIVEURL_PATH="${OUTPUT_PATH}/LiveURL"

# rm -fR "${OUTPUT_LIVEURL_PATH}"
# mkdir -p "${OUTPUT_LIVEURL_PATH}"

# cp -fR "${OUTPUT_PATH}/VMaxAdSDK" "${OUTPUT_LIVEURL_PATH}/VMaxAdSDK"
# rm -fR "${OUTPUT_PATH}/VMaxAdSDK"