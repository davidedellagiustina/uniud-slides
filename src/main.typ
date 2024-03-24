// Usage example of the uniud-slides template
// File: ./src/main.typ

#import "./uniud-slides/template.typ": *

// +-----------------------+
// | Presentation metadata |
// +-----------------------+

#show: uniud-slides.with(
    lang: "en", // Supported: 'en', 'it'
    department: "dmif", // Supported: 'dmed', 'dill', 'di4a', 'dies', 'disg', 'dmif', 'dium', 'dpia'
    department-override: "", // Optional, overrides `department` (if yours is unsupported or you prefer a custom text)
    course: "Computer Science",
    academic-year: "2023-24",
    date: datetime(day: 15, month: 3, year: 2024), // Date of the presentation
    title: "My Awesome Presentation",
    subtitle: "", // Optional
    candidate: (
        name: "Mario Rossi",
    ),
    supervisor: (
        title: "Prof.",
        name: "Carlo Bianchi",
    ),
    co-supervisor: ( // Optional, leave `name` empty to omit
        title: "Dott.",
        name: "",
    ),
)

// Load bibliography entries
// Can be referenced in slides with e.g. `#cite(<entry>, form: "...")`
#show bibliography: none
#bibliography("bibliography.yaml", style: "springer-basic-author-date")

// +--------+
// | Slides |
// +--------+

#slide[
    #set align(horizon)
    = Title
    This is an awesome slide.
]

// ...
