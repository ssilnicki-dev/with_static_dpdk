const std = @import("std");
const dpdk = @import("dpdk.zig");

pub fn main(init: std.process.Init) !void {
    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    var args = try init.minimal.args.iterateAllocator(allocator);
    defer args.deinit();
    var argv0 = args.next();

    _ = dpdk.rte_eal_init(1, @ptrCast(@alignCast(&argv0.?.ptr)));
    defer _ = dpdk.rte_eal_cleanup();
}
