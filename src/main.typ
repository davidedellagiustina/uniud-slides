// Usage example of the uniud-slides template

#import "./uniud-slides/template.typ": *

// +-----------------------+
// | Presentation metadata |
// +-----------------------+

#show: uniud-slides.with(
    lang: "en", // Supported: 'en', 'it'
    department: "dmif", // Supported: 'dmif'
    department-override: "", // Optional, overrides `department` (if yours is unsupported)
    course: "Computer Science",
    academic-year: "2023-24",
    date: datetime.today(), // Date of the presentation
    title: "Presentation Title",
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

// Load bibliography references
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
