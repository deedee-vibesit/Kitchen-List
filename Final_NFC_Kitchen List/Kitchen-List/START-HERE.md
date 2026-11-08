# Kitchen List

## Try it now

Unzip the download and open `site/index.html` in a desktop browser. Try the four store lists and Design Settings. Use PNG, JPG, or WebP files for the opening graphic, background, and sticker. The preview saves on that browser only. Shared mode starts with fresh lists and design settings.

## Put the shared app online

1. Create a Supabase project and run `supabase-setup.sql` in its SQL Editor.
2. In Authentication → Users, create and confirm two email-and-password accounts. Use the commented query at the bottom of the SQL file with the two real email addresses to assign the owner and shopper roles. The friend can shop in any list. The owner can also save artwork and change store names.
3. Open `site/index.html` in a text editor. Find `const config` and enter the project URL and **publishable key**. Keep secret or service-role keys out of the HTML. The app is configured to use those two accounts.
4. Sign in to [Netlify Drop](https://app.netlify.com/drop) and drag in the **site** folder. Only that folder needs to be published. Open the resulting URL on both phones. Sign in on each, add an item on one, and verify it appears on the other. Also verify that only the owner sees Design Settings. Shared mode checks for changes periodically while the app is visible and idle.
5. Write the final home-page URL to the NFC tag. Keep that same address when updating the site. Open it on your friend's iPhone and test one tap before sticking the tag in place.

Artwork and store edits saved in shared mode appear on both phones. They do not require a new upload to Netlify.

## Upload the updated version to GitHub Pages

Upload all eight files inside the site folder to the same level as README.md:
index.html, intro.gif, intro-still.jpg, pixel-flowers.svg, and the four cover-*.webp files. Commit the changes to main and
wait for GitHub Pages to redeploy. If your live index.html already contains
Supabase configuration, copy its project URL and publishable key into the
new index.html before uploading. Keep using the same GitHub Pages link for
the NFC tag. If you previously uploaded an opening graphic in Design
Settings, remove it there to use the built-in animation.
