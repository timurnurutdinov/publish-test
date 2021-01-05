//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 1/5/21.
//

import Publish
import Plot

extension Theme where Site == PublishTest {
    static var testTheme: Self {
        Theme(htmlFactory: PublishTestHTMLFactory())
    }

    private struct PublishTestHTMLFactory: HTMLFactory {
        
        
        func makeSectionHTML(for section: Section<PublishTest>, context: PublishingContext<PublishTest>) throws -> HTML {
                HTML(
                    .head(.title("My website"), .stylesheet("styles.css")),
                    .body(.div( .h1("My website"), .p("Writing HTML in Swift is pretty great!")))
                )
        }
        
        func makePageHTML(for page: Page, context: PublishingContext<PublishTest>) throws -> HTML {
                HTML(
                    .head(.title("My website"), .stylesheet("styles.css")),
                    .body(.div( .h1("My website"), .p("Writing HTML in Swift is pretty great!")))
                )
        }
        
        func makeTagListHTML(for page: TagListPage, context: PublishingContext<PublishTest>) throws -> HTML? {
                HTML(
                    .head(.title("My website"), .stylesheet("styles.css")),
                    .body(.div( .h1("My website"), .p("Writing HTML in Swift is pretty great!")))
                )
        }
        
        func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<PublishTest>) throws -> HTML? {
                HTML(
                    .head(.title("My website"), .stylesheet("styles.css")),
                    .body(.div( .h1("My website"), .p("Writing HTML in Swift is pretty great!")))
                )
        }
        
        
        func makeIndexHTML(for index: Index, context: PublishingContext<PublishTest>) throws -> HTML {
                HTML(
                    .head(.title("My website"), .stylesheet("styles.css")),
                    .body(.div( .h1("My website"), .p("Writing HTML in Swift is pretty great!")))
                )
        }
        
        func makeItemHTML(
            for item: Item<PublishTest>,
            context: PublishingContext<PublishTest>
        ) throws -> HTML {
            HTML(
                .head(for: item, on: context.site),
                .body(
                    .ul(
                        .class("ingredients")
                    ),
                    .p(
                        "This will take around ",
                        "minutes to prepare"
                    ),
                    .contentBody(item.body)
                )
            )
        }
        
    }
}
