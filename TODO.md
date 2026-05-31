# Site TODOs

This file is excluded from deploy (`*.md` is in the deploy.sh exclude list), so it stays local.

---

## Testimonials — collect real quotes

The "What people say" section was removed from `index.html` because the placeholder quotes weren't real attributions. To put it back when you have real quotes:

### Who to ask
- **O, Miami** — Scott Cunningham or Melody Santiago (10 years of Poetry Robots)
- **Make: / Maker Faire Bay Area** — your contact from the Producer-in-Residence stint
- **Moonlighter FabLab** — board members or longtime collaborators
- **NSF / Maker Cities** — program lead
- **Frost Science** — past exhibition contact
- **DockerCon / Docker Captain (Alex Ellis)** — old colleague who can speak to the engineering side
- **A FIRST Robotics team you've judged** — student-voice quote is gold for agency rep

### What to ask for
A 1–2 sentence quote. Keep it specific. Best ones name *what* you did, not just that you're great. Examples of strong shapes:
- "Mario [did specific thing] for our [event/program], and the result was [specific outcome]." — name + title
- "When [problem] hit, Mario [action] and [outcome]." — name + title

### Drop-in HTML when you have them

Paste this back into `index.html` right before `</main>` (just after the last `</section>` of the post grid, around line 396):

```html
    <section class="testimonials">
      <p class="testimonials-title">What people say</p>
      <div class="quotes">
        <blockquote class="quote">
          <p>"REAL QUOTE 1 GOES HERE."</p>
          <cite><strong>Name</strong><br>Title, Organization</cite>
        </blockquote>

        <blockquote class="quote">
          <p>"REAL QUOTE 2 GOES HERE."</p>
          <cite><strong>Name</strong><br>Title, Organization</cite>
        </blockquote>

        <blockquote class="quote">
          <p>"REAL QUOTE 3 GOES HERE."</p>
          <cite><strong>Name</strong><br>Title, Organization</cite>
        </blockquote>
      </div>
    </section>
```

The CSS for `.testimonials`, `.quote`, etc. already exists in `css/style.css` and was kept in place — just paste the HTML above when ready.

### Original placeholder text (for reference / inspiration only — not real)

> *"Mario brings the maker spirit to everything he touches — he turns festivals into classrooms and classrooms into festivals."*

> *"His Poetry Robots are the reason a generation of Miami kids think technology and poetry belong together."*

> *"You want Mario in the room. He builds, he ships, and he makes everyone around him want to do the same."*

---

## Other deferred items

- **`speaking.html`** is on hold (excluded from deploy). Local file is at `/speaking.html`. When ready to relaunch: remove `--exclude "speaking.html"` from `deploy.sh` and add the Speaking nav link back to all pages.
- **Real on-stage photo** for Speaking page hero (you didn't have one when we built it).
