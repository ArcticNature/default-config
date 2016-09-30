--[[
  Snow Fox uses LUA for these configuration files.

  While it is a little unusual if you never used a programming language before
  bare with me, you will see the advantages of it.
  For more information about LUA you can visit http://www.lua.org/.

  First of all keep in mind that blocks like this one and lines starting with
  a double dash (--) are comments and will be ignored.
  Secondly, the configuration files are loaded and run in a tailored
  environment so not all default LUA functions are available and others are
  provided.

  Consider now the code below this comment.
  This aims at being the typical syntax of configuration files so it is
  explained in detail.

  Most configurations are passed through inline LUA tables.
  These tables are defined inside a block surrounded by curly
  brakets (`{` and `}`) and contain a comma (`,`) separated list of
  `Key = Value` pairs.

  The value assigned to the options are picked from global objects that
  allow access to the avaliable features.

  `core` options apply to fundamental aspects of the system.
  Attributes of this table are fixed by the documentation.

  `connectors` are the interface to managed servces.
  Attributes of this table are the names of the collectors to configure.
  The mapped tables are passed to the connector's configurator.
]]

-- Core system configuration.
core.event_manager = event_managers.epoll
core.logger = loggers.console {
  format = "${<log-group>} ${level} ${<now>} ${file} -> L${line} ==> ${message}",
  level  = loggers.ERROR
}

-- Configure events sources used internally by the system ...
core.events_from(sources.scheduler {
  tick = 1
})

-- ... end event sources used to interact with it.
core.events_from(sources.unix {
  path = "/tmp/snow-fox.socket"
})
core.events_from(sources.tcp {
  bind = "0.0.0.0",
  port = 2351
})

-- Connectors configuration.
-- local is a LUA keyword so we cannot use the dot notation.
connectors["local"] = {}
connectors.docker = {
  path = "/var/run/docker.sock"
}
