package xinput

foreign import "system:xinput.lib"

import "core:sys/windows"

// Device types available in XINPUT_CAPABILITIES
// Correspond to XINPUT_DEVTYPE_...
Dev_Type :: enum windows.BYTE {
	GAMEPAD = 0x01,
}

// Device subtypes available in XINPUT_CAPABILITIES
// Correspond to XINPUT_DEVSUBTYPE_...
Dev_Subtype :: enum windows.BYTE {
	UNKNOWN          = 0x00,
	GAMEPAD          = 0x01,
	WHEEL            = 0x02,
	ARCADE_STICK     = 0x03,
	FLIGHT_STICK     = 0x04,
	DANCE_PAD        = 0x05,
	GUITAR           = 0x06,
	GUITAR_ALTERNATE = 0x07,
	DRUM_KIT         = 0x08,
	GUITAR_BASS      = 0x0B,
	ARCADE_PAD       = 0x13,
}

// Flags for XINPUT_CAPABILITIES
// Correspond to log2(XINPUT_CAPS_...)
Cap :: enum {
	FFB_SUPPORTED   = 0,
	WIRELESS        = 1,
	VOICE_SUPPORTED = 2,
	PMD_SUPPORTED   = 3,
	NO_NAVIGATION   = 4,
}
Caps :: bit_set[Cap;windows.WORD]

// Constants for gamepad buttons
// Correspond to log2(XINPUT_GAMEPAD_...)
Gamepad_Button :: enum {
	DPAD_UP        = 0,
	DPAD_DOWN      = 1,
	DPAD_LEFT      = 2,
	DPAD_RIGHT     = 3,
	START          = 4,
	BACK           = 5,
	LEFT_THUMB     = 6,
	RIGHT_THUMB    = 7,
	LEFT_SHOULDER  = 8,
	RIGHT_SHOULDER = 9,
	A              = 12,
	B              = 13,
	X              = 14,
	Y              = 15,
}
Gamepad_Buttons :: bit_set[Gamepad_Button;windows.WORD]

// Gamepad thresholds
XINPUT_GAMEPAD_LEFT_THUMB_DEADZONE: windows.SHORT : 7849
XINPUT_GAMEPAD_RIGHT_THUMB_DEADZONE: windows.SHORT : 8689
XINPUT_GAMEPAD_TRIGGER_THRESHOLD: windows.SHORT : 30

// Flags to pass to XInputGetCapabilities
// Corresponds to log2(XINPUT_FLAG_...)
Flag :: enum {
	GAMEPAD = 0,
}
Flags :: bit_set[Flag;windows.DWORD]

// Devices that support batteries
// Corresponds to BATTERY_DEVTYPE_...
Battery_Dev_Type :: enum windows.BYTE {
	GAMEPAD = 0x00,
	HEADSET = 0x01,
}

// Flags for battery status level
// Correspond to BATTERY_TYPE_...
Battery_Type :: enum windows.BYTE {
	DISCONNECTED = 0x00, // This device is not connected
	WIRED        = 0x01, // Wired device, no battery
	ALKALINE     = 0x02, // Alkaline battery source
	NIMH         = 0x03, // Nickel Metal Hydride battery source
	UNKNOWN      = 0xFF, // Cannot determine the battery type
}

// These are only valid for wireless, connected devices, with known battery types
// The amount of use time remaining depends on the type of device.
// Correspond to BATTERY_LEVEL_...
Battery_Level :: enum windows.BYTE {
	EMPTY  = 0x00,
	LOW    = 0x01,
	MEDIUM = 0x02,
	FULL   = 0x03,
}

// User index definitions

// Index of the gamer associated with the device
User :: enum windows.DWORD {
	One   = 0,
	Two   = 1,
	Three = 2,
	Four  = 3,
	Any   = 0x000000FF, // Can be only used with XInputGetKeystroke
}

XUSER_MAX_COUNT :: 4

// Codes returned for the gamepad keystroke
// Corresponds to VK_PAD_...
Virtual_Key :: enum windows.WORD {
	A                = 0x5800,
	B                = 0x5801,
	X                = 0x5802,
	Y                = 0x5803,
	RSHOULDER        = 0x5804,
	LSHOULDER        = 0x5805,
	LTRIGGER         = 0x5806,
	RTRIGGER         = 0x5807,
	DPAD_UP          = 0x5810,
	DPAD_DOWN        = 0x5811,
	DPAD_LEFT        = 0x5812,
	DPAD_RIGHT       = 0x5813,
	START            = 0x5814,
	BACK             = 0x5815,
	LTHUMB_PRESS     = 0x5816,
	RTHUMB_PRESS     = 0x5817,
	LTHUMB_UP        = 0x5820,
	LTHUMB_DOWN      = 0x5821,
	LTHUMB_RIGHT     = 0x5822,
	LTHUMB_LEFT      = 0x5823,
	LTHUMB_UPLEFT    = 0x5824,
	LTHUMB_UPRIGHT   = 0x5825,
	LTHUMB_DOWNRIGHT = 0x5826,
	LTHUMB_DOWNLEFT  = 0x5827,
	RTHUMB_UP        = 0x5830,
	RTHUMB_DOWN      = 0x5831,
	RTHUMB_RIGHT     = 0x5832,
	RTHUMB_LEFT      = 0x5833,
	RTHUMB_UPLEFT    = 0x5834,
	RTHUMB_UPRIGHT   = 0x5835,
	RTHUMB_DOWNRIGHT = 0x5836,
	RTHUMB_DOWNLEFT  = 0x5837,
}

// Flags used in XINPUT_KEYSTROKE
// Correspond to log2(XINPUT_KEYSTROKE_...)
Keystroke :: enum {
	KEYDOWN = 0,
	KEYUP   = 1,
	REPEAT  = 2,
}
Keystrokes :: bit_set[Keystroke;windows.WORD]

// Structures used by XInput APIs
XINPUT_GAMEPAD :: struct {
	wButtons:      Gamepad_Buttons,
	bLeftTrigger:  windows.BYTE,
	bRightTrigger: windows.BYTE,
	sThumbLX:      windows.SHORT,
	sThumbLY:      windows.SHORT,
	sThumbRX:      windows.SHORT,
	sThumbRY:      windows.SHORT,
}

XINPUT_STATE :: struct {
	dwPacketNumber: windows.DWORD,
	Gamepad:        XINPUT_GAMEPAD,
}

XINPUT_VIBRATION :: struct {
	wLeftMotorSpeed:  windows.WORD,
	wRightMotorSpeed: windows.WORD,
}

XINPUT_CAPABILITIES :: struct {
	Type:      Dev_Type,
	SubType:   Dev_Subtype,
	Flags:     Caps,
	Gamepad:   XINPUT_GAMEPAD,
	Vibration: XINPUT_VIBRATION,
}

XINPUT_BATTERY_INFORMATION :: struct {
	BatteryType:  Battery_Type,
	BatteryLevel: Battery_Level,
}

XINPUT_KEYSTROKE :: struct {
	VirtualKey: Virtual_Key,
	Unicode:    windows.WCHAR,
	Flags:      Keystrokes,
	UserIndex:  User,
	HidCode:    windows.BYTE,
}

// XInput APIs
@(default_calling_convention = "std")
foreign xinput {

	@(link_name = "XInputGetState")
	XInputGetState :: proc(user: User, pState: ^XINPUT_STATE) -> windows.System_Error ---

	@(link_name = "XInputSetState")
	XInputSetState :: proc(user: User, pVibration: ^XINPUT_VIBRATION) -> windows.System_Error ---

	@(link_name = "XInputGetCapabilities")
	XInputGetCapabilities :: proc(user: User, dwFlags: Flags, pCapabilities: ^XINPUT_CAPABILITIES) -> windows.System_Error ---

	@(link_name = "XInputEnable")
	XInputEnable :: proc(enable: windows.BOOL) ---

	@(link_name = "XInputGetAudioDeviceIds")
	XInputGetAudioDeviceIds :: proc(user: User, pRenderDeviceId: windows.LPWSTR, pRenderCount: ^windows.UINT, pCaptureDeviceId: windows.LPWSTR, pCaptureCount: ^windows.UINT) -> windows.System_Error ---

	@(link_name = "XInputGetBatteryInformation")
	XInputGetBatteryInformation :: proc(user: User, devType: Battery_Dev_Type, pBatteryInformation: ^XINPUT_BATTERY_INFORMATION) -> windows.System_Error ---

	@(link_name = "XInputGetKeystroke")
	XInputGetKeystroke :: proc(user: User, dwReserved: windows.DWORD, pKeystroke: ^XINPUT_KEYSTROKE) -> windows.System_Error ---

	@(link_name = "XInputGetDSoundAudioDeviceGuids")
	XInputGetDSoundAudioDeviceGuids :: proc(user: User, pDSoundRenderGuid: ^windows.GUID, pDSoundCaptureGuid: ^windows.GUID) -> windows.System_Error ---

}
