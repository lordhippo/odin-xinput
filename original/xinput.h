/***************************************************************************
*                                                                          *
*   XInput.h -- This module defines Xbox 360 Common Controller APIs        *
*               and constants for the Windows platform.                    *
*                                                                          *
*   Copyright (c) Microsoft Corp. All rights reserved.                     *
*                                                                          *
***************************************************************************/

#pragma once

#include <stddef.h>

#ifndef GUID_DEFINED
#define GUID_DEFINED
typedef struct _GUID {
    unsigned long  Data1;
    unsigned short Data2;
    unsigned short Data3;
    unsigned char  Data4[8];
} GUID;
#endif

//#define XINPUT_DLL_A  "xinput1_4.dll"

//
// Device types available in XINPUT_CAPABILITIES
//
#define XINPUT_DEVTYPE_GAMEPAD          0x01

//
// Device subtypes available in XINPUT_CAPABILITIES
//

#define XINPUT_DEVSUBTYPE_GAMEPAD           0x01

#define XINPUT_DEVSUBTYPE_UNKNOWN           0x00
#define XINPUT_DEVSUBTYPE_WHEEL             0x02
#define XINPUT_DEVSUBTYPE_ARCADE_STICK      0x03
#define XINPUT_DEVSUBTYPE_FLIGHT_STICK      0x04
#define XINPUT_DEVSUBTYPE_DANCE_PAD         0x05
#define XINPUT_DEVSUBTYPE_GUITAR            0x06
#define XINPUT_DEVSUBTYPE_GUITAR_ALTERNATE  0x07
#define XINPUT_DEVSUBTYPE_DRUM_KIT          0x08
#define XINPUT_DEVSUBTYPE_GUITAR_BASS       0x0B
#define XINPUT_DEVSUBTYPE_ARCADE_PAD        0x13

//
// Flags for XINPUT_CAPABILITIES
//

#define XINPUT_CAPS_VOICE_SUPPORTED     0x0004

#define XINPUT_CAPS_FFB_SUPPORTED       0x0001
#define XINPUT_CAPS_WIRELESS            0x0002
#define XINPUT_CAPS_PMD_SUPPORTED       0x0008
#define XINPUT_CAPS_NO_NAVIGATION       0x0010

//
// Constants for gamepad buttons
//
#define XINPUT_GAMEPAD_DPAD_UP          0x0001
#define XINPUT_GAMEPAD_DPAD_DOWN        0x0002
#define XINPUT_GAMEPAD_DPAD_LEFT        0x0004
#define XINPUT_GAMEPAD_DPAD_RIGHT       0x0008
#define XINPUT_GAMEPAD_START            0x0010
#define XINPUT_GAMEPAD_BACK             0x0020
#define XINPUT_GAMEPAD_LEFT_THUMB       0x0040
#define XINPUT_GAMEPAD_RIGHT_THUMB      0x0080
#define XINPUT_GAMEPAD_LEFT_SHOULDER    0x0100
#define XINPUT_GAMEPAD_RIGHT_SHOULDER   0x0200
#define XINPUT_GAMEPAD_A                0x1000
#define XINPUT_GAMEPAD_B                0x2000
#define XINPUT_GAMEPAD_X                0x4000
#define XINPUT_GAMEPAD_Y                0x8000


//
// Gamepad thresholds
//
#define XINPUT_GAMEPAD_LEFT_THUMB_DEADZONE  7849
#define XINPUT_GAMEPAD_RIGHT_THUMB_DEADZONE 8689
#define XINPUT_GAMEPAD_TRIGGER_THRESHOLD    30

//
// Flags to pass to XInputGetCapabilities
//
#define XINPUT_FLAG_GAMEPAD             0x00000001

//
// Devices that support batteries
//
#define BATTERY_DEVTYPE_GAMEPAD         0x00
#define BATTERY_DEVTYPE_HEADSET         0x01

//
// Flags for battery status level
//
#define BATTERY_TYPE_DISCONNECTED       0x00    // This device is not connected
#define BATTERY_TYPE_WIRED              0x01    // Wired device, no battery
#define BATTERY_TYPE_ALKALINE           0x02    // Alkaline battery source
#define BATTERY_TYPE_NIMH               0x03    // Nickel Metal Hydride battery source
#define BATTERY_TYPE_UNKNOWN            0xFF    // Cannot determine the battery type

// These are only valid for wireless, connected devices, with known battery types
// The amount of use time remaining depends on the type of device.
#define BATTERY_LEVEL_EMPTY             0x00
#define BATTERY_LEVEL_LOW               0x01
#define BATTERY_LEVEL_MEDIUM            0x02
#define BATTERY_LEVEL_FULL              0x03

// User index definitions
#define XUSER_MAX_COUNT                 4

#define XUSER_INDEX_ANY                 0x000000FF

//
// Codes returned for the gamepad keystroke
//

#define VK_PAD_A                        0x5800
#define VK_PAD_B                        0x5801
#define VK_PAD_X                        0x5802
#define VK_PAD_Y                        0x5803
#define VK_PAD_RSHOULDER                0x5804
#define VK_PAD_LSHOULDER                0x5805
#define VK_PAD_LTRIGGER                 0x5806
#define VK_PAD_RTRIGGER                 0x5807

#define VK_PAD_DPAD_UP                  0x5810
#define VK_PAD_DPAD_DOWN                0x5811
#define VK_PAD_DPAD_LEFT                0x5812
#define VK_PAD_DPAD_RIGHT               0x5813
#define VK_PAD_START                    0x5814
#define VK_PAD_BACK                     0x5815
#define VK_PAD_LTHUMB_PRESS             0x5816
#define VK_PAD_RTHUMB_PRESS             0x5817

#define VK_PAD_LTHUMB_UP                0x5820
#define VK_PAD_LTHUMB_DOWN              0x5821
#define VK_PAD_LTHUMB_RIGHT             0x5822
#define VK_PAD_LTHUMB_LEFT              0x5823
#define VK_PAD_LTHUMB_UPLEFT            0x5824
#define VK_PAD_LTHUMB_UPRIGHT           0x5825
#define VK_PAD_LTHUMB_DOWNRIGHT         0x5826
#define VK_PAD_LTHUMB_DOWNLEFT          0x5827

#define VK_PAD_RTHUMB_UP                0x5830
#define VK_PAD_RTHUMB_DOWN              0x5831
#define VK_PAD_RTHUMB_RIGHT             0x5832
#define VK_PAD_RTHUMB_LEFT              0x5833
#define VK_PAD_RTHUMB_UPLEFT            0x5834
#define VK_PAD_RTHUMB_UPRIGHT           0x5835
#define VK_PAD_RTHUMB_DOWNRIGHT         0x5836
#define VK_PAD_RTHUMB_DOWNLEFT          0x5837

//
// Flags used in XINPUT_KEYSTROKE
//
#define XINPUT_KEYSTROKE_KEYDOWN        0x0001
#define XINPUT_KEYSTROKE_KEYUP          0x0002
#define XINPUT_KEYSTROKE_REPEAT         0x0004

//
// Structures used by XInput APIs
//
typedef struct _XINPUT_GAMEPAD
{
    unsigned short                                wButtons;
    unsigned char                                bLeftTrigger;
    unsigned char                                bRightTrigger;
    short                               sThumbLX;
    short                               sThumbLY;
    short                               sThumbRX;
    short                               sThumbRY;
} XINPUT_GAMEPAD;

typedef struct _XINPUT_STATE
{
    unsigned long                               dwPacketNumber;
    XINPUT_GAMEPAD                      Gamepad;
} XINPUT_STATE;

typedef struct _XINPUT_VIBRATION
{
    unsigned short                                wLeftMotorSpeed;
    unsigned short                                wRightMotorSpeed;
} XINPUT_VIBRATION;

typedef struct _XINPUT_CAPABILITIES
{
    unsigned char                                Type;
    unsigned char                                SubType;
    unsigned short                                Flags;
    XINPUT_GAMEPAD                      Gamepad;
    XINPUT_VIBRATION                    Vibration;
} XINPUT_CAPABILITIES;

typedef struct _XINPUT_BATTERY_INFORMATION
{
    unsigned char BatteryType;
    unsigned char BatteryLevel;
} XINPUT_BATTERY_INFORMATION;

typedef struct _XINPUT_KEYSTROKE
{
    unsigned short    VirtualKey;
    wchar_t   Unicode;
    unsigned short    Flags;
    unsigned char    UserIndex;
    unsigned char    HidCode;
} XINPUT_KEYSTROKE;

//
// XInput APIs
//

unsigned long  XInputGetState
(
    unsigned long         dwUserIndex,  // Index of the gamer associated with the device
    XINPUT_STATE* pState        // Receives the current state
);

unsigned long  XInputSetState
(
    unsigned long             dwUserIndex,  // Index of the gamer associated with the device
    XINPUT_VIBRATION* pVibration    // The vibration information to send to the controller
);

unsigned long  XInputGetCapabilities
(
    unsigned long                dwUserIndex,   // Index of the gamer associated with the device
    unsigned long                dwFlags,       // Input flags that identify the device type
    XINPUT_CAPABILITIES* pCapabilities  // Receives the capabilities
);

void  XInputEnable
(
    int enable     // [in] Indicates whether xinput is enabled or disabled. 
);

#pragma deprecated(XInputEnable)

unsigned long  XInputGetAudioDeviceIds
(
    unsigned long                             dwUserIndex,        // Index of the gamer associated with the device
    wchar_t*  pRenderDeviceId,    // Windows Core Audio device ID string for render (speakers)
    unsigned int*                       pRenderCount,       // Size of render device ID string buffer (in wide-chars)
    wchar_t* pCaptureDeviceId,   // Windows Core Audio device ID string for capture (microphone)
    unsigned int*                       pCaptureCount       // Size of capture device ID string buffer (in wide-chars)
);

unsigned long  XInputGetBatteryInformation
(
    unsigned long                       dwUserIndex,        // Index of the gamer associated with the device
    unsigned char                        devType,            // Which device on this user index
    XINPUT_BATTERY_INFORMATION* pBatteryInformation // Contains the level and types of batteries
);

unsigned long  XInputGetKeystroke
(
    unsigned long dwUserIndex,              // Index of the gamer associated with the device
    unsigned long dwReserved,               // Reserved for future use
    XINPUT_KEYSTROKE* pKeystroke    // Pointer to an XINPUT_KEYSTROKE structure that receives an input event.
);

unsigned long  XInputGetDSoundAudioDeviceGuids
(
    unsigned long     dwUserIndex,  // Index of the gamer associated with the device
    GUID*     pDSoundRenderGuid,    // DSound device ID for render (speakers)
    GUID*     pDSoundCaptureGuid    // DSound device ID for capture (microphone)
);
