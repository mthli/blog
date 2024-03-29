module.exports = {
  siteMetadata: {
    title: 'mthli.xyz',
    author: 'Matthew Lee',
    description: 'Yet another blog of Matthew Lee 👀',
    siteUrl: 'https://mthli.xyz',
    social: {
      twitter: 'mth_li',
    },
  },
  plugins: [
    {
      resolve: 'gatsby-source-filesystem',
      options: {
        path: `${__dirname}/content/blog`,
        name: 'blog',
      },
    },
    {
      resolve: 'gatsby-source-filesystem',
      options: {
        path: `${__dirname}/content/assets`,
        name: 'assets',
      },
    },
    {
      resolve: 'gatsby-transformer-remark',
      options: {
        plugins: [
          {
            resolve: 'gatsby-remark-external-links',
            options: {
              rel: 'noopener noreferrer',
            },
          },
          {
            resolve: 'gatsby-remark-footnotes',
            options: {
              footnoteBackRefPreviousElementDisplay: 'inline',
              footnoteBackRefDisplay: 'inline',
              footnoteBackRefAnchorStyle: 'text-decoration: none;',
            },
          },
          {
            resolve: 'gatsby-remark-images',
            options: {
              maxWidth: 1080,
              linkImagesToOriginal: false,
              showCaptions: true,
            },
          },
          {
            resolve: 'gatsby-remark-images-zoom',
            options: {
              background: 'var(--background-color)',
            },
          },
          {
            resolve: 'gatsby-remark-responsive-iframe',
            options: {
              wrapperStyle: 'margin-bottom: 1.0725rem',
            },
          },
          'gatsby-remark-code-titles',
          'gatsby-remark-copy-linked-files',
          'gatsby-remark-katex',
          'gatsby-remark-prismjs',
          'gatsby-remark-smartypants',
        ],
      },
    },
    'gatsby-transformer-sharp',
    {
      resolve: 'gatsby-plugin-google-analytics',
      options: {
        trackingId: 'UA-70441776-2',
        head: true,
      },
    },
    {
      resolve: 'gatsby-plugin-manifest',
      options: {
        name: 'mthli.xyz',
        short_name: 'mthli.xyz',
        start_url: '/',
        background_color: 'var(--background-color)',
        display: 'minimal-ui',
        icon: 'content/assets/profile-pic.jpg',
      },
    },
    {
      resolve: 'gatsby-plugin-typography',
      options: {
        pathToConfigModule: 'src/utils/typography',
      },
    },
    'gatsby-plugin-feed',
    // 'gatsby-plugin-offline',
    'gatsby-plugin-remove-serviceworker',
    'gatsby-plugin-react-helmet',
    'gatsby-plugin-sitemap',
    'gatsby-plugin-sharp',
    'gatsby-plugin-styled-jsx',
  ],
}
