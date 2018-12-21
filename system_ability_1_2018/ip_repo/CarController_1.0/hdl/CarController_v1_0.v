
`timescale 1 ns / 1 ps

	module CarController_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface Drt
		parameter integer C_Drt_ID_WIDTH	= 1,
		parameter integer C_Drt_DATA_WIDTH	= 32,
		parameter integer C_Drt_ADDR_WIDTH	= 6,
		parameter integer C_Drt_AWUSER_WIDTH	= 0,
		parameter integer C_Drt_ARUSER_WIDTH	= 0,
		parameter integer C_Drt_WUSER_WIDTH	= 0,
		parameter integer C_Drt_RUSER_WIDTH	= 0,
		parameter integer C_Drt_BUSER_WIDTH	= 0
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface Drt
		input wire  drt_aclk,
		input wire  drt_aresetn,
		input wire [C_Drt_ID_WIDTH-1 : 0] drt_awid,
		input wire [C_Drt_ADDR_WIDTH-1 : 0] drt_awaddr,
		input wire [7 : 0] drt_awlen,
		input wire [2 : 0] drt_awsize,
		input wire [1 : 0] drt_awburst,
		input wire  drt_awlock,
		input wire [3 : 0] drt_awcache,
		input wire [2 : 0] drt_awprot,
		input wire [3 : 0] drt_awqos,
		input wire [3 : 0] drt_awregion,
		input wire [C_Drt_AWUSER_WIDTH-1 : 0] drt_awuser,
		input wire  drt_awvalid,
		output wire  drt_awready,
		input wire [C_Drt_DATA_WIDTH-1 : 0] drt_wdata,
		input wire [(C_Drt_DATA_WIDTH/8)-1 : 0] drt_wstrb,
		input wire  drt_wlast,
		input wire [C_Drt_WUSER_WIDTH-1 : 0] drt_wuser,
		input wire  drt_wvalid,
		output wire  drt_wready,
		output wire [C_Drt_ID_WIDTH-1 : 0] drt_bid,
		output wire [1 : 0] drt_bresp,
		output wire [C_Drt_BUSER_WIDTH-1 : 0] drt_buser,
		output wire  drt_bvalid,
		input wire  drt_bready,
		input wire [C_Drt_ID_WIDTH-1 : 0] drt_arid,
		input wire [C_Drt_ADDR_WIDTH-1 : 0] drt_araddr,
		input wire [7 : 0] drt_arlen,
		input wire [2 : 0] drt_arsize,
		input wire [1 : 0] drt_arburst,
		input wire  drt_arlock,
		input wire [3 : 0] drt_arcache,
		input wire [2 : 0] drt_arprot,
		input wire [3 : 0] drt_arqos,
		input wire [3 : 0] drt_arregion,
		input wire [C_Drt_ARUSER_WIDTH-1 : 0] drt_aruser,
		input wire  drt_arvalid,
		output wire  drt_arready,
		output wire [C_Drt_ID_WIDTH-1 : 0] drt_rid,
		output wire [C_Drt_DATA_WIDTH-1 : 0] drt_rdata,
		output wire [1 : 0] drt_rresp,
		output wire  drt_rlast,
		output wire [C_Drt_RUSER_WIDTH-1 : 0] drt_ruser,
		output wire  drt_rvalid,
		input wire  drt_rready
	);
// Instantiation of Axi Bus Interface Drt
	CarController_v1_0_Drt # ( 
		.C_S_AXI_ID_WIDTH(C_Drt_ID_WIDTH),
		.C_S_AXI_DATA_WIDTH(C_Drt_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_Drt_ADDR_WIDTH),
		.C_S_AXI_AWUSER_WIDTH(C_Drt_AWUSER_WIDTH),
		.C_S_AXI_ARUSER_WIDTH(C_Drt_ARUSER_WIDTH),
		.C_S_AXI_WUSER_WIDTH(C_Drt_WUSER_WIDTH),
		.C_S_AXI_RUSER_WIDTH(C_Drt_RUSER_WIDTH),
		.C_S_AXI_BUSER_WIDTH(C_Drt_BUSER_WIDTH)
	) CarController_v1_0_Drt_inst (
		.S_AXI_ACLK(drt_aclk),
		.S_AXI_ARESETN(drt_aresetn),
		.S_AXI_AWID(drt_awid),
		.S_AXI_AWADDR(drt_awaddr),
		.S_AXI_AWLEN(drt_awlen),
		.S_AXI_AWSIZE(drt_awsize),
		.S_AXI_AWBURST(drt_awburst),
		.S_AXI_AWLOCK(drt_awlock),
		.S_AXI_AWCACHE(drt_awcache),
		.S_AXI_AWPROT(drt_awprot),
		.S_AXI_AWQOS(drt_awqos),
		.S_AXI_AWREGION(drt_awregion),
		.S_AXI_AWUSER(drt_awuser),
		.S_AXI_AWVALID(drt_awvalid),
		.S_AXI_AWREADY(drt_awready),
		.S_AXI_WDATA(drt_wdata),
		.S_AXI_WSTRB(drt_wstrb),
		.S_AXI_WLAST(drt_wlast),
		.S_AXI_WUSER(drt_wuser),
		.S_AXI_WVALID(drt_wvalid),
		.S_AXI_WREADY(drt_wready),
		.S_AXI_BID(drt_bid),
		.S_AXI_BRESP(drt_bresp),
		.S_AXI_BUSER(drt_buser),
		.S_AXI_BVALID(drt_bvalid),
		.S_AXI_BREADY(drt_bready),
		.S_AXI_ARID(drt_arid),
		.S_AXI_ARADDR(drt_araddr),
		.S_AXI_ARLEN(drt_arlen),
		.S_AXI_ARSIZE(drt_arsize),
		.S_AXI_ARBURST(drt_arburst),
		.S_AXI_ARLOCK(drt_arlock),
		.S_AXI_ARCACHE(drt_arcache),
		.S_AXI_ARPROT(drt_arprot),
		.S_AXI_ARQOS(drt_arqos),
		.S_AXI_ARREGION(drt_arregion),
		.S_AXI_ARUSER(drt_aruser),
		.S_AXI_ARVALID(drt_arvalid),
		.S_AXI_ARREADY(drt_arready),
		.S_AXI_RID(drt_rid),
		.S_AXI_RDATA(drt_rdata),
		.S_AXI_RRESP(drt_rresp),
		.S_AXI_RLAST(drt_rlast),
		.S_AXI_RUSER(drt_ruser),
		.S_AXI_RVALID(drt_rvalid),
		.S_AXI_RREADY(drt_rready)
	);

	// Add user logic here

	// User logic ends

	endmodule
