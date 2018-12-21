
`timescale 1 ns / 1 ps

`include "CarController_v1_0_tb_include.vh"

// Burst Size Defines
`define BURST_SIZE_4_BYTES   3'b010

// Lock Type Defines
`define LOCK_TYPE_NORMAL    1'b0

// lite_response Type Defines
`define RESPONSE_OKAY 2'b00
`define RESPONSE_EXOKAY 2'b01
`define RESP_BUS_WIDTH 2
`define BURST_TYPE_INCR  2'b01
`define BURST_TYPE_WRAP  2'b10

// AMBA Drt AXI4 Range Constants
`define Drt_MAX_BURST_LENGTH 8'b1111_1111
`define Drt_MAX_DATA_SIZE (`Drt_DATA_BUS_WIDTH*(`Drt_MAX_BURST_LENGTH+1))/8
`define Drt_DATA_BUS_WIDTH 32
`define Drt_ADDRESS_BUS_WIDTH 32
`define Drt_RUSER_BUS_WIDTH 1
`define Drt_WUSER_BUS_WIDTH 1

module CarController_v1_0_tb;
	reg tb_ACLK;
	reg tb_ARESETn;

	// Create an instance of the example tb
	`BD_WRAPPER dut (.ACLK(tb_ACLK),
				.ARESETN(tb_ARESETn));

	// Local Variables

	// AMBA Drt AXI4 Local Reg
	reg [(`Drt_DATA_BUS_WIDTH*(`Drt_MAX_BURST_LENGTH+1)/16)-1:0] Drt_rd_data;
	reg [(`Drt_DATA_BUS_WIDTH*(`Drt_MAX_BURST_LENGTH+1)/16)-1:0] Drt_test_data [2:0];
	reg [(`RESP_BUS_WIDTH*(`Drt_MAX_BURST_LENGTH+1))-1:0] Drt_vresponse;
	reg [`Drt_ADDRESS_BUS_WIDTH-1:0] Drt_mtestAddress;
	reg [(`Drt_RUSER_BUS_WIDTH*(`Drt_MAX_BURST_LENGTH+1))-1:0] Drt_v_ruser;
	reg [(`Drt_WUSER_BUS_WIDTH*(`Drt_MAX_BURST_LENGTH+1))-1:0] Drt_v_wuser;
	reg [`RESP_BUS_WIDTH-1:0] Drt_response;
	integer  Drt_mtestID; // Master side testID
	integer  Drt_mtestBurstLength;
	integer  Drt_mtestvector; // Master side testvector
	integer  Drt_mtestdatasize;
	integer  Drt_mtestCacheType = 0;
	integer  Drt_mtestProtectionType = 0;
	integer  Drt_mtestRegion = 0;
	integer  Drt_mtestQOS = 0;
	integer  Drt_mtestAWUSER = 0;
	integer  Drt_mtestARUSER = 0;
	integer  Drt_mtestBUSER = 0;
	integer result_slave_full;


	// Simple Reset Generator and test
	initial begin
		tb_ARESETn = 1'b0;
	  #500;
		// Release the reset on the posedge of the clk.
		@(posedge tb_ACLK);
	  tb_ARESETn = 1'b1;
		@(posedge tb_ACLK);
	end

	// Simple Clock Generator
	initial tb_ACLK = 1'b0;
	always #10 tb_ACLK = !tb_ACLK;

	//------------------------------------------------------------------------
	// TEST LEVEL API: CHECK_RESPONSE_OKAY
	//------------------------------------------------------------------------
	// Description:
	// CHECK_RESPONSE_OKAY(lite_response)
	// This task checks if the return lite_response is equal to OKAY
	//------------------------------------------------------------------------
	task automatic CHECK_RESPONSE_OKAY;
		input [`RESP_BUS_WIDTH-1:0] response;
		begin
		  if (response !== `RESPONSE_OKAY) begin
			  $display("TESTBENCH ERROR! lite_response is not OKAY",
				         "\n expected = 0x%h",`RESPONSE_OKAY,
				         "\n actual   = 0x%h",response);
		    $stop;
		  end
		end
	endtask

	//------------------------------------------------------------------------
	// TEST LEVEL API: COMPARE_DATA
	//------------------------------------------------------------------------
	// Description:
	// COMPARE_DATA(expected,actual)
	// This task checks if the actual data is equal to the expected data.
	// X is used as don't care but it is not permitted for the full vector
	// to be don't care.
	//------------------------------------------------------------------------
	`define S_AXI_DATA_BUS_WIDTH 32 
	`define S_AXI_BURST_LENGTH 16 
	task automatic COMPARE_DATA;
		input [(`S_AXI_DATA_BUS_WIDTH*`S_AXI_BURST_LENGTH)-1:0]expected;
		input [(`S_AXI_DATA_BUS_WIDTH*`S_AXI_BURST_LENGTH)-1:0]actual;
		begin
			if (expected === 'hx || actual === 'hx) begin
				$display("TESTBENCH ERROR! COMPARE_DATA cannot be performed with an expected or actual vector that is all 'x'!");
		    result_slave_full = 0;
		    $stop;
		  end

			if (actual != expected) begin
				$display("TESTBENCH ERROR! Data expected is not equal to actual.",
				         "\n expected = 0x%h",expected,
				         "\n actual   = 0x%h",actual);
		    result_slave_full = 0;
		    $stop;
		  end
			else 
			begin
			   $display("TESTBENCH Passed! Data expected is equal to actual.",
			            "\n expected = 0x%h",expected,
			            "\n actual   = 0x%h",actual);
			end
		end
	endtask

	task automatic Drt_TEST;
		begin
			//---------------------------------------------------------------------
			// EXAMPLE TEST 1:
			// Simple sequential write and read burst transfers example
			// DESCRIPTION:
			// The following master code does a simple write and read burst for
			// each burst transfer type.
			//---------------------------------------------------------------------
			$display("---------------------------------------------------------");
			$display("EXAMPLE TEST Drt:");
			$display("Simple sequential write and read burst transfers example");
			$display("---------------------------------------------------------");
			
			Drt_mtestID = 1;
			Drt_mtestvector = 0;
			Drt_mtestBurstLength = 15;
			Drt_mtestAddress = `Drt_SLAVE_ADDRESS;
			Drt_mtestCacheType = 0;
			Drt_mtestProtectionType = 0;
			Drt_mtestdatasize = `Drt_MAX_DATA_SIZE;
			Drt_mtestRegion = 0;
			Drt_mtestQOS = 0;
			Drt_mtestAWUSER = 0;
			Drt_mtestARUSER = 0;
			 result_slave_full = 1;
			
			dut.`BD_INST_NAME.master_0.cdn_axi4_master_bfm_inst.WRITE_BURST_CONCURRENT(Drt_mtestID,
			                        Drt_mtestAddress,
			                        Drt_mtestBurstLength,
			                        `BURST_SIZE_4_BYTES,
			                        `BURST_TYPE_INCR,
			                        `LOCK_TYPE_NORMAL,
			                        Drt_mtestCacheType,
			                        Drt_mtestProtectionType,
			                        Drt_test_data[Drt_mtestvector],
			                        Drt_mtestdatasize,
			                        Drt_mtestRegion,
			                        Drt_mtestQOS,
			                        Drt_mtestAWUSER,
			                        Drt_v_wuser,
			                        Drt_response,
			                        Drt_mtestBUSER);
			$display("EXAMPLE TEST 1 : DATA = 0x%h, response = 0x%h",Drt_test_data[Drt_mtestvector],Drt_response);
			CHECK_RESPONSE_OKAY(Drt_response);
			Drt_mtestID = Drt_mtestID+1;
			dut.`BD_INST_NAME.master_0.cdn_axi4_master_bfm_inst.READ_BURST(Drt_mtestID,
			                       Drt_mtestAddress,
			                       Drt_mtestBurstLength,
			                       `BURST_SIZE_4_BYTES,
			                       `BURST_TYPE_WRAP,
			                       `LOCK_TYPE_NORMAL,
			                       Drt_mtestCacheType,
			                       Drt_mtestProtectionType,
			                       Drt_mtestRegion,
			                       Drt_mtestQOS,
			                       Drt_mtestARUSER,
			                       Drt_rd_data,
			                       Drt_vresponse,
			                       Drt_v_ruser);
			$display("EXAMPLE TEST 1 : DATA = 0x%h, vresponse = 0x%h",Drt_rd_data,Drt_vresponse);
			CHECK_RESPONSE_OKAY(Drt_vresponse);
			// Check that the data received by the master is the same as the test 
			// vector supplied by the slave.
			COMPARE_DATA(Drt_test_data[Drt_mtestvector],Drt_rd_data);

			$display("EXAMPLE TEST 1 : Sequential write and read FIXED burst transfers complete from the master side.");
			$display("---------------------------------------------------------");
			$display("EXAMPLE TEST Drt: PTGEN_TEST_FINISHED!");
				if ( result_slave_full ) begin				   
					$display("PTGEN_TEST: PASSED!");                 
				end	else begin                                         
					$display("PTGEN_TEST: FAILED!");                 
				end							   
			$display("---------------------------------------------------------");
		end
	endtask 

	// Create the test vectors
	initial begin
		// When performing debug enable all levels of INFO messages.
		wait(tb_ARESETn === 0) @(posedge tb_ACLK);
		wait(tb_ARESETn === 1) @(posedge tb_ACLK);
		wait(tb_ARESETn === 1) @(posedge tb_ACLK);     
		wait(tb_ARESETn === 1) @(posedge tb_ACLK);     
		wait(tb_ARESETn === 1) @(posedge tb_ACLK);  

		dut.`BD_INST_NAME.master_0.cdn_axi4_master_bfm_inst.set_channel_level_info(1);

		// Create test data vectors
		Drt_test_data[1] = 512'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
		Drt_test_data[0] = 512'h00abcdef111111112222222233333333444444445555555566666666777777778888888899999999AAAAAAAABBBBBBBBCCCCCCCCDDDDDDDDEEEEEEEEFFFFFFFF;
		Drt_test_data[2] = 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
		Drt_v_ruser = 0;
		Drt_v_wuser = 0;
	end

	// Drive the BFM
	initial begin
		// Wait for end of reset
		wait(tb_ARESETn === 0) @(posedge tb_ACLK);
		wait(tb_ARESETn === 1) @(posedge tb_ACLK);
		wait(tb_ARESETn === 1) @(posedge tb_ACLK);     
		wait(tb_ARESETn === 1) @(posedge tb_ACLK);     
		wait(tb_ARESETn === 1) @(posedge tb_ACLK);     

		Drt_TEST();

	end

endmodule
