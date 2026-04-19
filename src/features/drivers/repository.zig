const std = @import("std");
const spider = @import("spider");
const db = spider.pg;
const model = @import("model.zig");

pub fn findAll(alloc: std.mem.Allocator) ![]model.Driver {
    const sql = "SELECT id, name, team, number FROM drivers ORDER BY number";
    return try db.query(model.Driver, alloc, sql, .{});
}

pub fn findById(alloc: std.mem.Allocator, id: i32) !?model.Driver {
    const sql = "SELECT id, name, team, number FROM drivers WHERE id = $1 LIMIT 1";
    return try db.queryOne(model.Driver, alloc, sql, .{id});
}
