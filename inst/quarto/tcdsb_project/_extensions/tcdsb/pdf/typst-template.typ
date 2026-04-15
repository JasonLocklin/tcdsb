// typst-template.typ
//
// TCDSB Typst PDF template
// ------------------------
// Rendering mechanics only.
// Identity comes from _brand.yml and metadata wiring in typst-show.typ.

#let tcdsb(
  title: none,
  subtitle: none,
  dept: none,
  author: none,
  date: none,
  header_content: none,
  margin: (x: 1in, y: 1in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  doc,
) = {

  set page(
    paper: paper,
    margin: margin,
    numbering: none,
    header: align(right)[ header_content ]
  )

  set text(lang: lang, region: region)

  set par(leading: 0.8em)

  set table(
    align: left,
    inset: 7pt,
    stroke: (x: none, y: 0.5pt)
  )

  show link: underline
  show link: set underline(stroke: 1pt, offset: 2pt)

  doc
}


// --- TCDSB title page -----------------------------------------------

#let tcdsb-title-page(
  title,
  subtitle,
  dept,
  author,
  date,
) = {
  page(
    margin: 0in,
    header: none,
    footer: none,
    background: image(
      "assets/title_page_background.png",
      height: 35%,
      fit: "cover"
    )
  )[
    #place(right, dy: 60pt, dx: -60pt)[
      image("assets/tcdsb_logo_maroon.png", height: 95%)
    ]

    #place(left + horizon, dy: -2in, dx: 1.25in)[
      text(size: 30pt, weight: "light", title)
    ]

    #place(left + horizon, dy: -1.5in, dx: 1.25in)[
      text(size: 26pt, weight: "light", subtitle)
    ]

    #place(left + horizon, dy: -1in, dx: 1.25in)[
      text(size: 24pt, weight: "light", dept)
    ]

    #place(left + horizon, dy: 1in, dx: 1.25in)[
      text(size: 24pt, weight: "light", date)
    ]

    #place(left + horizon, dy: 1.75in, dx: 1.25in)[
      text(size: 20pt, weight: "light", author)
    ]
  ]
}


// --- TCDSB contents page --------------------------------------------

#let tcdsb-contents-page() = {
  page(
    header: none,
    footer: none
  )[
    outline(indent: 1.5em)
  ]
}
