package basic

import "../../xinput"

import "core:fmt"

// Based on the sample code in 
// https://learn.microsoft.com/en-us/windows/win32/xinput/getting-started-with-xinput

main :: proc() {
	for user in xinput.User {
		state: xinput.XINPUT_STATE
		result := xinput.XInputGetState(user, &state)

		#partial switch result {
		case .SUCCESS:
			// Controller is connected
			fmt.printf("Controller %v is connected\n", user)
		case .DEVICE_NOT_CONNECTED:
			// Controller is not connected
			fmt.printf("Controller %v is not connected\n", user)
		case:
			fmt.eprintf(
				"XInputGetState for controller %v returned %v\n",
				user,
				result,
			)
		}
	}
}
