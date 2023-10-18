
{ Preview } = require "PreviewComponent"
{ NavigationComponent } = require "NavigationComponent"
{ Button } = require "Buttons"

screen = new Layer { width: 393, height: 852 }
preview = new Preview { view: screen, showUI: false }

flow = new NavigationComponent { parent: screen, width: screen.width, height: screen.height }
homeView = flow.createView("white")