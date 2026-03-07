const std = @import("std");
const dpdk = @cImport({
    @cInclude("rte_eal.h");
});

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len > 1) @panic("Handling command line arguments not supported here.");
    _ = dpdk.rte_eal_init(1, @ptrCast(@alignCast(&args[0].ptr)));
    defer _ = dpdk.rte_eal_cleanup();
}
