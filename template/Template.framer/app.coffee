
{ Preview } = require "PreviewComponent"
{ FlowView, NavigationView, ModalView } = require "NavigationComponent"
{ Button } = require "Buttons"

screen = new Layer { width: 375, height: 812 }
preview = new Preview { view: screen }

flow = new FlowView { parent: screen }
homeView = new NavigationView { parent: flow, backgroundColor: "white", showBack: false }

box = new Button { parent: homeView.content, borderRadius: 44, handler: () -> @backgroundColor = Utils.randomColor() }
box.center()