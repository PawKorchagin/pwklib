#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge

#let pr = math.partial
#let d = math.dif
#let limt(x, to) = $lim_(#x -> #to)$
#let where(x) = text(baseline: 5pt, size: 7pt)[#x]

#let lxyt(x, y, z) = $lim_((x, y, z) -> (#x, #y, #z))$

#let prf(f, x) = $(#pr #f) / (#pr #x)$
#let prt(x) = $(#pr f) / (#pr #x)$
#let ev(val) = $#rotate(90deg)[$ " "#rotate(90deg)[#val] = " "$]$
#let the = math.supset.sq

#let box-colors = (
  default: (stroke: luma(70), fill: white, title: white),
  red: (stroke: rgb(237, 32, 84), fill: rgb(253, 228, 224), title: white),
  green: (stroke: rgb(102, 174, 62), fill: rgb(235, 244, 222), title: white),
  blue: (stroke: rgb(29, 144, 208), fill: rgb(232, 246, 253), title: white),
)

#let colorbox(
  title: none,
  box-colors: box-colors,
  color: "default",
  radius: 2pt,
  width: auto,
  body,
) = {
  return block(
    fill: box-colors.at(color).fill,
    stroke: 2pt + box-colors.at(color).stroke,
    radius: radius,
    width: width,
  )[
    #if title != none [
      #block(
        fill: box-colors.at(color).stroke,
        inset: 8pt,
        radius: (top-left: radius, bottom-right: radius),
      )[
        #text(fill: box-colors.at(color).title, weight: "bold")[#title]
      ]
    ]

    #block(
      width: 100%,
      inset: (x: 8pt, bottom: 8pt, top: if title == none { 8pt } else { 0pt }),
    )[
      #body
    ]
  ]
}

#let slanted-colorbox(
  title: "Title",
  box-colors: box-colors,
  color: "default",
  radius: 2pt,
  width: auto,
  body
) = {
  let slanted-background(color: black, body) = {
    set text(fill: white, weight: "bold")
    style(styles => {
      let size = measure(body, styles)
      let inset = 8pt
      [#block()[
          #polygon(
            fill: color,
            (0pt, 0pt),
            (0pt, size.height + (2 * inset)),
            (size.width + (2 * inset), size.height + (2 * inset)),
            (size.width + (2 * inset) + 6pt, 0cm),
          )
          #place(center + top, dy: size.height, dx: -3pt)[#body]
        ]]
    })
  }

  return block(
    fill: box-colors.at(color).fill,
    stroke: 2pt + box-colors.at(color).stroke,
    radius: radius,
    width: width,
  )[
    #slanted-background(color: box-colors.at(color).stroke)[#title]
    #block(width: 100%, inset: (top: -2pt, x: 10pt, bottom: 10pt))[
      #body
    ]
  ]
}

#let outline-colorbox(
  title: "Title",
  box-colors: box-colors,
  color: "default",
  width: 100%,
  radius: 2pt,
  centering: false,
  body,
) = {
  return block(
    fill: box-colors.at(color).fill,
    stroke: 2pt + box-colors.at(color).stroke,
    radius: radius,
    width: width,
    above: 26pt,
  )[
    #if centering [
      #place(top + center, dy: -12pt)[
        #block(fill: box-colors.at(color).stroke, inset: 8pt, radius: radius)[
          #text(fill: white, weight: "bold")[#title]
        ]
      ]
    ] else [
      #place(top + start, dy: -12pt, dx: 20pt)[
        #block(fill: box-colors.at(color).stroke, inset: 8pt, radius: radius)[
          #text(fill: white, weight: "bold")[#title]
        ]
      ]
    ]

    #block(width: 100%, inset: (top: 20pt, x: 10pt, bottom: 10pt))[
      #body
    ]
  ]
}

#let stickybox(rotation: 0deg, width: 100%, body) = {
  let stickyYellow = rgb(255, 240, 172)

  return rotate(
    rotation,
  )[
    #let shadow = 100%
    #if width != 100% {
      shadow = width
    }
    #place(
      bottom + center,
      dy: if type(width) == ratio { 0.2 * shadow } else { 0.05 * shadow },
    )[
      #image("background.svg", width: shadow - 3mm)
    ]
    #block(
      fill: stickyYellow,
      width: width,
    )[
      #place(
        top + center,
        dy: -2mm,
      )[
        #image(
          "tape.svg",
          width: if type(width) == ratio { calc.clamp(width * 0.35cm / 1cm, 1, 4) * 1cm } else { calc.clamp(width * 0.35 / 1cm, 1, 4) * 1cm },
          height: 4mm,
        )
      ]
      #block(width: 100%, inset: (top: 12pt, x: 8pt, bottom: 8pt))[
        #body
      ]
    ]
  ]
}

#let fig1 = {
    // text()[figure 1]
    diagram(cell-size: 15pt, {
        let (s, m1, m2, p) = (
            (0, 0),
            (0, -1),
            (1, 0),
            (1, -1)
          )
        node(s, $S$)
        node(m1, $M$)
        node(m2, $M$)
        node(p, $P$)

        edge(p, m1, "-")
        edge(m1, m2, "-")
        edge(m2, s, "-")
    })
}

#let fig2 = {
    diagram(cell-size: 15pt, {
        let (s, m1, m2, p) = (
            (0, 0),
            (1, -1),
            (1, 0),
            (0, -1)
          )
        node(s, $S$)
        node(m1, $M$)
        node(m2, $M$)
        node(p, $P$)

        edge(p, m1, "-")
        edge(m1, m2, "-")
        edge(m2, s, "-")

    })
}

#let fig3 = {
    diagram(cell-size: 15pt, {
        let (s, m1, m2, p) = (
            (1, 0),
            (0, -1),
            (0, 0),
            (1, -1)
          )
        node(s, $S$)
        node(m1, $M$)
        node(m2, $M$)
        node(p, $P$)

        edge(p, m1, "-")
        edge(m1, m2, "-")
        edge(m2, s, "-")

    })
}

#let fig4 = {
    diagram(cell-size: 15pt, {
        let (s, m1, m2, p) = (
            (1, 0),
            (1, -1),
            (0, 0),
            (0, -1)
          )
        node(s, $S$)
        node(m1, $M$)
        node(m2, $M$)
        node(p, $P$)

        edge(p, m1, "-")
        edge(m1, m2, "-")
        edge(m2, s, "-")

    })
}


#let syllogism(a, b, c) = {
    // v(0.5pt)
    block(
        // height: 5pt,
        width: 75pt,
        // height: cm,
        // spacing: 1pt,
        // breakable: false,
        [
        // #v(0.1pt)
        #a #h(1fr) #b
        // #v(0.1pt)
        // #a, #b
        #layout(size => line(length: size.width, stroke: 1pt))
        #align(center, c)
        // #v(0.1pt)
        ]
    )
}


#let syllogism_large(a, b, c) = {
    block(
        width: 150pt,
        spacing: 1em,
        breakable: false,
        [
        #a #h(1fr) #b
        #layout(size => line(length: size.width))
        #align(center, c)
        ]
    )
}


#let def = "Определение"

#let def(x) = {x
 " Определение"}

#let limxy(a, b) = $lim_((x, y) -> (#a, #b))$

#let plim = $lim_(r->0)$

#let so = $#line(angle: 90deg) =>$

#let bc(op, th) = $ limits(#op)_(#th) $
