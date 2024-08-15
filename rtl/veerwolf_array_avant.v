// SPDX-License-Identifier: Apache-2.0
// Copyright 2019 Western Digital Corporation or its affiliates.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//********************************************************************************
// $Id$
//
// Function: VeeRwolf toplevel for Lattice Avant E-Series
// Comments:
//
//********************************************************************************

`default_nettype none
module veerwolf_array_avant
  #(parameter bootrom_file = "array_rom.vh",
    parameter cpu_type = "EL2")
   (input wire 	       clk,
    input wire 	       rstn,
    input wire 	       i_uart_rx,
    output wire        o_uart_tx,
    input wire [15:0]  i_sw,
    output reg [15:0]  o_led);

   wire [63:0] 	       gpio_out;
   reg [15:0] 	       led_int_r;

   wire 	 clk_core;
   wire 	 rst_core;

   reg    rst_reg1;
   reg    rst_reg2;

   assign rst_core = rst_reg2;
   assign clk_core = clk;

   // ================================================================
   // Synchronize Reset
   // ================================================================
   always @(posedge clk) begin
    if (!rstn) begin
      rst_reg1 <= 1'b1;
      rst_reg2 <= 1'b1;
    end else begin
      rst_reg1 <= 1'b0;
      rst_reg2 <= rst_reg1;
    end
   end

   veerwolf_array
     #(.array_code (bootrom_file))
   veerwolfs
    (.clk_core (clk_core),
     .rst_core (rst_core),
     .i_uart_rx (i_uart_rx),
     .o_uart_tx (o_uart_tx),
     .i_sw (i_sw),
     .o_led (o_led));

endmodule
