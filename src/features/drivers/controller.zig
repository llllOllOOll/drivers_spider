const std = @import("std");
const spider = @import("spider");
const repository = @import("repository.zig");

pub fn index(alloc: std.mem.Allocator, _: *spider.Request) !spider.Response {
    const drivers = try repository.findAll(alloc);
    return spider.Response.json(alloc, drivers);
}
