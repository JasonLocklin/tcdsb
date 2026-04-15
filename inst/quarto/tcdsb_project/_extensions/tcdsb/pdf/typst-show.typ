// typst-show.typ
//
// TCDSB Typst show rules
// ---------------------
// This file defines *element display mechanics only*.
// No colours, fonts, logos, branding, or content belong here.

// Metadata for title page
#show: doc => tcdsb(
  title: metadata("title"),
  subtitle: metadata("subtitle"),
  dept: metadata("dept"),
  author: metadata("author"),
  date: metadata("date"),
  header_content: metadata("title"),

  doc,
)

// Headings: spacing and block behavior only
#show heading.where(level: 1): it => {
  set block(width: 100%, below: 1em)
  it
}

#show heading.where(level: 2): it => {
  set block(width: 100%, below: 0.75em)
  it
}

#show heading.where(level: 3): it => {
  set block(width: 100%, below: 0.5em)
  it
}

// Figures: allow page breaking
#show figure: set block(breakable: true)

// Tables: allow multi-page tables
#show table: set block(breakable: true)

// Lists: consistent spacing
#show list: set block(below: 0.75em)

// Block quotes: spacing only
#show quote: set block(above: 0.75em, below: 0.75em)
