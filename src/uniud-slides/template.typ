// Presentation slides templarte for the University of Udine (UniUD)
// Author: Davide Della Giustina
// Date: 02/2024

// This template uses [Polylux](https://github.com/andreasKroepelin/polylux) to render slides
#import "@preview/polylux:0.4.0" as polylux

// Main configuration function
// Usually, it should be used with `#show`
#let uniud-slides(
    lang: "en",
    department: "dmif",
    department-override: "",
    course: "Computer Science",
    academic-year: "2023-24",
    date: datetime.today(),
    title: "Presentation Title",
    subtitle: "",
    candidate: (
        name: "Mario Rossi",
    ),
    supervisor: (
        title: "Prof.",
        name: "Carlo Bianchi",
    ),
    co-supervisor: (
        title: "Dott.",
        name: "",
    ),
    body,
) = {

    // +---------------------+
    // | Argument validation |
    // +---------------------+

    let supported-languages = ("en", "it")
    if lang not in supported-languages {
        panic("unsupported language")
    }

    let supported-departments = ("dmed", "dill", "di4a", "dies", "disg", "dmif", "dium", "dpia")
    if department-override == "" {
        if department not in supported-departments {
            panic("unsupported department")
        }
    }

    // +---------+
    // | Strings |
    // +---------+

    let course-desc = if lang == "en" { "Degree course in" }
        else if lang == "it" { "Corso di laurea in" }

    let candidate-desc = if lang == "en" { "Candidate" }
        else if lang == "it" { "Candidato" }

    let supervisor-desc = if lang == "en" { "Supervisor" }
        else if lang == "it" { "Relatore" }

    let co-supervisor-desc = if lang == "en" { "Co-supervisor" }
        else if lang == "it" { "Correlatore" }

    let academic-year-desc = if lang == "en" { "Academic year" }
        else if lang == "it" { "Anno accademico" }

    let department-desc = if department-override != "" { department-override }
        else if department == "dmed" {
            if lang == "en" { "Department of Medicine" }
            else if lang == "it" { "Dipartimento di Medicina" }
        } else if department == "dill" {
            if lang == "en" { "Department of Languages and Literatures, Communication, Education and Society" }
            else if lang == "it" { "Dipartimento di Lingue e Letterature, Comunicazione, Formazione e Società" }
        } else if department == "di4a" {
            if lang == "en" { "Department of Agricultural, Food, Environmental and Animal Sciences" }
            else if lang == "it" { "Dipartimento di Scienze Agroalimentari, Ambientali e Animali" }
        } else if department == "dies" {
            if lang == "en" { "Department of Economics and Statistics" }
            else if lang == "it" { "Dipartimento di Scienze Economiche e Statistiche" }
        } else if department == "disg" {
            if lang == "en" { "Department of Legal Studies" }
            else if lang == "it" { "Dipartimento di Scienze Giuridiche" }
        } else if department == "dmif" {
            if lang == "en" { "Department of Mathematics, Computer Science and Physics" }
            else if lang == "it" { "Dipartimento di Scienze Matematiche, Informatiche e Fisiche" }
        } else if department == "dium" {
            if lang == "en" { "Department of Humanities and Cultural Heritage" }
            else if lang == "it" { "Dipartimento di Studi Umanistici e del Patrimonio Culturale" }
        } else if department == "dpia" {
            if lang == "en" { "Polytechnic Department of Engineering and Architecture" }
            else if lang == "it" { "Dipartimento Politecnico di Ingegneria e Architettura" }
        }

    // +-------------------+
    // | Document settings |
    // +-------------------+

    let title-raw = title.replace("\n", " ")
    let subtitle-raw = subtitle.replace("\n", " ")

    let uniud-banner = align(center + top, {
        let banner = "./assets/images/banner.svg"
        image(banner, width: 100%)
    })

    let in-banner(body) = place(
        center + top,
        dx: 233pt,
        rect(
            width: 100%, height: 89pt,
            stroke: none,
            align(left + horizon, text(
                size: 13pt,
                fill: white,
                body,
            )),
        ),
    )

    let department-in-banner = in-banner(upper(department-desc))
    let thesis-data-in-banner = in-banner[
        #upper(title-raw) \
        #candidate.name --- #date.display("[day]/[month]/[year]")
    ]

    set document(
        title: title-raw + if subtitle != "" { " -- " + subtitle-raw },
        author: candidate.name,
        date: auto,
    )

    set page(
        paper: "presentation-16-9",
        background: uniud-banner + department-in-banner,
        margin: (top: 118pt, bottom: 30pt),
    )

    set text(
        font: "atkinson hyperlegible",
        size: 20pt,
        lang: lang,
    )

    // +---------+
    // | Content |
    // +---------+

    // Title slide
    polylux.slide({
        set align(center + top)

        // Degree course
        text(
            size: 20pt,
            emph[#course-desc #course],
        )

        set align(center + horizon)
        v(-.8cm)

        // Title
        text(size: 25pt)[= #title]
        text(size: 23pt, {
            if subtitle != "" { subtitle + v(.1cm) }
            else { v(1em) }
        })

        // Authors
        table(
            stroke: none,
            columns: (42%, 42%),
            align: (left, right),
            text(size: 18pt, upper[#candidate-desc:]), text(size: 18pt, upper[#supervisor-desc:]),
            text(size: 20pt, candidate.name), text(size: 20pt)[#supervisor.title #supervisor.name],
        )
        if co-supervisor.name != "" {
            v(-.7em)
            table(
                stroke: none,
                columns: (42%, 42%),
                align: (left, right),
                [], text(size: 18pt, upper[#co-supervisor-desc:]),
                [], text(size: 20pt)[#co-supervisor.title #co-supervisor.name],
            )
        }

        set align(center + bottom)

        // Academic year
        text(
            size: 18pt,
            fill: gray,
            emph[#academic-year-desc #academic-year],
        )
    })

    // Update page style for following slides
    set page(background: uniud-banner + thesis-data-in-banner)

    // Content
    body
}

// Function that creates a new slide
// Basically, a bare wrapper for `#polylux-slide` with added page number
#let slide(body) = {
    polylux.slide()[
        #place(bottom + right, dx: 37pt, dy: 10pt,
            text(size: 12pt)[
                #polylux.toolbox.slide-number / #polylux.toolbox.last-slide-number
            ],
        )
        #body
    ]
}
