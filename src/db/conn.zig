const std = @import("std");
const spider_pg = @import("spider").pg;
const c = @cImport(@cInclude("stdlib.h"));

pub const Pool = spider_pg.Pool;

fn getEnv(key: []const u8, default: []const u8) []const u8 {
    var key_null: [256]u8 = undefined;
    @memcpy(key_null[0..key.len], key);
    key_null[key.len] = 0;
    if (c.getenv(&key_null)) |val| {
        return std.mem.sliceTo(val, 0);
    }
    return default;
}

fn getEnvInt(key: []const u8, default: u16) u16 {
    var key_null: [256]u8 = undefined;
    @memcpy(key_null[0..key.len], key);
    key_null[key.len] = 0;
    if (c.getenv(&key_null)) |val| {
        return std.fmt.parseInt(u16, std.mem.sliceTo(val, 0), 10) catch default;
    }
    return default;
}
pub fn connect(allocator: std.mem.Allocator) !Pool {
    // Valores ajustados conforme os ENVs do n8n
    const host = getEnv("POSTGRES_HOST", "postgres-main");
    const port = getEnvInt("POSTGRES_PORT", 5432);
    const user = getEnv("POSTGRES_USER", "n8n");
    const password = getEnv("POSTGRES_PASSWORD", "zivyarsql_n8n@5123");
    const database = getEnv("POSTGRES_DB", "spider_db");

    const config = spider_pg.Config{
        .host = host,
        .port = port,
        .database = database,
        .user = user,
        .password = password,
    };

    return Pool.init(allocator, config);
}
// pub fn connect(allocator: std.mem.Allocator) !Pool {
//     const host = getEnv("POSTGRES_HOST", "localhost");
//     const port = getEnvInt("POSTGRES_PORT", 5432);
//     const user = getEnv("POSTGRES_USER", "postgres");
//     const password = getEnv("POSTGRES_PASSWORD", "");
//     const database = getEnv("POSTGRES_DB", "spider_db");
//
//     const config = spider_pg.Config{
//         .host = host,
//         .port = port,
//         .database = database,
//         .user = user,
//         .password = password,
//     };
//
//     return Pool.init(allocator, config);
// }
