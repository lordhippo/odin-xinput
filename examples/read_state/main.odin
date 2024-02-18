package read_state

import "../../xinput"

import "core:fmt"
import "core:time"
import "core:sys/windows"

main :: proc() {
	user :: xinput.XUSER.One

	packet_number: windows.DWORD
	for {
		state: xinput.XINPUT_STATE
		if result := xinput.XInputGetState(user, &state); result == .SUCCESS {
			// check if new readings are available
			if packet_number == state.dwPacketNumber do continue
			fmt.printf(
				"%v new packets are available\n",
				state.dwPacketNumber - packet_number,
			)
			packet_number = state.dwPacketNumber

			fmt.printf("Controller %v's state: %v", user, state.Gamepad)
		}

		keystrokes: xinput.XINPUT_KEYSTROKE
		if result := xinput.XInputGetKeystroke(.One, 0, &keystrokes);
		   result == .SUCCESS {
			fmt.printf("Controller %v's keystrokes: %v\n", user, keystrokes)
		}

		battery: xinput.XINPUT_BATTERY_INFORMATION
		if result := xinput.XInputGetBatteryInformation(
			.One,
			.GAMEPAD,
			&battery,
		); result == .SUCCESS {
			fmt.printf("Controller %v's battery info: %v\n", user, battery)
		}

		time.sleep(20 * time.Millisecond)
	}
}
