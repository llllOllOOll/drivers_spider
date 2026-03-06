const std = @import("std");
const spider = @import("spider");

const tmpl = @embedFile("views/index.html");

pub const DocsController = @This();

pub fn index(alc: std.mem.Allocator, _: *spider.Request) !spider.Response {
    const html = try spider.template.renderBlock(tmpl, "index", .{}, alc);
    return spider.Response.html(alc, html);
}

pub fn docRouter(alc: std.mem.Allocator, _: *spider.Request) !spider.Response {
    const html = try spider.template.renderBlock(tmpl, "doc_router", .{}, alc);
    return spider.Response.html(alc, html);
}

pub fn docWebsocket(alc: std.mem.Allocator, _: *spider.Request) !spider.Response {
    const html = try spider.template.renderBlock(tmpl, "doc_websocket", .{}, alc);
    return spider.Response.html(alc, html);
}

pub fn docPostgres(alc: std.mem.Allocator, _: *spider.Request) !spider.Response {
    const html = try spider.template.renderBlock(tmpl, "doc_postgres", .{}, alc);
    return spider.Response.html(alc, html);
}

pub fn docMetrics(alc: std.mem.Allocator, _: *spider.Request) !spider.Response {
    const html = try spider.template.renderBlock(tmpl, "doc_metrics", .{}, alc);
    return spider.Response.html(alc, html);
}

pub fn docLogger(alc: std.mem.Allocator, _: *spider.Request) !spider.Response {
    const html = try spider.template.renderBlock(tmpl, "doc_logger", .{}, alc);
    return spider.Response.html(alc, html);
}

pub fn docPooling(alc: std.mem.Allocator, _: *spider.Request) !spider.Response {
    const html = try spider.template.renderBlock(tmpl, "doc_pooling", .{}, alc);
    return spider.Response.html(alc, html);
}

pub fn docStatic(alc: std.mem.Allocator, _: *spider.Request) !spider.Response {
    const html = try spider.template.renderBlock(tmpl, "doc_static", .{}, alc);
    return spider.Response.html(alc, html);
}

pub fn docShutdown(alc: std.mem.Allocator, _: *spider.Request) !spider.Response {
    const html = try spider.template.renderBlock(tmpl, "doc_shutdown", .{}, alc);
    return spider.Response.html(alc, html);
}

pub fn docGroups(alc: std.mem.Allocator, _: *spider.Request) !spider.Response {
    const html = try spider.template.renderBlock(tmpl, "doc_groups", .{}, alc);
    return spider.Response.html(alc, html);
}

pub fn docRequest(alc: std.mem.Allocator, _: *spider.Request) !spider.Response {
    const html = try spider.template.renderBlock(tmpl, "doc_request", .{}, alc);
    return spider.Response.html(alc, html);
}
pub fn docResponse(alc: std.mem.Allocator, _: *spider.Request) !spider.Response {
    const html = try spider.template.renderBlock(tmpl, "doc_response", .{}, alc);
    return spider.Response.html(alc, html);
}
pub fn docMiddleware(alc: std.mem.Allocator, _: *spider.Request) !spider.Response {
    const html = try spider.template.renderBlock(tmpl, "doc_middleware", .{}, alc);
    return spider.Response.html(alc, html);
}
pub fn docTemplates(alc: std.mem.Allocator, _: *spider.Request) !spider.Response {
    const html = try spider.template.renderBlock(tmpl, "doc_templates", .{}, alc);
    return spider.Response.html(alc, html);
}

pub fn docDocker(alc: std.mem.Allocator, _: *spider.Request) !spider.Response {
    const html = try spider.template.renderBlock(tmpl, "doc_docker", .{}, alc);
    return spider.Response.html(alc, html);
}

pub fn docTesting(alc: std.mem.Allocator, _: *spider.Request) !spider.Response {
    const html = try spider.template.renderBlock(tmpl, "doc_testing", .{}, alc);
    return spider.Response.html(alc, html);
}
