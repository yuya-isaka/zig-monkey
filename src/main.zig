const std = @import("std");

pub fn main() !void {
    std.debug.print("hello\n", .{});
}

test "test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit();
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
