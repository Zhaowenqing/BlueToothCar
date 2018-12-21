

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "CarController" "NUM_INSTANCES" "DEVICE_ID"  "C_Drt_BASEADDR" "C_Drt_HIGHADDR"
}
