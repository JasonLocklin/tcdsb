#let tcdsb_colors = (
  grey: rgb("#8E8E90"),
  board_maroon: rgb("#951B1E"),
  dark_maroon: rgb("#2D0026"),
  med_maroon: rgb("#BA7D6B"),
  aqua: rgb("#016567"),
  light_blue_1: rgb("#6BCAD4"),
  light_blue_2: rgb("#8EB8C2"),
)


//
// Cover page
//
#let coverpage(
  title: [],
  subtitle: [],
  season: [],
  date: [],
  dept:[],
  author: [], 
) = [
  #set page(
   footer: none,
   margin: (
      left: 0.5in,
      right: 0.5in,
      top: 1.25in,
      bottom: 0.5in,
    ),
  )

  #place(
    top + left,
    dx: -0.25in,
    dy: -1in,
      )[
        #image(
          "assets/r_a_logo.png",
          width: 2in,
          )
        ]

  #place(
    top + left,
    dx: 0in,
    dy: 1.5in,
    )[
      #text(
        size: 18pt,
        weight: 400,
        fill: black,
        )[ #season ]
      ]

  #place(
    horizon + left,
    dx: 0in,
    dy: -1in,
    )[
    #box(width: 75%)[
      #par(leading: 0.55em)[
        #text(
            size: 44pt,
            weight: 700,
            fill: black,
            )[#title]
            ]
          ]]

  #place(
    horizon + left,
    dx: 0in,
    dy: 1in,
    )[
    #box(width: 50%)[
      #par(leading: 0.55em)[
        #text(
            size: 30pt,
            weight: 400,
            fill: black,
            )[#subtitle]
            ]
          ]]

  #place(
    bottom + left,
    dx: 0in,
    dy: -1in,
    )[
  #image(
    "assets/mysp_three_lines.png",
    width: 100%
    )
    ]

  #place(
    bottom + left,
    dx: 0in,
    dy: -0.75in,
    )[
    #text(size: 14pt, fill: tcdsb_colors.board_maroon,)[#dept]
    ]


  #if author != none and author != [] [
    #place(
      bottom + left,
      dx: 0in,
      dy: -0.5in,
      )[
      #text(size: 14pt)[Produced by #author]
      ]
  ]

  #place(
    bottom + left,
    dx: 0in,
    dy: -0.25in,
    )[
    #text(size: 14pt)[#date]
    ]



  #pagebreak()
  #counter(page).update(1)
]

//
// Heading styles
//
#show heading.where(level: 1): it => block(width: 100%)[
  #set align(center)
  #set text(
    size: 20pt,
    weight: 400,
    fill: tcdsb_colors.board_maroon,
  )
  #smallcaps(it.body)
]

#show heading.where(level: 2): it => text(
  size: 16pt,
  weight: 700,
  fill: tcdsb_colors.dark_maroon,
  it.body,
)

#show heading.where(level: 3): it => text(
  size: 14pt,
  weight: 700,
  style: "italic",
  fill: tcdsb_colors.med_maroon,
  it.body,
)

//
// Main document template
//
#let tcdsb(
  title: none,
  subtitle: none,
  season: none,
  author: none,
  date: none,
  dept: none,
  margin: (x: 1in, y: 1in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: "Century Gothic",
  fontsize: 11pt,
  doc,
) = {


  set text(
    lang: lang,
    region: region,
    font: font,
    size: fontsize,
  )

  set par(
    leading: 0.8em,
  )

  set table(
    align: left,
    inset: 7pt,
    stroke: (x: none, y: 0.5pt),
  )

  if title != none {
    coverpage(
      title: title,
      subtitle: subtitle,
      season: season,
      date: date,
      dept: dept,
      author: author,
    )
  }

  show heading.where(level: 1): set text(
    weight: 300,
    size: 24pt,
  )

  show heading.where(level: 1): set block(
    width: 100%,
    below: 1em,
  )

  show heading.where(level: 2): it => {
    set block(width: 100%, below: 1em)
    block(upper(it))
  }

  show heading.where(level: 3): it => {
    set block(width: 100%, below: 1em)
    block(upper(it))
  }

  show link: underline
  show link: set underline(
    stroke: 1pt,
    offset: 2pt,
  )

  show link: set text(
    fill: tcdsb_colors.light_blue_1,
  )

  set page(
  paper: paper,
  margin: margin,
  numbering: none,
  header: align(right)[
      #text(
        size: 10pt,
        weight: 300,
        fill: tcdsb_colors.grey,
        )[#title]
      ],
  footer: grid(
    columns: (33.33%, 33.33%, 33.33%),
    align: (left, center, right),
    rows: (auto, auto),

    // Row 1: line across entire footer
    grid.cell(
      colspan: 3,
    )[
      #image(
        "assets/mysp_three_lines.png",
        width: 100%,
      )
    ],

    // Row 2, Col 1
    [
      #text(
        weight: 300,
        size: 10pt,
        fill: tcdsb_colors.grey,
      )[
        TCDSB | Research & Analytics
      ]
    ],

    // Row 2, Col 2
    [],

    // Row 2, Col 3
    [
    #text(
      weight: 300,
      size: 10pt,
      fill: tcdsb_colors.grey,
      )[
        #context counter(page).display(
          "1/1",
          both: true,
          )
        ]
      ],
      )
    )

  doc
}
