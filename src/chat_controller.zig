const std = @import("std");
const spider = @import("spider");

const tmpl = @embedFile("views/chat.html");

pub const ChatController = @This();

pub fn chatPage(alc: std.mem.Allocator, _: *spider.Request) !spider.Response {
    const html = try spider.template.renderBlock(tmpl, "chat", .{}, alc);
    return spider.Response.html(alc, html);
}
