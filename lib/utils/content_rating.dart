/// Enum for the content rating
/// for more information about the content filters
/// https://developers.giphy.com/docs/optional-settings/#language-support
///
/// [g] Contains images that are broadly accepted as appropriate and commonly witnessed by people in a public environment.
/// [PG] Contains images that are commonly witnessed in a public environment, but not as broadly accepted as appropriate.
/// [PG_13] Contains images that are typically not seen unless sought out, but still commonly witnessed.
/// [R] Contains images that are typically not seen unless sought out and could be considered alarming if witnessed.

enum ContentRating {
  g,
  PG,
  PG_13,
  R,
}
