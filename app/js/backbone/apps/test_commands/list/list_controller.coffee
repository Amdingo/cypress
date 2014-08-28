@App.module "TestCommandsApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Application
    initialize: (options) ->
      { commands, runner } = options

      commandsView = @getCommandsView commands

      @listenTo commandsView, "childview:pause:clicked", (iv, args) ->
        console.warn args

      @listenTo commandsView, "childview:revert:clicked", (iv, args) ->
        command = args.model
        command.choose()
        runner.revertDom(command)

      @listenTo commandsView, "childview:command:mouseenter", (iv, args) ->
        command = args.model
        return if command.isCloned() or not command.getEl()
        runner.highlightEl(command)

      @listenTo commandsView, "childview:command:mouseleave", (iv, args) ->
        command = args.model
        return if command.isCloned() or not command.getEl()
        runner.highlightEl(command, false)

      @show commandsView

    getCommandsView: (commands) ->
      new List.Commands
        collection: commands