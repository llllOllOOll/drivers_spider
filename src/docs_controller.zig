const std = @import("std");
const spider = @import("spider");

pub const DocsController = @This();

fn renderDoc(alc: std.mem.Allocator, req: *spider.Request, layout: []const u8, view: []const u8) !spider.Response {
    const is_boosted = req.headers.get("HX-Boosted") != null;
    const is_htmx = req.headers.get("HX-Request") != null;

    if (is_htmx and !is_boosted) {
        const html = try spider.template.renderBlock(view, "content", .{}, alc);
        return spider.Response.html(alc, html);
    }

    const tmpl = try std.mem.concat(alc, u8, &.{ layout, view });
    defer alc.free(tmpl);
    const html = try spider.template.renderBlock(tmpl, "layout_docs", .{}, alc);
    return spider.Response.html(alc, html);
}

pub fn docs(alc: std.mem.Allocator, req: *spider.Request) !spider.Response {
    return renderDoc(alc, req, @embedFile("views/layout_docs.html"), @embedFile("views/docs/quickstart.html"));
}

pub fn docQuickstart(alc: std.mem.Allocator, req: *spider.Request) !spider.Response {
    return renderDoc(alc, req, @embedFile("views/layout_docs.html"), @embedFile("views/docs/quickstart.html"));
}

pub fn docRouter(alc: std.mem.Allocator, req: *spider.Request) !spider.Response {
    return renderDoc(alc, req, @embedFile("views/layout_docs.html"), @embedFile("views/docs/router.html"));
}

pub fn docRequest(alc: std.mem.Allocator, req: *spider.Request) !spider.Response {
    return renderDoc(alc, req, @embedFile("views/layout_docs.html"), @embedFile("views/docs/request.html"));
}

pub fn docResponse(alc: std.mem.Allocator, req: *spider.Request) !spider.Response {
    return renderDoc(alc, req, @embedFile("views/layout_docs.html"), @embedFile("views/docs/response.html"));
}

pub fn docMiddleware(alc: std.mem.Allocator, req: *spider.Request) !spider.Response {
    return renderDoc(alc, req, @embedFile("views/layout_docs.html"), @embedFile("views/docs/middleware.html"));
}

pub fn docGroups(alc: std.mem.Allocator, req: *spider.Request) !spider.Response {
    return renderDoc(alc, req, @embedFile("views/layout_docs.html"), @embedFile("views/docs/groups.html"));
}

pub fn docPostgres(alc: std.mem.Allocator, req: *spider.Request) !spider.Response {
    return renderDoc(alc, req, @embedFile("views/layout_docs.html"), @embedFile("views/docs/postgres.html"));
}

pub fn docPooling(alc: std.mem.Allocator, req: *spider.Request) !spider.Response {
    return renderDoc(alc, req, @embedFile("views/layout_docs.html"), @embedFile("views/docs/pooling.html"));
}

pub fn docWebsocket(alc: std.mem.Allocator, req: *spider.Request) !spider.Response {
    return renderDoc(alc, req, @embedFile("views/layout_docs.html"), @embedFile("views/docs/websocket.html"));
}

pub fn docTemplates(alc: std.mem.Allocator, req: *spider.Request) !spider.Response {
    return renderDoc(alc, req, @embedFile("views/layout_docs.html"), @embedFile("views/docs/templates.html"));
}

pub fn docStatic(alc: std.mem.Allocator, req: *spider.Request) !spider.Response {
    return renderDoc(alc, req, @embedFile("views/layout_docs.html"), @embedFile("views/docs/static.html"));
}

pub fn docMetrics(alc: std.mem.Allocator, req: *spider.Request) !spider.Response {
    return renderDoc(alc, req, @embedFile("views/layout_docs.html"), @embedFile("views/docs/metrics.html"));
}

pub fn docLogger(alc: std.mem.Allocator, req: *spider.Request) !spider.Response {
    return renderDoc(alc, req, @embedFile("views/layout_docs.html"), @embedFile("views/docs/logger.html"));
}

pub fn docShutdown(alc: std.mem.Allocator, req: *spider.Request) !spider.Response {
    return renderDoc(alc, req, @embedFile("views/layout_docs.html"), @embedFile("views/docs/shutdown.html"));
}

pub fn docAuth(alc: std.mem.Allocator, req: *spider.Request) !spider.Response {
    return renderDoc(alc, req, @embedFile("views/layout_docs.html"), @embedFile("views/docs/auth.html"));
}

pub fn docHttpClient(alc: std.mem.Allocator, req: *spider.Request) !spider.Response {
    return renderDoc(alc, req, @embedFile("views/layout_docs.html"), @embedFile("views/docs/http_client.html"));
}

pub fn docForms(alc: std.mem.Allocator, req: *spider.Request) !spider.Response {
    return renderDoc(alc, req, @embedFile("views/layout_docs.html"), @embedFile("views/docs/forms.html"));
}

pub fn docDocker(alc: std.mem.Allocator, req: *spider.Request) !spider.Response {
    return renderDoc(alc, req, @embedFile("views/layout_docs.html"), @embedFile("views/docs/docker.html"));
}

pub fn docTesting(alc: std.mem.Allocator, req: *spider.Request) !spider.Response {
    return renderDoc(alc, req, @embedFile("views/layout_docs.html"), @embedFile("views/docs/testing.html"));
}
