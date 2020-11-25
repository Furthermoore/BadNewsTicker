// works if pasted into a browser's "Inspect Element" / Developer Tools console

// for testing: irrelevant to algorithm, gets HTML document content, minus outermost <html> and </html>
const html = document.body.parentElement.innerHTML;

// TODO: this still contains HTML entities
const arrayOfArticles = html
    // NB: replace does not mutate, it returns a new string
    .replace(/^[\s\S]*BEGIN: StoryGrid/g, "")
    .replace(/<END: StoryGrid[\s\S]*$/g, "")
    .split('alt="')
    .slice(1) // remove first element
    .map((string) => string.replace(/"[\s\S]*$/g, ""))
    .filter((string) => string != "") // remove empty strings
    .slice(0, -1) // remove last element
