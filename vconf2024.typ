// vconf2024.typ

#let to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(to-string).join("")
  } else if content.has("body") {
    to-string(content.body)
  } else if content == [ ] {
    " "
  }
}

#let conf(
  title: "",
  authors: (),
  affiliations: none,
  abstract: [],
  bibliography-file: none,
  body
) = {
  // Document setup
  // set document(author: authors.map(a => to-string(a.name)), title: title) // 著者情報のメタデータを埋め込みたい場合はコメントアウト 
  set page(
    paper: "a4",
    margin: (top: 12.7mm, bottom: 12.7mm, left: 12.7mm, right: 12.7mm),
    numbering: none,
  )
  // Font settings
  set text(font: "YuMincho", size: 10pt, lang: "ja")

  set heading(numbering: "1.1.")
  
  // Title block
  align(center)[
    #text(weight: 700, size: 18pt, title)
    #v(12pt, weak: true)
    #text(size: 10pt)[
      #authors.map(author => [
        #author.name
        (#author.contact)
      ]).join([, ])
    ]
    #v(10pt, weak: true)
    #if affiliations != none {
      text(size: 10pt)[
        #affiliations.join([, ])
      ]
    }
    #v(6pt, weak: true)
  ]

  // Abstract
  block(width: 100%, inset: 10pt, breakable: false, [
    #set par(justify: true)
    *概要：* #abstract
  ])
  v(12pt, weak: true)

  // Main body
  set par(justify: true)
  columns(2, gutter: 12pt, body)
  

  v(12pt)
  // Bibliography
  if bibliography-file != none {
    show bibliography: set text(lang: "en")
    columns(2, gutter: 5pt, 
      bibliography(bibliography-file, title: "参考文献", style: "ieee")
    )
  }
}

// Custom show rules
#let rules = state("rules", (
  heading: it => {
    set block(below: 0.5em)
    set text(weight: "bold")
    it
  },
  figure: it => {
    set align(center)
    set par(justify: true)
    it
  }
))
