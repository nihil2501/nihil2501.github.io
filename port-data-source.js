delete XMLHttpRequest;

require("dotenv").config();
const slugify = require("slug");

const { Client: NotionClient } = require("@notionhq/client");
const notionClient = new NotionClient({
  auth: process.env.NOTION_CLIENT_TOKEN
});

const NotionExporter = require("notion-exporter").default;
const notionExporter = new NotionExporter(
  process.env.NOTION_EXPORTER_TOKEN
);

module.exports = {
  getBlogPosts: async () => {
    const response = await notionClient.databases.query({
      database_id: process.env.NOTION_DATABASE_ID
    });

    const blogPosts = await Promise.all(
      response.results.map(async (page) => {
        const title = page.properties.Name.title.map(v => v.plain_text).join("");
        const body = await notionExporter.getMdString(page.id);
        const slug = slugify(title);

        return { title, slug, body };
      })
    );

    return blogPosts;
  },
};
