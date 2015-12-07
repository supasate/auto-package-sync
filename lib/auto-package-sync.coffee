AutoPackageSyncView = require './auto-package-sync-view'
{CompositeDisposable} = require 'atom'

module.exports = AutoPackageSync =
  autoPackageSyncView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @autoPackageSyncView = new AutoPackageSyncView(state.autoPackageSyncViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @autoPackageSyncView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'auto-package-sync:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @autoPackageSyncView.destroy()

  serialize: ->
    autoPackageSyncViewState: @autoPackageSyncView.serialize()

  toggle: ->
    console.log 'AutoPackageSync was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
