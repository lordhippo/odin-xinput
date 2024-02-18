package xinput

foreign import "system:xinput.lib"

import "core:sys/windows"

// Device types available in XINPUT_CAPABILITIES
// Correspond to XINPUT_DEVTYPE_...
Dev_Type :: enum windows.BYTE {
	GAMEPAD = 1,
}

// Device subtypes available in XINPUT_CAPABILITIES
// Correspond to XINPUT_DEVSUBTYPE_...
Dev_Subtype :: enum windows.BYTE {
	UNKNOWN          = 0,
	GAMEPAD          = 1,
	WHEEL            = 2,
	ARCADE_STICK     = 3,
	FLIGHT_STICK     = 4,
	DANCE_PAD        = 5,
	GUITAR           = 6,
	GUITAR_ALTERNATE = 7,
	DRUM_KIT         = 8,
	GUITAR_BASS      = 11,
	ARCADE_PAD       = 19,
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
XINPUT_GAMEPAD_LEFT_THUMB_DEADZONE :: 7849
XINPUT_GAMEPAD_RIGHT_THUMB_DEADZONE :: 8689
XINPUT_GAMEPAD_TRIGGER_THRESHOLD :: 30

// Flags to pass to XInputGetCapabilities
// Corresponds to log2(XINPUT_FLAG_...)
Flag :: enum {
	GAMEPAD = 0,
}
Flags :: bit_set[Flag;windows.DWORD]

// Devices that support batteries
// Corresponds to BATTERY_DEVTYPE_...
Battery_Dev_Type :: enum windows.BYTE {
	GAMEPAD = 0,
	HEADSET = 1,
}

// Flags for battery status level
// Correspond to BATTERY_TYPE_...
Battery_Type :: enum windows.BYTE {
	DISCONNECTED = 0,
	WIRED        = 1,
	ALKALINE     = 2,
	NIMH         = 3,
	UNKNOWN      = 255,
}

// These are only valid for wireless, connected devices, with known battery types
// The amount of use time remaining depends on the type of device.
// Correspond to BATTERY_LEVEL_...
Battery_Level :: enum windows.BYTE {
	EMPTY  = 0,
	LOW    = 1,
	MEDIUM = 2,
	FULL   = 3,
}

// User index definitions
User :: enum windows.DWORD {
	One   = 0,
	Two   = 1,
	Three = 2,
	Four  = 3,
}

// Codes returned for the gamepad keystroke
// Corresponds to VK_PAD_...
Virtual_Key :: enum windows.WORD {
	A                = 22528,
	B                = 22529,
	X                = 22530,
	Y                = 22531,
	RSHOULDER        = 22532,
	LSHOULDER        = 22533,
	LTRIGGER         = 22534,
	RTRIGGER         = 22535,
	DPAD_UP          = 22544,
	DPAD_DOWN        = 22545,
	DPAD_LEFT        = 22546,
	DPAD_RIGHT       = 22547,
	START            = 22548,
	BACK             = 22549,
	LTHUMB_PRESS     = 22550,
	RTHUMB_PRESS     = 22551,
	LTHUMB_UP        = 22560,
	LTHUMB_DOWN      = 22561,
	LTHUMB_RIGHT     = 22562,
	LTHUMB_LEFT      = 22563,
	LTHUMB_UPLEFT    = 22564,
	LTHUMB_UPRIGHT   = 22565,
	LTHUMB_DOWNRIGHT = 22566,
	LTHUMB_DOWNLEFT  = 22567,
	RTHUMB_UP        = 22576,
	RTHUMB_DOWN      = 22577,
	RTHUMB_RIGHT     = 22578,
	RTHUMB_LEFT      = 22579,
	RTHUMB_UPLEFT    = 22580,
	RTHUMB_UPRIGHT   = 22581,
	RTHUMB_DOWNRIGHT = 22582,
	RTHUMB_DOWNLEFT  = 22583,
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
