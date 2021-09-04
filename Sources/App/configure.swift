import Vapor
import Leaf
import FluentPostgresDriver
import Fluent
import FluentKit

// configures your application
public func configure(_ app: Application) throws {
    app.views.use(.leaf)
    app.leaf.cache.isEnabled = app.environment.isRelease
    app.leaf.tags["isEven"] = IsEvenTag()
    app.leaf.tags["dateFormat"] = DateFormatTag()
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(
        .postgres(
            hostname: Environment.get("DATABASE_HOST") ?? "localhost",
            port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
            username: Environment.get("DATABASE_USERNAME") ?? "vapor",
            password: Environment.get("DATABASE_PASSWORD") ?? "password",
            database: Environment.get("DATABASE_NAME") ?? "vapor"
        ), as: .psql)

    app.http.server.configuration.port = Environment.get("SERVER_PORT").toInt(or: 9090)

    // register routes
    try routes(app)
}
